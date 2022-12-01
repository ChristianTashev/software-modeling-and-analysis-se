CREATE DATABASE MatanskiDb
USE MatanskiDb

Create table Users(
Id int primary key,
EmailAddress varchar(60),
Password varchar(60),
FirstName varchar(60),
LastName varchar(60),
Age int,
Sex varchar(6));

Create table Cars(
Id int primary key IDENTITY(1,1),
Brand varchar(60));

Create table Models(
Id int primary key,
EngineId int foreign key references Engines(id),
Name varchar(30),
ManufactureDate datetime,
EvroStandart varchar(30),
Cathegory varchar(30));

Create table Engines(
Id int primary key,
Name varchar(30),
HorsePower int,
EngineType varchar(30),
EngineCapacity int);

Create table CarToModel(
Id int primary key,
CarId int foreign key references Cars(Id),
ModelId int foreign key references Models(Id));

Create table Ads(
Id int primary key,
UserId int foreign key references Users(Id),
CarToModelId int foreign key references CarToModel(Id),
Price int,
Currancy varchar(30),
Mileage int,
CarColor varchar(30),
Equipment varchar(300),
Information varchar(300));

drop table cars

INSERT INTO Users(Id, EmailAddress, Password, FirstName, LastName,Age,Sex)
VALUES (1, 'johnny@gmail.com', 'pass123', 'Ivan','Ivanov', 18,'male'),
       (2, 'josdsdy@gmail.com', 'pass1233', 'Kris','Stoyanov', 28,'male'),
       (3, 'johsdsdsdsdnny@gmail.com', 'pass1234', 'Stoyan','Ivanov', 38,'male'),
       (4, 'johdfdfdsfdsfdnny@gmail.com', 'pass1253', 'Krasimir','Petkanov', 48,'male');

INSERT INTO Cars(Brand)
VALUES ('Mercedes'),
       ('BMW'),
       ('Skoda'),
       ('Lada');

INSERT INTO Engines(Id,EngineCapacity,EngineType,HorsePower,Name)
VALUES (1, 1600,'Petrol',90,'OM2136'),
       (2, 5600,'Petrol',900,'OM2222'),
       (3, 2000,'Disel',90,'OM3376'),
       (4, 3000,'Petrol',230,'OM2122');

INSERT INTO Models(Id, Cathegory,EngineId,EvroStandart,ManufactureDate,Name)
VALUES (2, 'Van', 4, 'Evro 5','10/22/2001','Ceed'),
       (3, 'Sedan', 4, 'Evro 3','10/22/2021','Manchester'),
       (4, 'Bus', 4, 'Evro 2','10/22/2011','Toronto'),
       (5, 'Wagon', 4, 'Evro 1','10/22/2005','E class');

INSERT INTO CarToModel(Id,CarId,ModelId)
VALUES (1, 1, 2),
       (2, 2, 4),
       (3, 3, 3),
       (4, 4, 1);

INSERT INTO Ads(Id,CarColor,CarToModelId,Currancy,Equipment,Information,Mileage,Price,UserId)
VALUES (1, 'Red', 4, 'Lv','heated seats','broken left window',26000,20000,1),
       (2, 'Blue', 3, 'Lv','double heated mirrors','broken right window',360000,23000,2),
       (3, 'White', 2, 'Lv','air bag','no air filter',460000,244000,3),
       (4, 'Yellow', 1, 'Lv','disttronic','has winter tiers',560000,20000,4);



CREATE PROCEDURE ShowMeSomething
AS
SELECT a.CarColor, a.Mileage, a.Price, u.FirstName, u.LastName
FROM Ads as a
LEFT JOIN CarToModel as cm ON (a.CarToModelId = cm.Id)
LEFT JOIN Users as u ON (a.UserId = u.Id)
ORDER BY a.Mileage desc

EXEC ShowMeSomething;



CREATE FUNCTION OldOrNewCar (
	@mileage INT
)
RETURNS CHAR(3) AS
BEGIN
	DECLARE @return_value CHAR(3);
	SET @return_value = 'old';
    IF (@mileage > 20000) SET @return_value = 'old';
    IF (@mileage < 20000) SET @return_value = 'new';
 
    RETURN @return_value
END;

select *,dbo.OldOrNewCar(Ads.Mileage) as Conclusion From Ads;


CREATE TRIGGER dbo.MyTriggerV3
ON Ads
FOR INSERT
AS
INSERT INTO dbo.Cars(Brand) values('BrandGeneratedByTrigger')


INSERT INTO Ads(Id,CarColor,CarToModelId,Currancy,Equipment,Information,Mileage,Price,UserId)
VALUES (46,'Red', 4, 'Lv','Magnetic Cup holders','broken right window',2100,25030,1);
select * from Cars