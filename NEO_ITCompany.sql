--CREAREA BAZEI DE DATE SI A FISIERELOR AFERENTE

CREATE DATABASE ITCompany
ON PRIMARY
(
Name = PrimaryData,
FileName = 'C:\ProjectBD\Primary.mdf',
size = 10MB, -- KB, Mb, GB, TB
maxsize = unlimited,
filegrowth = 1GB
),
FILEGROUP fgCurrent
(
Name = DataA,
FileName = 'C:\ProjectBD\GroupA.ndf',
size = 10MB, -- KB, Mb, GB, TB
maxsize = unlimited,
filegrowth = 1GB
),
(
Name = DataB,
FileName = 'C:\ProjectBD\GroupB.ndf',
size = 10MB, -- KB, Mb, GB, TB
maxsize = unlimited,
filegrowth = 1GB
),
(
Name = DataC,
FileName = 'C:\ProjectBD\GroupC.ndf',
size = 10MB, -- KB, Mb, GB, TB
maxsize = unlimited,
filegrowth = 1GB
),
FILEGROUP fgArchive
(
Name = ArchiveData,
FileName = 'C:\ProjectBD\Archive.ndf',
size = 10MB, -- KB, Mb, GB, TB
maxsize = unlimited,
filegrowth = 1GB
)
LOG ON
(
Name = DataLogA,
FileName = 'C:\ProjectBD\LogA.ldf',
size = 10MB, -- KB, Mb, GB, TB
maxsize = unlimited,
filegrowth = 1024MB
).
(
Name = DataLogB,
FileName = 'C:\ProjectBD\LogB.ldf',
size = 10MB, -- KB, Mb, GB, TB
maxsize = unlimited,
filegrowth = 1024MB
)


--CREAREA TABELELOR

--1.	Crearea tabelei RAM care contine tipurile de memorie RAM pe care le poate avea un model.

IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;
create table RAM(
RAMID int not null primary key,
MemoryType varchar(50),
Maximum int
)

--2.	Crearea tabelei  Storage care contine tipurile de memorie nevolatila pe care le poate avea un model.

IF OBJECT_ID('Storage', 'U') IS NOT NULL DROP TABLE Storage;
create table Storage(
StorageID int not null primary key,
StorageType varchar(50) not null,
Capacity int not null
)

--3.	Crearea tabelei Screen care contine tipurile si caracteristicile referitoare la ecranul unui device.

IF OBJECT_ID('Screen', 'U') IS NOT NULL DROP TABLE Screen;
create table Screen(
ScreenID int not null primary key,
ScreenType varchar(50) not null,
Resolution varchar(50),
Dimension int,
TouchScreen bit not null,
Details varchar(50) 
)

--4.	Creare tabelei Processors care contine caracteristicile procesorului aferent fiecarui model.

IF OBJECT_ID('Processors', 'U') IS NOT NULL DROP TABLE Processors;
create table Processors(
ProcessorID int not null primary key,
Generation varchar(50),
Cores int not null,
Frequency decimal(2,2) ,
Cache int 
)

--5.	Crearea tabelei Products care contine categoriile de produse produse de catre companie.

IF OBJECT_ID('Products', 'U') IS NOT NULL DROP TABLE Products;
CREATE TABLE Products (
ProductID int NOT NULL PRIMARY KEY,
Category varchar(50) NOT NULL
)

--6.	Crearea tabelei OS care contine detalii referitoare la sistemul de operare continut de fiecare model.

IF OBJECT_ID('OS', 'U') IS NOT NULL DROP TABLE OS;
create table OS(
OSID int not null primary key,
Bits int not null,
OSVersion varchar(20)
)

--7.	Crearea tabelei WiFi care contine detalii referitoare la protocoalele de functionare WiFi continut de fiecare model.

IF OBJECT_ID('WiFi', 'U') IS NOT NULL DROP TABLE WiFi;
create table WiFi(
WiFiID int not null primary key,
ProtocolName varchar(30),
Speed int
)

--8.	Crearea tabelei Updates care contine detalii referitoare la actualizarile pentru fiecare model.

IF OBJECT_ID('Updates', 'U') IS NOT NULL DROP TABLE Updates;
create table Updates(
UpdateID int not null primary key,
UpdateDescription varchar(100) ,
ReleaseDate datetime not null,
Predecesor int FOREIGN KEY REFERENCES Updates(UpdateID),
ProductID int 
)

--9.	Crearea tabelei ExternalPorts care contine detalii referitoare la porturile ce se afla pe un device

IF OBJECT_ID('ExternalPorts', 'U') IS NOT NULL DROP TABLE ExternalPorts;
create table ExternalPorts(
PortID int not null Primary key,
PortName varchar(10) not null
)

--10.	Crearea tabelei AddIns care contine caracteristicile pe care un device le poate avea in plus fata de cele oligatorii.

IF OBJECT_ID('AddIns', 'U') IS NOT NULL DROP TABLE AddIns;
create table AddIns(
ID int not null Primary key,
AddInName nvarchar(20),
Details nvarchar(100)
)

--11.	Crearea tabelei Models care contine deltalii referitoare la modelele produse de catre complanie

IF OBJECT_ID('Models', 'U') IS NOT NULL DROP TABLE Models;
create table Models(
ModelID int not null primary key,
ModelName varchar(50) not null,
RAMID int not null,
StorageID int,
ProcessorID int not null,
ScreenID int not null,
ProductID int not null,
OSID int not null, 
Color varchar(10) ,
Weights decimal(2,2),
ReleaseDate datetime not null,
WIFI int ,
Guarantee int,
Stock int,
Price float
)

--12.	Crearea tabelei Links care va fi o tabela de join pentru Models si ExternalPorts (un model poate avea mai multe porturi si un tip de Port se poate afla pe mai multe modele)

IF OBJECT_ID('Links', 'U') IS NOT NULL DROP TABLE Links;
create table Links(
ModelID int not null,
PortID int not null,
Quantity int 
)

--13.	Crearea tabelei Details care va fi o tabela de join intre Models si AddIns (un model poate contine mai multe features si un feature se poate afla pe mai multe modele de produse)
IF OBJECT_ID('Details', 'U') IS NOT NULL DROP TABLE Details;
create table Details(
ModelID int not null,
AddInID int not null
)

--14.	Crearea tabelei Projects care contine detalii referitoare la proiectele de dezvoltare de noi modele pe care le desfasoara compania

IF OBJECT_ID('Projects', 'U') IS NOT NULL DROP TABLE Projects;
create table Projects (
ProjectID int not null primary key,
ProductID int,
StartDate datetime,
DueDate datetime,
Investment int
)

--15.	Crearea tabelei Employees care contine detalii referitoare la angajatii companiei.

IF OBJECT_ID('Employees', 'U') IS NOT NULL DROP TABLE Employees;
create table Employees
(
EmployeeID int not null primary key,
ProjectID int not null,
FirstName nvarchar(20) not null,
LastName nvarchar(20),
ExtraHours int ,
Seniority int,
PersonalDeduction int not null,
Email nvarchar (50)
)

--16.	Crearea tabelei Seniority care contine detalii referitoare la joburile din cadrul companiei pe care le pot avea angajatii.

IF OBJECT_ID('Seniority', 'U') IS NOT NULL DROP TABLE Seniority;
create table Seniority(
Seniority int not null primary key,
SeniorityName nvarchar(30),
BruteSalary int not null,
Statetax int not null,
MinHours int not null,
BonusForExtraHours int 
)

--17.	Crearea tabelei CommonErrors care tine evidenta tuturor erorilor si a solutiilor acestora care au fost intampinate pe parcursul utilizarii produselor de catre clienti.

IF OBJECT_ID('CommonErrors', 'U') IS NOT NULL DROP TABLE CommonErrors;
create table CommonErrors(
ErrorID int not null Primary Key,
Characteristics varchar(100),
Solution varchar(100)
)

--18.	Crearea tabelei ErrorBuffer (tabela de join) care tine evidenta tuturor erorilor pentru fiecare model in parte (un model poate avea mai multe erori si o eroare poate fi pe mai multe modele).

IF OBJECT_ID('ErrorBuffer', 'U') IS NOT NULL DROP TABLE ErrorBuffer;
create table ErrorBuffer(
ErrorID int ,
ModelID int
)

use ITCompany;

--1.	Constrangeri DEFAULT pentru tabela Models

ALTER TABLE Models ADD CONSTRAINT DF_Model_RAMID DEFAULT (100) FOR RAMID;
ALTER TABLE Models ADD CONSTRAINT DF_Model_StorageID DEFAULT (200) FOR StorageID;
ALTER TABLE Models ADD CONSTRAINT DF_Model_ProcessorID DEFAULT (300) FOR ProcessorID;
ALTER TABLE Models ADD CONSTRAINT DF_Model_OSID DEFAULT (200) FOR OSID;
ALTER TABLE Models ADD CONSTRAINT [DF_Model_WiFi] DEFAULT (800) FOR WIFI;
ALTER TABLE Models ADD CONSTRAINT [DF_Model_Screen] DEFAULT (1000) FOR ScreenID;

--2.	Constrangeri de Foreign Key pentru tabela Models ON DELETE CASCADE

ALTER TABLE Models ADD CONSTRAINT [FK_ProductCategory] FOREIGN KEY(ProductID) REFERENCES Products (ProductID) ON DELETE CASCADE

--3.	Constrangeri de Foreign Key pentru tabela Models ON DELETE SET DEFAULT

ALTER TABLE Models WITH CHECK
ADD CONSTRAINT FK_RAMOnModel FOREIGN KEY (RAMID) REFERENCES RAM(RAMID) ON DELETE SET DEFAULT,
CONSTRAINT FK_WiFiOnModel FOREIGN KEY (WIFI) REFERENCES WiFi(WiFiID) ON DELETE SET DEFAULT, 
CONSTRAINT FK_StorageOnModel FOREIGN KEY (StorageID) REFERENCES Storage(StorageID) ON DELETE SET DEFAULT,
CONSTRAINT FK_ProcessorOnModel FOREIGN KEY (ProcessorID) REFERENCES Processors(ProcessorID) ON DELETE SET DEFAULT,
CONSTRAINT FK_ScreenOnModel FOREIGN KEY (ScreenID) REFERENCES Screen(ScreenID) ON DELETE SET DEFAULT,
CONSTRAINT FK_OSOnModel FOREIGN KEY (OSID) REFERENCES OS(OSID) ON DELETE SET DEFAULT

--4.	Constrangeri de chei externe pentru tabela Updates

ALTER TABLE Updates
ADD CONSTRAINT FK_PredecesorUpdate FOREIGN KEY (Predecesor) REFERENCES Updates(UpdateID), 
CONSTRAINT FK_ProductUpdate FOREIGN KEY (ProductID) REFERENCES Products(ProductID) ON DELETE CASCADE

--5.	Constrangere de cheie externa pentru tabela Projects

ALTER TABLE Projects
ADD CONSTRAINT FK_NewProject
FOREIGN KEY (ProductID) REFERENCES Products(ProductID) on delete cascade

--6.	Constrangeri DEFAULT pentru tabela Employees

ALTER TABLE Employees ADD CONSTRAINT [DF_Project_For_Employee] DEFAULT (1000) FOR ProjectID;
ALTER TABLE Employees ADD CONSTRAINT [DF_Seniority_For_Employee] DEFAULT (1) FOR Seniority;

--7.	Constrangeri de chei externe pentru tabela Employees

ALTER TABLE Employees ADD CONSTRAINT [FK_WorkinOnProject] FOREIGN KEY(ProjectID) REFERENCES Projects (ProjectID) ON DELETE SET DEFAULT

ALTER TABLE Employees ADD CONSTRAINT [FK_EmployeeSeniority] FOREIGN KEY(Seniority) REFERENCES Seniority (SeniorityID) ON DELETE SET DEFAULT

--8.	Constrangeri de chei straine pentru tabela de join ErrorBuffer intre Models si CommonErrors--

ALTER TABLE ErrorBuffer
ADD CONSTRAINT FK_ErrorsOnModels FOREIGN KEY (ErrorID) REFERENCES CommonErrors(ErrorID) ON DELETE CASCADE, 
CONSTRAINT FK_ModelsWithErrors FOREIGN KEY (ModelID) REFERENCES Models(ModelID) ON DELETE CASCADE

--9.	Constrangeri de chei straine pentru tabela de join Links intre Models si ExternalPorts

ALTER TABLE Links
ADD CONSTRAINT FK_PortsOnModel FOREIGN KEY (PortID) REFERENCES ExternalPorts(PortID)ON DELETE CASCADE, 
CONSTRAINT FK_ModelsWithPorts FOREIGN KEY (ModelID) REFERENCES Models(ModelID)ON DELETE CASCADE

--10.	Constrangeri de chei straine pentru tabela de join Details intre Models si AddIns

ALTER TABLE Details
ADD CONSTRAINT FK_AddInsOnModel FOREIGN KEY (AddInID) REFERENCES AddIns(ID)ON DELETE CASCADE, 
CONSTRAINT FK_ModelsWithAddIns FOREIGN KEY (ModelID) REFERENCES Models(ModelID)ON DELETE CASCADE

--INSERAREA DATELOR

use ITCompany;

--1.	Inserare de date in tabela RAM

insert into RAM(RAMID,MemoryType,Maximum) values
(100,'LPDDR4X',7),
(101,'DDR4',16),
(102,'DDR4',48),
(103,'LPDDR3',16),
(104,'Micro SD',64),
(105,'Micro SD',32),
(106,'NVMe',64),
(107,'NVMe',64)

--2.	Inserare de date in tabela Screen

insert into Screen(ScreenID,ScreenType,Resolution,Dimension,TouchScreen,Details) values
(1000,'LED','1920 x 1080',15,1,'Full HD'),
(1001,'LED','1366 x 768',15,0,'HD Antireflex'),
(1002,'LED','1920 x 1080',14,0,'Full HD Antireflex'), 
(1003,'OLED','2048 x 1536',13,1,'QXGA'), 
(1004,'LED','1920 x 1080',23,0,'HD Antireflex'), 
(1005,'LED IPS','1920 x 1080',24,0,'HD sRGB Anti-Glare'), 
(1006,'LCD IPS','3840 x 2160',27,0,'HDR 400'), 
(1007,'LCD Multi-Touch','1792 x 828',6,1,'Liquid Retina HD'), 
(1008,'Super Retina XDR','2436 x 1125',5,1,'Super Retina XDR display'), 
(1009,'Super Retina XDR','2778 x 1284',7,1,'Display OLED HDR'), 
(1010,'TFT','2000 x 1200',10,1,'WUXGA+'), 
(1011,'Super AMOLED Plus','	2800 x 1752',12,1,'WQXGA+'),
(1012,'	LTPS TFT','	2560 x 1600',12,1,'WQXGA+') 

--3.	Inserare de date in tabela Processors

insert into Processors(ProcessorID,Generation,Frequency,Cache) values
(300,'Intel i7',4,0.4,6),
(301,'AMD Ryzen 7',6,0.9,16),
(302,'AMD Ryzen 5',6,0.5,3),
(303,'Intel i7',6,0.8,12),
(304,'OctaCore',8,0.8,null)

--4.	Inserare de date in tabela Storage

insert into Storage(StorageID,StorageType,Capacity) values
(200,'SSD',256),
(201,'SSHD',256),
(203,'SSD',1000),
(204,'SSD',512),
(205,'SSD',2000),
(206,'special flash',512),
(207,'special flash',256),
(208,'special flash',256),
(209,'special flash',256)

--5.	Inserare de date in tabela Products

insert into Products(ProductID,Category) values
(1,'laptop'),
(2,'tableta'),
(3,'smartphone'),
(4,'desktop')

--6.	Inserare de date in tabela RAM

insert into Models(ModelID,ModelName,RAMID,StorageID,ProcessorID,ScreenID,OSID,Color,ReleaseDate,Guarantee,ProductID,Stock,Price,WIFI) values
(1,'Neo Laptop Gen21',100,204,300,1000,200,'black',getDate(),null,1,2000,2500,802),
(2,'Neo Phone Gen21',106,206,304,1007,210,'black',getDate(),null,3,1000,1000,802),
(3,'Neo Laptop Gen21',103,null,304,1011,211,'black','2021-02-02',null,2,1000,1000,802),
(4,'Neo Laptop Gen21',100,204,304,1000,200,null,getDate(),2,1,2000,2500,804),
(5,'Neo Laptop Gen16',103,202,303,1003,200,'white','02-02-2016',2,1,1000,2000,801),
(6,'Neo Laptop Gen17x',100,205,303,1002,200,'white','02-02-2017',2,1,1000,3000,802),
(7,'Neo Laptop Gen19',100,205,303,1003,201,'grey','02-02-2019',3,1,1000,3000,802),
(8,'Neo Laptop 15',101,200,302,1001,200,'black','02-02-2015',2,1,500,1000,800),
(9,'Neo Phone Gen 19X',106,206,304,1007,210,'white','02-02-2019',2,3,1400,500,804),
(10,'Neo Phone Gen 20',106,206,304,1008,210,'black','02-03-2020',1,3,400,900,804)

--7.	Inserare de date in tabela Projects

insert into Projects(ProjectID,ProductID,Name,StartDate,DueDate,Investment) values
(1000,1,'Neo Laptop X2021','10.10.2020','10.10.2021',200000),
(1001,3,'Neo Phone XX3K','1.12.2021','1.06.2021',1000000),
(1002,2,'Neo Tablet 256+','3.03.2021','10.09.2021',10000000),
(1003,1,'Neo Laptop GenZ','01-03-2021','01-03-2022',900000),
(1004,2,'Neo Phone GenZ','01-03-2021','01-09-2021',450000)

--8.	Inserare de date in tabela Updates

insert into Updates(UpdateID,UpdateDescription,ReleaseDate,Predecesor,ProductID) values
(1,'ICloud for Windows 12.3','06-04-2021',2,3),
(2,'ICloud for Windows 11.5','02-12-2020',3,3),
(3,'ICloud for Windows 7.21','04-09-2020',null,3),
(4,'neoTunes on Android 11.1.3','03-05-2021',5,2),
(5,'neoTunes on Android 11.2.3', '08-03-2021',6,2),
(6,'neoTunes on Android 11.3.3','12-01-2021',null,2),
(7,'Version 2001 for Windows','01-05-2001',8,1),
(8,'Version 2004 for Windows','01-05-2004',9,1),
(9,'Version 20H2 for Windows','01-05-2020',10,1),
(10,'Version 21H1 for Windows','01-05-2021',null,1)

--9.	Inserare de date in tabela AddIns

insert into AddIns(ID,AddInName,Details) values
(1,'Tastatura iuluminata',null),
(2,'Tastatura numerica',null),
(3,'Webcam', 'HD IR'),
(4,'Microfon',null),
(5,'Webcam', 'HD 720p'),
(6,'Difuzor', '2 W'),
(7,'Difuzor', '0.8 W'),
(8,'Difuzor', 'Stereo'),
(9,'Unitate optica', null),
(10,'Facial recognition',null),
(11,'Wireless charging',null),
(12,'GPS','GLONASS'),
(13,'GPS','Galileo'),
(14,'5G',null),
(15,'Front camera','32MP'),
(16,'Front camera','12MP')

--10.	Inserare de date in tabela ExternalPorts

insert into ExternalPorts(PortID,PortName) values
(1,'USB C'),
(2,'Jack 3.5'),
(3,'USB 2.0'),
(4,'USB 3.1 A'),
(5,'USB 3.1 C'),
(6,'HDMI'),
(7,'RJ45'),
(8,'VGA')

--11.	Inserare de date in tabela CommonErrors

Insert into CommonErrors(ErrorID,Characteristics,Solution) values
(1,'Rapid Battery Drain',null),
(2,'Damage due to water',null),
(3,'Not getting charged','Change battery'),
(4,'Touchscreen is not working','Restart device'),
(5,'Heating up followed by shut down','Keep laptop on flat, hard surfaces'),
(6,'Black screen','Unplug the power and remove the battery'),
(7,'No network connection','Make sure wireless is turned on and router is broadcasting network name'),
(8,'Stuck pixels','Massage away dead pixels')

--12.	Inserare de date in tabela OS

insert into OS(OSID,OSVersion,Bits) values
(200,'Windows 10 Pro',64),
(201,'Windows 10 Home',64),
(202,'Windows 10 S',64),
(203,'Free DOS',32),
(204,'Mac OS Big Sur',64),
(205,'Mac OS Catalina',64),
(206,'Debian',64),
(207,'Ubuntu',64),
(208,'Linux Mint',64),
(209,'Arch Linux',64),
(210,'AndroidV10',64),
(211,'AndroidV8',64)

--13.	Inserare de date in tabela WiFi

INSERT INTO WiFi (WiFiID,Specification, DataRate, ModulationScheme, SecurityProtocol) values
(800,'802.11','1/2 Mbps','FHSS','WEP/WPA'),
(801,'802.11','1/2 Mbps','DSSS','WEP/WPA'),
(802,'802.11a','54 Mbps','OFDM','WEP/WPA'),
(803,'802.11b','11 Mbps','DSSS with CCK','WEP/WPA'),
(804,'802.11g','54 Mbps','OFDM','WEP/WPA')

--14.	Inserare de date in tabela ErrorBuffer

insert into ErrorBuffer(ErrorID,ModelID) values
(1,1),
(5,1),
(5,4),
(6,6),
(1,6),
(7,7),
(7,8),
(2,10),
(2,9),
(2,2),
(2,1)

--15.	Inserare de date in tabela Links

insert into Links (ModelID,PortID,Quantity) values
(1,2,1),
(1,5,2),
(1,6,1),
(1,8,1),
(4,2,1),
(4,6,3),
(4,7,2),
(7,6,2),
(7,8,1),
(7,5,2)

--16.	Inserare de date in tabela Details

insert into Details(ModelID,AddInID) values
(1,1),
(1,2),
(1,3),
(1,4),
(2,11),
(2,10),
(2,9),
(2,15),
(4,1),
(4,2),
(4,5),
(4,4),
(5,1),
(6,2),
(7,1),
(7,2),
(10,16),
(10,14),
(10,11),
(10,10),
(11,14)

--17.	Inserare de date in tabela Seniority

INSERT INTO Seniority(SeniorityID,SeniorityName,MinHours,BonusForExtraHours) values
(1,'Manager',100000,8,40),
(2,'Office Manager',9000,8,20),
(3,'Supervisor',7000,8,20),
(5,'Professional Staff',5000,8,15),
(5,'Part-time Staff',1500,4,5)

--18.	Inserare de date in tabela Employees

INSERT INTO Employees(EmployeeID,ProjectID,FirstName,LastName,ExtraHours,Seniority,PersonalDeduction) VALUES 
(1,1000,'Ion','Ionescu',0,5,0),
(2,1000,'Vasile','Popescu',8,1,0),
(3,1000,'Ana','Marinescu',10,4,0),
(4,1000,'Andreea','Ionescu',8,4,0),
(5,1000,'Alexandru','Marin',6,2,0),
(6,1000,'Victor','Andreescu',6,3,800),
(7,1000,'Ion','Ene',0,5,0),
(8,1003,'Maria','Alexe',6,1,815),
(9,1003,'Dana','Budeanu',6,2,0),
(10,1003,'Andrei','Pop',8,3,0),
(11,1003,'Magdalena','Nen',4,3,0),
(12,1003,'Monica','Andrei',0,1,500)

--INTEROGARI DE SELECTIE

use ITCompany;

--1.	Modele de laptopuri cu ecran Full HD

select M.ModelName as [Model Name], S.ScreenType as Type , S.Dimension as Dimensions
from Products as P
inner join Models as M
on P.ProductID= M.ProductID
inner join Screen as S
on S.ScreenID=M.ScreenID
where P.Category='laptop' and  S.Details='Full HD'
 
--2.	Modele de laptopuri cu procesor mai puternic de 4GhZ

select M.ModelName as [Model Name], M.Price as Price, Pr.Frequency *10 as Freq
from Products as P
inner join Models as M
on P.ProductID= M.ProductID
inner join Processors as Pr
on Pr.ProcessorID=M.ProcessorID
where P.Category='laptop' and Pr.Frequency>0.4
 
--3.	Modelele de laptop care au porturi HDMI si cate porturi de acest gen au

select M.ModelName as [Model Name],L.Quantity as [Number of HDMI Ports]
from Models as M
inner join Links as L
on M.ModelID=L.ModelID
inner join ExternalPorts as EP
on EP.PortID=L.PortID
where EP.PortName='HDMI'
 
--4.	Erorile si solutiile pentru modelele de laptopuri aparute in 2021

select M.ModelName as Model, CE.Characteristics as Error, CE.Solution as Solution
from CommonErrors as CE
inner join ErrorBuffer as EB
on EB.ErrorID=CE.ErrorID
inner join Models as M
on M.ModelID=EB.ModelID
inner join Products as P
on M.ProductID=P.ProductID
where M.ModelName like '%21' and P.Category='laptop'
 
--5.	Modelele de laptopuri care au sistemul de operare ‘Windows 10 Pro’

select M.ModelName as ModelName, OS.Bits as NumberOfBits
from Models as M
inner join OS as OS
on OS.OSID=M.OSID
where OS.OSVersion='Windows 10 Pro'
 
--6.	Toate modelele care inca mai functioneaza cu un sistem de operare pe 32 de biti

select M.ModelName as ModelsName, OS.OSVersion as Versiune
from Models as M
inner join OS 
on OS.OSID=M.OSID
where OS.Bits=32
 
--7.	Ultimul update pentru telefoane

select top 1 U.UpdateDescription,U.ReleaseDate 
from Updates as U
inner join Products as P
on P.ProductID=U.ProductID
where P.Category='smartphone'
order by year(ReleaseDate),Month(ReleaseDate)
 
--8.	Modele mai noi de 2018 si mai ieftine de 3000 care sunt pe stock

select ModelName as [Model Name], Price as Price
from Models as M
inner join Products as P
on P.ProductID=M.ProductID
where YEAR(ReleaseDate)>2018 and Price <3000 and Stock >0 and P.Category='smartphone'
order by Price asc 

--9.	Media stocurilor pt fiecare produs

select avg(M.Stock) as AverageStocks , P.Category as Category
from Models as M 
inner join Products as P
on M.ProductID = P.ProductID
group by P.Category

--10.	Media investitiilor pentru fiecare categorie de produse

select avg(P.Investment) as InvestitiiMedii, P.ProductID as Produs, Pr.Category as Category
from Projects as P
inner join Products as Pr
on Pr.ProductID=P.ProductID
group by P.ProductID,Pr.Category

--11.	Cate proiecte  de noi laptopuri sunt in desfasurare in total

select count(P.ProjectID) as [Proiecte Laptopuri]
from Projects as P
inner join Products as Pr
on Pr.ProductID=P.ProductID
group by Pr.Category
having Pr.Category='laptop' 

--12.	Investitiile totale pentru proiectele incepute in 2021

select sum(P.Investment), Year(P.StartDate)
from Projects as P
inner join Products as Pr
on P.ProductID=Pr.ProductID
group by Year(P.StartDate)
having year(P.StartDate)=2021

--13.	Cati angajati obisnuiti (staff)  lucreaza la un proiect

select count(*) as [Total Staff]
from Projects as P 
inner join Employees as E
on P.ProjectID=E.ProjectID
inner join Seniority as S
on E.Seniority=S.SeniorityID
where P.ProjectID=1000 and S.SeniorityName like '%Staff'

--14.	Bonusul pentru orele muncite in plus pentru fiecare angajat

select E.FirstName +' '+ E.LastName as Name ,ExtraHours*S.BonusForExtraHours as ExtraMoney
from Employees as E
inner join Seniority as S
on E.Seniority = S.SeniorityID
where E.ExtraHours <>0

--15.	Cat lucreaza in medie un angajat pe postul de Supervisor

select AVG(GWH.[Total Working Hours])
from GetWorkingHours as GWH
inner join Seniority as S
on GWH.Title = S.SeniorityName
where S.SeniorityName='Supervisor'

--16.	Numele Managerilor pentru proiectele de dezvoltare laptopuri

select E.FirstName +' ' +E.LastName as [Manager Name],P.Name as [Project Name] , P.StartDate , P.DueDate
from Products as Pr
inner join  Projects as P 
on P.ProductID = Pr.ProductID
inner join Employees as E
on E.ProjectID=P.ProjectID
inner join Seniority as S
on S.SeniorityID=E.Seniority
where S.SeniorityName='Manager' and Pr.Category='laptop'

--17.	Aflam modelul de laptop cu cel mai mare numar de porturi pe el care este la cel mai mic pret

select top 1 *
from CountPorts as CP
inner join Models as M
on M.ModelName = CP.Model
order by CP.PortsOnModel desc, M.Price asc

--18.	Aflam cate porturi USB are fiecare model de laptop

select M.ModelName as Model, Quantity as Quantity
from Products as P
inner join Models as M
on P.ProductID=M.ProductID
inner join Links as L
on M.ModelID=L.ModelID
inner join ExternalPorts as EP
on EP.PortID=L.PortID
where EP.PortName like 'USB%' and P.Category='laptop'

--19.	Proiectele de dezvoltare a noi laptopuri cu investitii mai mari de 500.000

select Sum(Pr.Investment) as Investments , Pr.Name as Name
from Projects as Pr
inner join Products as P 
on Pr.ProductID=P.ProductID
where P.Category='laptop'
group By Pr.Name
having Sum(Pr.Investment)>500000

--20.	Aflam cate ore a muncit in plus fiecare categorie de angajati la proiectul cu id-ul 1000

select S.SeniorityName as Seniority, sum(E.ExtraHours) as Total
from Employees as E
inner join Seniority as S
on S.SeniorityID=E.Seniority
where E.ProjectID=1000
group by S.SeniorityName

--21.	Aflam cate erori au intampinat utilizatorii la produsele mai scumpe de 2000

select M.ModelName as Model ,count(E.ErrorID) as [Total Number of Errors]
from CommonErrors as E
inner join ErrorBuffer as EB
on EB.ErrorID=E.ErrorID
inner join Models as M 
on M.ModelID=EB.ModelID
where M.Price>2000
group by M.ModelName

--22.	Cate modele au fiecare tip de memorie cu capacitate >= 512 GB

Select count(S.StorageType) as Total , S.Capacity as Capacity, S.StorageType as Type
from Models as M
inner join Storage as S
on M.StorageID=S.StorageID
where S.Capacity >= 512
group by S.Capacity, S.StorageType

--23.	Numaram cate modele au procesoare cu 6 core-uri, grupate pe frecventa si ordonate descrescator

select Count(M.ModelID) as [Number of Models], P.Cores as Cores, P.Frequency *100 as Frequency
from Models as M
inner join Processors as P 
on M.ProcessorID=P.ProcessorID
group by P.Cores,P.Frequency
having P.Cores=6
order by P.Frequency desc

--24.	Cate feluri de tastatura are fiecare model de laptop

select count(A.AddInName) as Cate,M.ModelName as ModelName
from Models as M
inner join Details as D
on M.ModelID=D.ModelID
inner join AddIns as A
on A.ID=D.AddInID
where A.AddInName like 'Tastatura%'
group by M.ModelName

--25.	Ce features are modelul de smartphone aparut in 2021

select M.ModelName as Model, A.AddInName as Feature
from Products as P
inner join Models as M
on M.ProductID=P.ProductID
inner join Details as D
on M.ModelID=D.ModelID
inner join AddIns as A
on A.ID=D.AddInID
where P.Category='smartphone' and M.ModelName like '%21'

--EXPRESII DE TABEL COMUNE (CTE)

--1.	CTE pentru a afla cate proturi USB sunt pe fiecare dispozitiv

with c as(
select SUM(L.Quantity) as Suma, EP.PortName AS Port, M.ModelName as Model
from Models as M
inner join Links as L
on M.ModelID=L.ModelID
inner join ExternalPorts as EP
on L.PortID=EP.PortID
group by  EP.PortName,M.ModelName
having EP.PortName like 'USB%'
)
select Sum(Suma) as Suma, Model as Model
from c
group by Model

--2.	CTE pentru a afla telefonul cel mai ieftin care are ecranul cel mai mare

with ScreenCTE as(
select S.Dimension as Dimension,M.ModelName as Model,M.Price as Price
from Products as P 
inner join
Models as M
on M.ProductID=P.ProductID
inner join Screen as S
on M.ScreenID=S.ScreenID
where S.TouchScreen=1 and P.Category='smartphone'
)
select top(1) Dimension as MaxDim , Model as ModelWithLargestScreen, Price as Price
from ScreenCTE
order by Dimension desc, Price asc

--3.	CTE pentru a afla laptopul cu cel mai performant procesor (cel mai mare numar de core-uri si cea mai mare frecventa)

with MaxCoresCTE as
(
select max(Cores) as MaxCores, max(Frequency) as Frequency,M.ModelID as ID
from Processors as P
inner join Models as M
on M.ProcessorID=P.ProcessorID
inner join Products as Pr
on Pr.ProductID=M.ProductID
group by M.ModelID,Pr.Category
having  Pr.Category='laptop'
)
select top 1 MC.MaxCores,M.ModelName,M.Price,M.Guarantee ,MC.Frequency*10
from MaxCoresCTE as MC
inner join Models as M
on M.ModelID=MC.ID
order by MC.MaxCores desc , MC.Frequency desc, Price asc

--4.	CTE pentru verificarea performantei maxime atinse de produsele companiei pentru fiecare produs in parte la nivel de memorie RAM

with MaxRAM as(
select max(RAM.Maximum) as MaxRam, M.ProductID as ProductID
from RAM 
inner join Models as M
on RAM.RAMID = M.RAMID
group by M.ProductID
),
MaxRamCont as(
select MaxRam as MaxRam , P.Category as Category
from MaxRAM as MR
inner join Products as P
on P.ProductID=MR.ProductID
)
select * from MaxRamCont

--5.	CTE pentru a determina primul Update aparut pe laptopurile companiei si cate updateuri au mai aparut pana in prezent (Distance)

with UpdatesCTE AS
(
SELECT UpdateID, Predecesor AS Predecesor, UpdateDescription, 0 AS Distance
FROM Updates
WHERE UpdateID=10
UNION ALL
SELECT P.UpdateID,P.Predecesor AS Predecesor, P.UpdateDescription, S.Distance + 1 AS Distance
FROM UpdatesCTE AS S
JOIN Updates AS P
ON S.Predecesor = P.UpdateID
)
SELECT top 1 *
FROM UpdatesCTE
order by Distance desc

--6.	CTE pentru a obcontine descrierea ultimul update pentru laptopuri

with GetUpdateCTE as 
(
select max(UpdateID) as ID
from Updates as U
inner join Products as P
on U.ProductID=P.ProductID
where P.Category='laptop'
)
select U.UpdateDescription as Description
from GetUpdateCTE as CTE
inner join Updates as U
on CTE.ID=U.UpdateID
where U.UpdateID=CTE.ID

--7.	CTE pentru a determina cate proiecte  de telefoane mobile sunt in desfasurare pana la sfarsitul anului 2021

with DateCTE as (
select P.ProjectID as ProjectID, P.DueDate as Date
from Projects as P
inner join Products as Pr
on Pr.ProductID=P.ProductID
where YEAR(P.DueDate)=2021 and Month(P.DueDate)<=12 and Pr.Category='smartphone'
)
select count(ProjectID) as [How Many Laptop Projects]
from DateCTE

--VIZUALIZARI

use ITCompany;

--1.	View pentru calcularea banilor luati de catre fiecare angajat
IF OBJECT_ID('GetIntake', 'V') IS NOT NULL DROP VIEW GetIntake;
create view GetIntake 
as
select E.FirstName as FirstName,E.LastName as LastName,E.EmployeeID as ID,(100-S.StateTax)*S.ButeSalary/100+E.ExtraHours*S.BonusForExtraHours as Intake 
from Seniority as S
inner join Employees as E
on S.SeniorityID=E.Seniority

select * from GetIntake
order by Intake desc

--2.	View pentru a calcula cate ore lucreaza in total fiecare angajat

IF OBJECT_ID('GetWorkingHours', 'V') IS NOT NULL DROP View GetWorkingHours;
create view GetWorkingHours
as
select E.ExtraHours+S.MinHours as [Total Working Hours],E.FirstName+' '+E.LastName as Name, S.SeniorityName as Title
from Employees as E
inner join Seniority as S
on E.Seniority=S.SeniorityID

select * from GetWorkingHours

--3.	View pentru a afla cate porturi se afla pe fiecare model

IF OBJECT_ID('CountPorts', 'V') IS NOT NULL DROP View CountPorts;

create view CountPorts
as
(
select count(*) as PortsOnModel,  M.ModelName as Model
from Models as M
inner join Links as L
on M.ModelID=L.ModelID
inner join ExternalPorts as EP
on Ep.PortID=L.PortID
group by M.ModelName
)
select * from CountPorts

--4.	View pentru a putea determina cate tipuri de tastatura au are fiecare model de laptop

IF OBJECT_ID('ViewKeyboard', 'V') IS NOT NULL DROP View ViewKeyboard;
create view ViewKeyboard
as
select M.ModelName as Model,count(A.ID) as [Number of Keyboard Types]
from Products as P
inner join Models as M
on P.ProductID=M.ProductID
inner join Details as D
on D.ModelID=M.ModelID
inner join AddIns as A
on A.ID=D.AddInID
where P.Category='laptop' and A.AddInName like 'Tastatura%'
group By M.ModelName

select * from ViewKeyboard 
where [Number of Keyboard Types] = 2
 
--5.	View pentru a vedea modelele care au pentru care nu s-a gasit inca solutie

IF OBJECT_ID('ViewErrors', 'V') IS NOT NULL DROP View ViewErrors;
create view ViewErrors
as
select M.ModelID as Model, M.Price as Price, E.Characteristics as Error
from Models as M
inner join ErrorBuffer as EB
on M.ModelID=EB.ModelID
inner join CommonErrors as E
on E.ErrorID=EB.ErrorID
where E.Solution is NULL

select count(Model) as HowMany , Error as Error
from ViewErrors 
group by Error

--6.	View pentru a cate laptopuri sunt pe stoc

IF OBJECT_ID('TotalLaptops', 'V') IS NOT NULL DROP View TotalLaptops;
create view TotalLaptops
as
select sum(M.Stock) as Stock
from Models as M
inner join Products as P
on M.ProductID=P.ProductID
where P.Category='laptop' and M.Stock is not null

select * from TotalLaptops

--INTEROGARI DE SELECTIE

use ITCompany;

--1.	Modele de laptopuri cu ecran Full HD

select M.ModelName as [Model Name], S.ScreenType as Type , S.Dimension as Dimensions
from Products as P
inner join Models as M
on P.ProductID= M.ProductID
inner join Screen as S
on S.ScreenID=M.ScreenID
where P.Category='laptop' and  S.Details='Full HD'
 
--2.	Modele de laptopuri cu procesor mai puternic de 4GhZ

select M.ModelName as [Model Name], M.Price as Price, Pr.Frequency *10 as Freq
from Products as P
inner join Models as M
on P.ProductID= M.ProductID
inner join Processors as Pr
on Pr.ProcessorID=M.ProcessorID
where P.Category='laptop' and Pr.Frequency>0.4
 
--3.	Modelele de laptop care au porturi HDMI si cate porturi de acest gen au

select M.ModelName as [Model Name],L.Quantity as [Number of HDMI Ports]
from Models as M
inner join Links as L
on M.ModelID=L.ModelID
inner join ExternalPorts as EP
on EP.PortID=L.PortID
where EP.PortName='HDMI'
 
--4.	Erorile si solutiile pentru modelele de laptopuri aparute in 2021

select M.ModelName as Model, CE.Characteristics as Error, CE.Solution as Solution
from CommonErrors as CE
inner join ErrorBuffer as EB
on EB.ErrorID=CE.ErrorID
inner join Models as M
on M.ModelID=EB.ModelID
inner join Products as P
on M.ProductID=P.ProductID
where M.ModelName like '%21' and P.Category='laptop'
 
--5.	Modelele de laptopuri care au sistemul de operare ‘Windows 10 Pro’

select M.ModelName as ModelName, OS.Bits as NumberOfBits
from Models as M
inner join OS as OS
on OS.OSID=M.OSID
where OS.OSVersion='Windows 10 Pro'
 
--6.	Toate modelele care inca mai functioneaza cu un sistem de operare pe 32 de biti

select M.ModelName as ModelsName, OS.OSVersion as Versiune
from Models as M
inner join OS 
on OS.OSID=M.OSID
where OS.Bits=32
 
--7.	Ultimul update pentru telefoane

select top 1 U.UpdateDescription,U.ReleaseDate 
from Updates as U
inner join Products as P
on P.ProductID=U.ProductID
where P.Category='smartphone'
order by year(ReleaseDate),Month(ReleaseDate)
 
--8.	Modele mai noi de 2018 si mai ieftine de 3000 care sunt pe stock

select ModelName as [Model Name], Price as Price
from Models as M
inner join Products as P
on P.ProductID=M.ProductID
where YEAR(ReleaseDate)>2018 and Price <3000 and Stock >0 and P.Category='smartphone'
order by Price asc 

--9.	Media stocurilor pt fiecare produs

select avg(M.Stock) as AverageStocks , P.Category as Category
from Models as M 
inner join Products as P
on M.ProductID = P.ProductID
group by P.Category

--10.	Media investitiilor pentru fiecare categorie de produse

select avg(P.Investment) as InvestitiiMedii, P.ProductID as Produs, Pr.Category as Category
from Projects as P
inner join Products as Pr
on Pr.ProductID=P.ProductID
group by P.ProductID,Pr.Category

--11.	Cate proiecte  de noi laptopuri sunt in desfasurare in total

select count(P.ProjectID) as [Proiecte Laptopuri]
from Projects as P
inner join Products as Pr
on Pr.ProductID=P.ProductID
group by Pr.Category
having Pr.Category='laptop' 

--12.	Investitiile totale pentru proiectele incepute in 2021

select sum(P.Investment), Year(P.StartDate)
from Projects as P
inner join Products as Pr
on P.ProductID=Pr.ProductID
group by Year(P.StartDate)
having year(P.StartDate)=2021

--13.	Cati angajati obisnuiti (staff)  lucreaza la un proiect

select count(*) as [Total Staff]
from Projects as P 
inner join Employees as E
on P.ProjectID=E.ProjectID
inner join Seniority as S
on E.Seniority=S.SeniorityID
where P.ProjectID=1000 and S.SeniorityName like '%Staff'

--14.	Bonusul pentru orele muncite in plus pentru fiecare angajat

select E.FirstName +' '+ E.LastName as Name ,ExtraHours*S.BonusForExtraHours as ExtraMoney
from Employees as E
inner join Seniority as S
on E.Seniority = S.SeniorityID
where E.ExtraHours <>0

--15.	Cat lucreaza in medie un angajat pe postul de Supervisor

select AVG(GWH.[Total Working Hours])
from GetWorkingHours as GWH
inner join Seniority as S
on GWH.Title = S.SeniorityName
where S.SeniorityName='Supervisor'

--16.	Numele Managerilor pentru proiectele de dezvoltare laptopuri

select E.FirstName +' ' +E.LastName as [Manager Name],P.Name as [Project Name] , P.StartDate , P.DueDate
from Products as Pr
inner join  Projects as P 
on P.ProductID = Pr.ProductID
inner join Employees as E
on E.ProjectID=P.ProjectID
inner join Seniority as S
on S.SeniorityID=E.Seniority
where S.SeniorityName='Manager' and Pr.Category='laptop'

--17.	Aflam modelul de laptop cu cel mai mare numar de porturi pe el care este la cel mai mic pret

select top 1 *
from CountPorts as CP
inner join Models as M
on M.ModelName = CP.Model
order by CP.PortsOnModel desc, M.Price asc

--18.	Aflam cate porturi USB are fiecare model de laptop

select M.ModelName as Model, Quantity as Quantity
from Products as P
inner join Models as M
on P.ProductID=M.ProductID
inner join Links as L
on M.ModelID=L.ModelID
inner join ExternalPorts as EP
on EP.PortID=L.PortID
where EP.PortName like 'USB%' and P.Category='laptop'

--19.	Proiectele de dezvoltare a noi laptopuri cu investitii mai mari de 500.000

select Sum(Pr.Investment) as Investments , Pr.Name as Name
from Projects as Pr
inner join Products as P 
on Pr.ProductID=P.ProductID
where P.Category='laptop'
group By Pr.Name
having Sum(Pr.Investment)>500000

--20.	Aflam cate ore a muncit in plus fiecare categorie de angajati la proiectul cu id-ul 1000

select S.SeniorityName as Seniority, sum(E.ExtraHours) as Total
from Employees as E
inner join Seniority as S
on S.SeniorityID=E.Seniority
where E.ProjectID=1000
group by S.SeniorityName

--21.	Aflam cate erori au intampinat utilizatorii la produsele mai scumpe de 2000

select M.ModelName as Model ,count(E.ErrorID) as [Total Number of Errors]
from CommonErrors as E
inner join ErrorBuffer as EB
on EB.ErrorID=E.ErrorID
inner join Models as M 
on M.ModelID=EB.ModelID
where M.Price>2000
group by M.ModelName

--22.	Cate modele au fiecare tip de memorie cu capacitate >= 512 GB

Select count(S.StorageType) as Total , S.Capacity as Capacity, S.StorageType as Type
from Models as M
inner join Storage as S
on M.StorageID=S.StorageID
where S.Capacity >= 512
group by S.Capacity, S.StorageType

--23.	Numaram cate modele au procesoare cu 6 core-uri, grupate pe frecventa si ordonate descrescator

select Count(M.ModelID) as [Number of Models], P.Cores as Cores, P.Frequency *100 as Frequency
from Models as M
inner join Processors as P 
on M.ProcessorID=P.ProcessorID
group by P.Cores,P.Frequency
having P.Cores=6
order by P.Frequency desc

--24.	Cate feluri de tastatura are fiecare model de laptop

select count(A.AddInName) as Cate,M.ModelName as ModelName
from Models as M
inner join Details as D
on M.ModelID=D.ModelID
inner join AddIns as A
on A.ID=D.AddInID
where A.AddInName like 'Tastatura%'
group by M.ModelName

--25.	Ce features are modelul de smartphone aparut in 2021

select M.ModelName as Model, A.AddInName as Feature
from Products as P
inner join Models as M
on M.ProductID=P.ProductID
inner join Details as D
on M.ModelID=D.ModelID
inner join AddIns as A
on A.ID=D.AddInID
where P.Category='smartphone' and M.ModelName like '%21'

--ACTUALIZARI DE DATE (UPDATE)

use ITCompany; 

--1.	Schimbarea numelui de familie in urma unei casatorii a angajatei Ana Marinescu

select * from Employees

DECLARE @oldFullName NVARCHAR(30) = 'Ana Marinescu';
DECLARE @newLastName NVARCHAR(30) = 'Popescu';
UPDATE E
SET E.LastName = @newLastName
FROM Employees AS E
WHERE CONCAT(E.FirstName, ' ', E.LastName) = @oldFullName

select * from Employees

--2.	Completarea adreselor de email pentru toti angajatii

select * from Employees

DECLARE @Counter INT ,
		@MaxId INT,
		@email as varchar(50);
SELECT @Counter = min(EmployeeID) , 
		@MaxId = max(EmployeeID)
FROM Employees
 
WHILE( @Counter <= @MaxId)
BEGIN 
  update E
  set E.Email = E.FirstName + '.' + E.LastName + '@neo.com'
  from Employees as E
  where E.Email is null
  --set email variable for printing
  select @email = Email from Employees where EmployeeID = @Counter
  PRINT CONVERT(VARCHAR,@Counter) + '. employee''s email address is  ' + @email  
  SET @Counter  = @Counter  + 1        
END

select * from Employees
 
--3.	Scaderea pretului cu 15% pentru produsele aparute mai devreme de 2018

select M.ModelName as Model, M.Price as Price from Models as M where YEAR(ReleaseDate) <= 2018

declare @sale real = 0.15;
update M 
set M.Price += M.Price * @sale
from Models as M
where YEAR(M.ReleaseDate) <= 2018

select M.ModelName as Model, M.Price as Price from Models as M where YEAR(ReleaseDate) <= 2018

--4.	Avansarea angajatilor part-time pe pozitia de angajat profesional pentru toti angajatii part time care au lucrat pe proiecte de dezvoltare a noi modele de laptopuri

select * from Employees

update E
set E.Seniority -=1
from Seniority as S
inner join Employees as E
on E.Seniority = S.SeniorityID
inner join Projects as P
on E.ProjectID= P.ProjectID
inner join Products as Pr
on Pr.ProductID=P.ProductID
where Pr.Category='laptop' and S.SeniorityName like 'Part-time%'

select * from Employees

--5.	Cresterea numarului de ore care trebuie lucrate in plus de angajatii care lucreaza la proiecte ce trebuie predate luna aceasta

update E 
set E.ExtraHours +=2
from Employees as E
inner join Projects as P
on P.ProjectID= E.ProjectID
where year(P.DueDate) = 2021 and MONTH(P.DueDate) = 5

--6.	Cresterea cantitatii de porturi HDMI pentru modelele de laptop aparute in 2021

 update L
set L.Quantity+=1
from Products as P
inner join Models as M
on M.ProductID = P.ProductID
inner join Links as L
on L.ModelID=M.ModelID
inner join ExternalPorts as EP
on EP.PortID = L.PortID 
where EP.PortName like 'HDMI' and year(M.ReleaseDate) = 2021 and P.Category='laptop'

--7.	Cresterea lunilor de garantie si a pretului telefoanelor mobile care aveau garantia mai mica de 2 luni

DECLARE @value INT = 2,
		@productName varchar(10) = 'smartphone',
		@priceUp real = 0.05;
UPDATE M
SET M.Guarantee += @value, M.Price +=@priceUp
FROM Models as M
inner join Products as P
on P.ProductID = M.ProductID 
where P.Category = @productName and M.Guarantee < 2

--8.	Schimba protocolul de securitate pe care functioneaza produsele

select * from WiFi

DECLARE @Counter INT ,
		@MaxId INT,
		@oldProtocol as varchar(50) = 'WEP/WPA',
		@newProtocol as varchar(50) = 'WPA 3';
SELECT @Counter = min(WiFiID) , 
		@MaxId = max(WiFiID)
FROM WiFi
 
WHILE( @Counter <= @MaxId)
BEGIN
  update W
  set W.SecurityProtocol = @newProtocol
  from WiFi as W
  where W.SecurityProtocol = @oldProtocol
  SET @Counter  = @Counter  + 1        
END

select * from WiFi

--9.	Creste pretul tututor telefoanelor care au capacitatea memoriei RAM de 64 GB

DECLARE @capacity INT = 64,
		@productName varchar(10) = 'smartphone',
		@priceUp real = 0.10;
select * from Models where ProductID = 3;
update M
set M.Price += M.Price * @priceUp
from Products as P
inner join Models as M
on M.ProductID = M.ProductID
inner join RAM as R
on M.RAMID = R.RAMID
where P.Category = @productName and R.Maximum = @capacity
select * from Models where ProductID = 3;
 
--10.	Setarea mesajului de ‘No error yet’ pentru erorile care au solutiile pe NULL

select * from CommonErrors where Solution is NULL;

declare @basicString as varchar(30) = 'No solution yet'
update CE
set CE.Solution = @basicString
from CommonErrors as CE
where CE.Solution is NULL;

select * from CommonErrors

--11.	Marirea cu 2 luni a datei de predare a proiectelor la care lucreaza mai putin de 6 angajati

select * from Projects

;With CountEmpoyees as
(
select count(*) as Total, P.ProjectID as ProjectID
from Employees as E
inner join Projects as P
on E.ProjectID=P.ProjectID
group by P.ProjectID
)
update P
set P.DueDate = dateadd(month,2, P.DueDate)
from Projects as P
inner join CountEmpoyees as CE
on P.ProjectID = CE.ProjectID
where CE.Total <6
select * from Projects
 
--12.	Discount pentru toate modelele de produse care au prezentat prea multe erori
 
with ErrorsCTE as
(
select count(*) as ErrorCount,M.ModelID as ID,M.ModelName as Model
from Models as M
inner join ErrorBuffer as EB
on EB.ModelID=M.ModelID
inner join CommonErrors as CE
on EB.ErrorID=CE.ErrorID
group by M.ModelID,M.ModelName
)
update M
set M.Price -= M.Price*0.1
from Models as M
inner join ErrorsCTE as E
on M.ModelID=E.ID
where E.ErrorCount >=3
select ModelName, Price from Models
 
--13.	Modificarea in intreaga tabela a ID-ului produsului din gama respectiva de update-uri daca se constata ca nu e corect produsul la care face referire update-ul respectiv

select *from Updates where ProductID=2
DECLARE 
		@update INT,
		@predecesorID int,
		@oldProduct int = 2,
		@newProduct int = 3;
SELECT @update = max(UpdateID)  FROM Updates where ProductID = @oldProduct;
select @predecesorID = Predecesor from Updates where UpdateID = @update
WHILE( @predecesorID  is not null)
BEGIN
  update U
  set U.ProductID=@newProduct
  from Updates as U
  where U.UpdateID=@update
  set @update = @predecesorID
  select @predecesorID = Predecesor from Updates where UpdateID = @update    
END
select * from Updates where ProductID=3

--14.	Update de crestere a pretului fiecarui model de telefon care are mai mult de 3 feature-uri

;with DetailsCTE as 
( select count(*) as Total, M.ModelID as Model
from Models as M
inner join Details as D
on D.ModelID=M.ModelID
inner join AddIns as A
on A.ID=D.AddInID
group by M.ModelID
)
update M
set M.Price += M.Price *0.20
from DetailsCTE as DC
inner join Models as M
on M.ModelID = DC.Model
inner join Products as P 
on P.ProductID = M.ProductID
where DC.Total >= 4 and P.Category = 'smartphone'
 
--15.	Updatam ca telefoanele care aveau memoria RAM maxim de 32 de GB pe 64 de GB

declare @oldRam as varchar(30);
select @oldRam = R.MemoryType
from Products as P
inner join Models as M
on P.ProductID =M.ProductID
inner join RAM as R
on M.RAMID = R.RAMID
where P.Category = 'smartphone'
Update M
set M.RAMID = R.RAMID
from Models as M
inner join RAM as R
on M.RAMID = R.RAMID
where R.MemoryType = @oldRam and R.Maximum = 64

--STERGERE DE DATE (DELETE)

use ITCompany;

--1.	Stergerea tututor modelelor care au mai mult de 2 erori.
 
;with BadModels as(
select count(*) as TotalErrors,M.ModelID as Model
from Models as M
inner  join ErrorBuffer as EB
on EB.ModelID=M.ModelID
inner join CommonErrors as CE
on CE.ErrorID = EB.ErrorID
group by M.ModelID
having count(M.ModelID) >2
)
delete M
from Models as M
inner join BadModels as BM
on M.ModelID = BM.Model
select * from Models
 
--Nota: Se vor sterge si inregistarile referite prin constrangerea de stergerre in cascada din tabelele aferente.

--2.	Sergerea modelelor de tablete care functioneaza cu un model de RAM de capacitate prea mica

select * from Models where ProductID = 2
declare @minCapacity int =16;
select * from RAM where Maximum <= @minCapacity
delete M
from Products as P
inner join Models as M
on P.ProductID=M.ProductID
inner join RAM as R
on M.RAMID = R.RAMID
where R.Maximum <= @minCapacity and P.Category = 'tablet'

select * from Models where ProductID = 2
 
--3.	Stergerea acelor feature-uri care nu mai sunt des utilizate in prezent

declare @frequency int = 2;
;with CTEFrequentlyUsedAddIns as (
select count(A.ID) as Total, A.ID as ID
from AddIns as A
inner join Details as D
on A.ID=D.AddInID
group by A.ID
having count(A.ID) <@frequency
)
delete A
from AddIns as A
inner join CTEFrequentlyUsedAddIns as CTE
on CTE.ID = A.ID
select * from AddIns

--4.	Stergerea tututor Update-urilor din aceeasi serie care se refereau la un anumit tip de produs.

select * from Updates where ProductID = 2;

declare @product int =2,
		@max int,
		@predecesor int;
select @max = max(UpdateID) from Updates where ProductID = @product;
select @predecesor=Predecesor from Updates where ProductID = @product;
while @predecesor is not NULL
begin
	delete U
	from Updates as U
	where U.UpdateID=@max;
	set @max = @predecesor;
	select @predecesor = Predecesor from Updates where UpdateID=@max;
end;
--delete last item
	delete U from Updates as U where UpdateID=@max;
select * from Updates where ProductID = 2;
 

--5.	Stergerea tuturor angajatilor angajati part-time care lucreaza la un anumit proiect.

select * from Employees 
declare @project varchar(50) = 'Neo Laptop X2021';
delete E
from Seniority as S
inner join Employees as E
on E.Seniority=S.SeniorityID
inner join Projects as P
on E.ProjectID = P.ProjectID
where S.SeniorityName like 'Part-time%' and P.Name = @project;
select * from Employees
 
--6.	Stergerea produselor care nu au mai primit un update de 20 de ani si inca au un stock ridicat (nu au fost cumparate)

select * from Updates where year(ReleaseDate) <2002
select * from Models 
select * from Products

;with UpdatesCTE as(
select Max(year(ReleaseDate)) as LastYear, ProductID as ProductID
from Updates
group by ProductID
)
delete P
from Products as P
inner join UpdatesCTE as CTE
on P.ProductID = CTE.ProductID
inner join Models as M
on P.ProductID = M.ProductID
where M.Stock >1000 and LastYear <2002

select * from Models 
select * from Products

--7.	Stergerea categoriilor de memorie RAM care au capacitatea mai mica decat o valoare data si nu au id-ul default.  Inregistarile care refereau tipul respectiv de RAM sters vor ontine acum valoarea default.

declare @minCap int =16;
select * from Models
delete RAM
where Maximum <=@minCap
select * from Models
  
--8.	Stergerea modelelor invechite (care mai au port VGA)

select * from ExternalPorts where PortName like 'VGA'
select * from Links where PortID = 8
delete M
from Models as M
inner join Links as L
on M.ModelID = L.ModelID
inner join ExternalPorts as EP
on EP.PortID = L.PortID
where EP.PortName = 'VGA'

select * from Models where ModelID = 7
select * from Links where PortID = 8

--9.	Stergerea proiectelor a caror data de predare a fost depasita.

begin transaction
delete P
from Projects as P
where DueDate<GETDATE()
rollback;

--10.	Stergerea angajatilor care lucreaza la proiecte in care nu s-a investit nimic

begin transaction
delete E 
from Employees as E
inner join Projects as P
on P.ProjectID = E.ProjectID
where P.Investment is NULL
rollback
 
--11.	Stergerea produselor care au mai putin de 2  modele pe piata

begin transaction
;with ModelsCTE as (
select count(ModelID) as TotalModel ,ProductID as Product
from Models
group by ProductID
)
delete P
from ModelsCTE as CTE
inner join Products as P
on P.ProductID = CTE.Product 
where CTE.TotalModel <3
rollback;

--12.	Stergerea modelelor invechite pentru care exista proiecte de noi produse

select * from Models where year(ReleaseDate) <2018
select * from Projects
begin transaction
delete M
from Models as M
inner join Products as P
on P.ProductID = M.ProductID
inner join Projects as Pr
on Pr.ProductID=P.ProductID
where M.ModelID <2018
rollback;

--Nota: Numarul de 6 inregistrari sterse vine de la constrangerea de stegere in cascada.

--13.	 Stergerea Modelelor care au un sistem de operare invechit, un procesor len si memorie insuficienta.

begin transaction

;with ModelCTE as(
select M.ModelID as ModelID, M.ProcessorID as ProcessorID
from Storage as S 
inner join Models as M
on S.StorageID = M.StorageID
where S.Capacity <300
)
delete Models
from Models as M
inner join ModelCTE as CTE
on M.ModelID = CTE.ModelID
inner join Processors as P
on P.ProcessorID=CTE.ProcessorID
where P.Frequency <0.5
rollback;

--14.	Stergerea tuturor tipurilor de ecrane care nu sunt folosite pe modele noi

begin transaction
;with ScreenCTE as(
select count(M.ScreenID) as Total, M.ScreenID as ScreenID
from Models as M
group by M.ScreenID
)
delete S
from Screen as S
inner join ScreenCTE as CTE
on CTE.ScreenID=S.ScreenID
where CTE.Total<2
rollback;
      
--Nota: In tabela Models se va completa cu valoarea default datorita constrangerii existente.

--15.	Stergerea tuturor Superviserilor care lucreaza in proiecte care se intind pe mai mult de 2 ani.

begin transaction
delete E
from Projects as P
inner join Employees as E
on E.ProjectID = P.ProjectID
inner join Seniority as S
on S.SeniorityID = E.Seniority
where S.SeniorityName = 'Office Manager' and DATEDIFF(year,P.StartDate,P.DueDate)>2
rollback;

--PROCEDURI STOCATE

use ITCompany;

--1.	Procedura pentru determinarea stocului pentru fiecare produs

IF OBJECT_ID('GetStockForProduct', 'P') IS NOT NULL DROP PROC GetStockForProduct; 
CREATE PROC GetStockForProduct
	@product AS VARCHAR(30), 
	@numRows AS INT = 0 OUTPUT 
AS 
BEGIN 
	select sum(M.Stock) as Stock
	from Models as M
	inner join Products as P
	on M.ProductID=P.ProductID
	where P.Category=@product and M.Stock is not null
	SET @numRows = @@ROWCOUNT
	RETURN; 
END

DECLARE @numRowsReturned AS INT;
EXEC GetStockForProduct 
	@product ='smartphone', 
	@numRows = @numRowsReturned OUTPUT;
SELECT @numRowsReturned AS 'Number of rows returned'

--2.	Procedura care calculeaza salariul unui angajat

IF OBJECT_ID('GetSalaryForEmployee', 'P') IS NOT NULL DROP PROC GetSalaryForEmployee; 
CREATE PROC GetSalaryForEmployee
	@firstName AS VARCHAR(30), 
	@lastName AS VARCHAR(30), 
	@salary as int output,
	@numRows AS INT = 0 OUTPUT

AS 
BEGIN 
	select @salary = S.ButeSalary *(100-S.StateTax)/100 + E.ExtraHours*S.BonusForExtraHours + E.PersonalDeduction
	from Employees as E
	inner join Seniority as S
	on E.Seniority=S.SeniorityID
	where E.FirstName=@firstName and E.LastName=@lastName
	SET @numRows = @@ROWCOUNT
	RETURN; 
END

DECLARE @numRowsReturned AS INT;
declare @salaryRetuned as int;
EXEC GetSalaryForEmployee 
	@firstName='Alexandru',
	@lastName='Marin',
	@numRows = @numRowsReturned OUTPUT,
	@salary= @salaryRetuned output;

select @salaryRetuned as 'This is the final salary'
SELECT @numRowsReturned AS 'Number of rows returned'

--3.	Procedura care afiseaza modelele care au un storage mai mare de 512 GB dar care au inca erori nerezolvate 

IF OBJECT_ID('GetUnsolvedErrors', 'P') IS NOT NULL DROP PROC GetUnsolvedErrors; 
CREATE PROC GetUnsolvedErrors
	@desiredStorage AS int, 
	@numRows AS INT = 0 OUTPUT

AS 
BEGIN 
	select M.ModelName as Model, count(*) as Total
	from Storage as S
	inner join Models as M
	on S.StorageID=M.StorageID
	inner join ErrorBuffer as EB
	on M.ModelID=EB.ModelID
	inner join CommonErrors as E
	on E.ErrorID=EB.ErrorID
	where S.Capacity>=  @desiredStorage and E.Solution is NULL --@desiredStorage
	group by M.ModelName
	SET @numRows = @@ROWCOUNT
	RETURN; 
END

DECLARE @numRowsReturned AS INT;

EXEC GetUnsolvedErrors 
	@desiredStorage = 512, 
	@numRows = @numRowsReturned OUTPUT;

SELECT @numRowsReturned AS 'These models of required storage by buyer have unresolved errors'

--4.	Procedura care creste cu un anume procent bonusul primit de o anumita categorie de angajati pentru orele muncite in plus

IF OBJECT_ID('UpdateBonus', 'P') IS NOT NULL DROP PROC UpdateBonus; 
CREATE PROC UpdateBonus
	@seniority AS varchar(30),
	@bonus as int,
	@numRows AS INT = 0 OUTPUT
AS 
BEGIN 
	update S
	set S.BonusForExtraHours+=@bonus
	from Employees as E
	inner join Seniority as S
	on S.SeniorityID=E.Seniority
	where S.SeniorityName =  @seniority and E.ExtraHours>0
	SET @numRows = @@ROWCOUNT
	RETURN; 
END

DECLARE @numRowsReturned AS INT;

EXEC UpdateBonus 
	@seniority ='Manager',
	@bonus =-10,
	@numRows = @numRowsReturned OUTPUT;

select  E.ExtraHours as Hours, S.BonusForExtraHours as BonusBefore
from Employees as E inner join Seniority as S on E.Seniority=S.SeniorityID 
where S.SeniorityName='Manager'
SELECT @numRowsReturned AS 'The number of employees with a pay rise'

--5.	Procedura care determina managerul care coordoneaza un anumit proiect

IF OBJECT_ID('GetProjectManager', 'P') IS NOT NULL DROP PROC GetProjectManager; 
CREATE PROC GetProjectManager
	@projectName AS varchar(30),
	@numRows AS INT = 0 OUTPUT
AS 
BEGIN 
	select E.FirstName + ' ' + E.LastName as Name
	from Projects as P
	inner join Employees as E
	on E.ProjectID=P.ProjectID
	inner join Seniority as S 
	on S.SeniorityID=E.Seniority
	where P.Name=@projectName and S.SeniorityName='Manager'
	SET @numRows = @@ROWCOUNT
	RETURN; 
END

DECLARE @numRowsReturned AS INT;
EXEC GetProjectManager 
	@projectName='Neo Laptop GenZ',
	@numRows = @numRowsReturned OUTPUT;
SELECT @numRowsReturned AS 'The number of employees with a pay rise'

--6.	Procedura care mareste/micsoreaza data de predare a unui proiect cu o luna in functie de parametrul dat (parametrul @months poate fi de asemenea negativ)

IF OBJECT_ID('UpdateDueDate', 'P') IS NOT NULL DROP PROC UpdateDueDate; 
CREATE PROC UpdateDueDate
	@projectName AS varchar(30),
	@months as int,
	@numRows AS INT = 0 OUTPUT
AS 
BEGIN 
	select DueDate from Projects where Name= @projectName

	update P
	set P.DueDate = dateadd(month,@months,P.DueDate)  
	from Projects as P
	where P.Name=@projectName
	SET @numRows = @@ROWCOUNT

	select DueDate from Projects where Name= @projectName
	RETURN; 
END

DECLARE @numRowsReturned AS INT;
EXEC UpdateDueDate 
	@projectName='Neo Laptop GenZ',
	@months = 2,
	@numRows = @numRowsReturned OUTPUT;
SELECT @numRowsReturned AS 'Retuned rows'

--7.	Procedura care elimina o versiune invechita si nefolosita de wifi si schimba in tabela de modele verisunea de wifi cu una noua pentru modelele care functionau pe cea veche

IF OBJECT_ID('RemoveObsoleteWifi', 'P') IS NOT NULL DROP PROC RemoveObsoleteWifi; 
CREATE PROC RemoveObsoleteWifi
	@wifiVersion AS varchar(30),
	@newWifiVersion as Varchar(30),
	@numRows AS INT = 0 OUTPUT,
	@id as int output
AS 
BEGIN 
	select * from WiFi
	delete from WiFi where Specification = @wifiVersion
	select * from WiFi
	
	select @id = WiFiID
	from WiFi
	where WiFi.Specification=@newWifiVersion
	
	select * from Models
	update Models set WIFI=@id where WIFI is NULL
	select * from Models

	SET @numRows = @@ROWCOUNT
	RETURN; 
END

DECLARE @numRowsReturned AS INT;
declare @retunedID as Int;
EXEC RemoveObsoleteWifi 
	@wifiVersion='802.11',
	@newWifiVersion='802.11g',
	@id= @retunedID OUTPUT,
	@numRows = @numRowsReturned OUTPUT;
SELECT @numRowsReturned AS 'Retuned rows'

--8.	Procedura care determina cati angajati lucreaza la un proiect

IF OBJECT_ID('GetNumberOfEmployees', 'P') IS NOT NULL DROP PROC GetNumberOfEmployees; 
CREATE PROC GetNumberOfEmployees
	@projectName as varchar(30),
	@numRows AS INT = 0 OUTPUT AS 
BEGIN 
	select @numRows= Count(E.EmployeeID)
	from Projects as P
	inner join Employees as E
	on P.ProjectID=E.ProjectID
	where P.Name=@projectName
	
RETURN; 
END

DECLARE @numRowsReturned AS INT;
EXEC GetNumberOfEmployees @projectName='Neo Laptop X2021',@numRows = @numRowsReturned OUTPUT;
SELECT @numRowsReturned AS 'Number of employees working on this project'

--9.	Procedura care modifica in baza de date pozitia unui anagajat dupa ce acesta a crescut in rang (daca nu este deja manager si nu poate avea o pozitie mai mare sau daca este angajat part-time)

IF OBJECT_ID('UpdateToHigherPosition', 'P') IS NOT NULL DROP PROC UpdateToHigherPosition; 
create proc UpdateToHigherPosition
	@firstName as varchar(30),
	@lastName as varchar(30),
	@max as int = 0 OUTPUT,
	@min as int = 0 output
AS
begin
	
	select @max=max(SeniorityID) from Seniority
	select @min=min(SeniorityID) from Seniority

	select Seniority as [Before Update] from Employees where FirstName=@firstName and LastName=@lastName
	UPDATE E
	SET E.Seniority = 
		CASE 
			WHEN E.Seniority > @min and E.Seniority < @max THEN E.Seniority-1
			WHEN E.Seniority = @min or E.Seniority = @max THEN E.Seniority	--max (Seniority) e pentru anajatii part-time care nu pot creste in rang pana nu devin full time, min(Seniority) este pentru managerul care nu poate avea o functie mai mare de atat => raman neschimbate
		END
	from Employees as E 
	inner join Seniority as S
	on E.Seniority=S.SeniorityID
	where E.FirstName=@firstName and E.LastName=@lastName

	select Seniority as [After Update] from Employees where FirstName=@firstName and LastName=@lastName
RETURN; 
END


EXEC UpdateToHigherPosition                       EXEC UpdateToHigherPosition  
	@firstName = 'Alexandru',                      @firstName = 'Ion',
	@lastName = 'Marin';                           @lastName = 'Ionescu';         

--10.	 Procedura care returneaza anumite detalii despre un anumit model 

IF OBJECT_ID('GetSpecifications', 'P') IS NOT NULL DROP PROC GetSpecifications; 
CREATE PROC GetSpecifications
	@model AS varchar(30),
	@processorType AS varchar(30) output,
	@processorCores as int output,
	@storageType as varchar(30) output,
	@screenType as varchar(30) output,
	@screenResolution as varchar(30)output,
	@wifi as varchar(30) output
AS 
BEGIN 
	select @processorType=P.Generation, @processorCores=P.Cores
	from Models as M 
	inner join Processors as P
	on M.ProcessorID=P.ProcessorID
	where M.ModelName=@model

	select @storageType = S.StorageType
	from Models as M
	inner join Storage as S
	on S.StorageID=M.StorageID
	where M.ModelName=@model

	select @screenType = S.ScreenType, @screenResolution=S.Resolution
	from Models as M
	inner join Screen as S
	on S.ScreenID=M.ScreenID
	where M.ModelName=@model

	select @wifi = W.Specification
	from Models as M
	inner join WiFi as W
	on W.WiFiID=M.WIFI
	where M.ModelName=@model

	RETURN; 
END

DECLARE
	@modelRET AS varchar(30),
	@processorTypeRET AS varchar(30) ,
	@processorCoresRET as int ,
	@storageTypeRET as varchar(30) ,
	@screenTypeRET as varchar(30) ,
	@screenResolutionRET as varchar(30),
	@wifiRET as varchar(30);

EXEC GetSpecifications 
	@model = 'Neo Laptop Gen21X',
	@processorType = @processorTypeRET output,
	@processorCores = @processorCoresRET output,
	@storageType = @storageTypeRET output,
	@screenType = @screenTypeRET output,
	@screenResolution =  @screenResolutionRET output,
	@wifi = @wifiRET output;
	
SELECT @processorTypeRET AS 'Model''s type of processor'
SELECT @processorCoresRET AS 'Model''s processor number of cores'
SELECT @storageTypeRET AS 'Model''s type of storage'
SELECT @screenTypeRET AS 'Model''s type of screen'
SELECT @screenResolutionRET AS 'Model''s screen  resolution'
SELECT @screenResolutionRET AS 'Model''s WiFi protocol'

--11.	Procedura care se ocupa cu comiterea unor tranzactii 

IF OBJECT_ID('CommitTransction', 'P') IS NOT NULL DROP PROC CommitTransction; 
CREATE PROC CommitTransction
AS
BEGIN
	IF @@TRANCOUNT > 0 
	BEGIN
		COMMIT TRAN;
		PRINT 'Transaction successfully commited';
	END;
END;

--12.	Procedura cre se ocupa cu tratarea erorilor
 
IF OBJECT_ID('CatchError', 'P') IS NOT NULL DROP PROC CatchError; 

CREATE PROC CatchError
	@errorCode AS INT
AS
BEGIN
	IF @errorCode <> 0
	BEGIN
		IF @@TRANCOUNT > 0 ROLLBACK TRAN;
		PRINT 'Transaction failed with error code '+ CAST(@errorCode AS VARCHAR);
		RETURN;
	END;
END;

--13.	Procedura care calculeaza taxele platite la stat de catre angajat.

IF OBJECT_ID('GetImpozite', 'P') IS NOT NULL DROP PROC GetImpozite; 
CREATE PROC GetImpozite
	@firstName AS VARCHAR(30), 
	@lastName AS VARCHAR(30),
	@CAS AS INT = 0 OUTPUT, 
	@CASS AS INT = 0 OUTPUT,
	@IV AS INT = 0 OUTPUT,
	@salary as int =0
AS 
BEGIN 
	--get brute salary
	select @salary = S.ButeSalary
	from Employees as E
	inner join Seniority as S
	on E.Seniority=S.SeniorityID;
	
	set @CAS = @salary*25/100;
	set @CASS = @salary*10/100;
	set @IV = @salary*10/100;

	RETURN; 
END

DECLARE @CASRet AS INT,
		@CASSRet AS INT,
		@IVRet AS INT;
		
EXEC GetImpozite 
	@firstName = 'Vasile', @lastName = 'Popescu',
	@CAS = @CASRet OUTPUT, @CASS=@CASSRet output, @IV=@IVRet output;
SELECT @CASRet AS 'Asigurari sociale';
SELECT @CASSRet AS 'Asigurari sociale de sanatate';
SELECT @CASRet AS 'Impozit pe venit';

--TRIGGERE

use ITCompany; 

--1.	Trigger care nu lasa inserarea duplicatelor la nivelul numelor modelelor de produse

IF OBJECT_ID('TriggerModelsNames', 'TR') IS NOT NULL DROP TRIGGER TriggerModelsNames;
CREATE TRIGGER TriggerModelsNames
ON Models 
AFTER INSERT, UPDATE
AS 
	BEGIN
	IF @@ROWCOUNT = 0 RETURN;
	SET NOCOUNT ON; 
	IF EXISTS ( SELECT count(*) 
				FROM Inserted AS I
				JOIN Models AS M
				ON I.ModelName = M.ModelName 
				GROUP BY I.ModelName 
				HAVING COUNT(*) > 1 ) 
	BEGIN 
		THROW 50000, 'Duplicate model names not allowed', 0;
	END;
END;

--testare

 select top 1 * from Models
 insert into Models(ModelID,ModelName,RAMID,ProcessorID,ScreenID,OSID,ReleaseDate,ProductID) values
 (11,'Neo Laptop Gen21',100,300,1000,200,getDate(),1)

--2.	Trigger care nu permite ca un proiect sa aiba 2 manageri

IF OBJECT_ID('TriggerManagers', 'TR') IS NOT NULL DROP TRIGGER TriggerManagers;
CREATE TRIGGER TriggerManagers 
ON Employees 
AFTER INSERT, UPDATE
AS 
	BEGIN
	IF @@ROWCOUNT = 0 RETURN;
	SET NOCOUNT ON; 
	IF EXISTS ( SELECT count(*) 
				FROM Inserted AS I
				JOIN Employees AS E
				ON I.Seniority = E.Seniority
				where E.ProjectID=I.ProjectID and I.Seniority=1
				GROUP BY I.Seniority , I.ProjectID
				HAVING COUNT(*) > 1 ) 
	BEGIN 
		THROW 50000, 'Only one manager per project allowed', 0;
	END;
END;

insert into Employees(EmployeeID,ProjectID,FirstName,LastName,Seniority) values
(13,1000,'Alex','Alex',1)
  insert into Employees(EmployeeID,ProjectID,FirstName,LastName,Seniority) values
 (13,1000,'Alex','Alex',2)
 select * from Employees where EmployeeID=13


--3.	Trigger pentru autocompletarea datei de Start cu cea curenta pentru un nou proiect inceput

 IF OBJECT_ID('TriggerForAutocompleteStartDate', 'TR') IS NOT NULL 
	DROP TRIGGER TriggerForAutocompleteStartDate; 
CREATE TRIGGER TriggerForAutocompleteStartDate
ON Projects
AFTER INSERT 
AS 
BEGIN 
	UPDATE P
	SET P.StartDate = GETDATE()
	FROM Projects AS P
END;

SELECT * FROM Projects;
INSERT INTO Projects(ProjectID,ProductID,DueDate,Name)
VALUES (6,1,'2022-04-05','Neo Laptop GenZ+');
SELECT * FROM Projects;

--4.	Trigger pentru inserarea in tabela de Features (Details) aferente fiecarui model functionalitatea  de “5G” pentru toate telefoanele cu data de lansare in 2021

IF OBJECT_ID('TriggerForFeature', 'TR') IS NOT NULL DROP TRIGGER TriggerForFeature;
CREATE TRIGGER TriggerForFeature 
ON Models 
AFTER INSERT
AS 
	BEGIN
	IF @@ROWCOUNT = 0 RETURN;
	SET NOCOUNT ON; 

	DECLARE @Enumerator TABLE(idModel int);
	DECLARE @idModel int;

	insert into @Enumerator
	select I.ModelID
	from Inserted as I
	where year(I.ReleaseDate)=2021
	
	WHILE EXISTS(SELECT 1 FROM @Enumerator)
	BEGIN	
		select top(1) @idModel=idModel
		from @Enumerator

		INSERT INTO Details(ModelID,AddInID)
		SELECT @idModel, A.ID
		from AddIns as A
		where A.AddInName= '5G'

		DELETE FROM @Enumerator WHERE idModel = @idModel;
	END

END;

select * from Models
select * from Details inner join AddIns on Details.AddInID=AddIns.ID where AddIns.AddInName='5G'
insert into Models(ModelID,ModelName,RAMID,StorageID,ProcessorID,ScreenID,OSID,Color,ReleaseDate,Guarantee,ProductID,Stock,Price,WIFI) values
(11,'Neo Phone GenZX',106,206,304,1007,210,'pink','2021-01-04',3,3,2000,3000,804)
select * from Details inner join AddIns on Details.AddInID=AddIns.ID where AddIns.AddInName='5G'

--5.	Trigger care nu permite ca angajatii part-time sa primeasca un bonus pentru orele muncite in plus mai mare de 5%

IF OBJECT_ID('TriggerVerifyingBonus', 'TR') IS NOT NULL
	DROP TRIGGER TriggerVerifyingBonus;

CREATE TRIGGER TriggerVerifyingBonus
ON Seniority
AFTER INSERT, UPDATE
AS
BEGIN
		declare @max as int = 0;
		select @max= max(SeniorityID) from Seniority;

		update S
		set S.BonusForExtraHours = 10
		from Seniority as S
		where S.BonusForExtraHours > 10 and SeniorityID = @max
	
END

select * from Seniority where SeniorityName like 'Part-time%'

update Seniority set BonusForExtraHours = 25
where SeniorityName like 'Part-time%'

select * from Seniority where SeniorityName like 'Part-time%'

--6.	Trigger care semnaleaza incercarea de introducere a unui tip nou de job care nu este part time si are salariul mai mic ca salariul minim pe economie si relizeaza stergerea automata

IF OBJECT_ID('TriggerMinBruteSalary', 'TR') IS NOT NULL
	DROP TRIGGER TriggerMinBruteSalary;

CREATE TRIGGER TriggerMinBruteSalary
ON Seniority
AFTER INSERT
AS
BEGIN

	IF @@ROWCOUNT = 0 RETURN;
	SET NOCOUNT ON;
	IF exists (
		SELECT count(*)
		FROM Inserted AS I
		JOIN Seniority AS S
		ON I.ButeSalary = S.ButeSalary
		WHERE I.ButeSalary <2352 and I.SeniorityName not like 'Part-time%'
		GROUP BY I.ButeSalary
		HAVING COUNT(*) >= 1 
	)
	BEGIN
		PRINT 'Warning !!! Salary too low';
		delete S 
		from Seniority as S 
		inner join inserted as I
		on I.SeniorityID=S.SeniorityID 
		where S.SeniorityID=I.SeniorityID
	END
END

select * from Seniority 

insert into Seniority(SeniorityID, SeniorityName,ButeSalary,StateTax,MinHours) values
(6,'Test job',2300,45,8)

select * from Seniority

--7.	Crearea unui trigger care afiseaza coloanele introduse, updatate sau sterse din tabela care contine evidenta erorilor care au aparut in utilizarea fiecarui model

IF OBJECT_ID('TriggerForErrorsOnModel', 'TR') IS NOT NULL 
	DROP TRIGGER TriggerForErrorsOnModel; 

CREATE TRIGGER TriggerForErrorsOnModel
ON ErrorBuffer
AFTER DELETE, INSERT, UPDATE
AS 
BEGIN
	IF @@ROWCOUNT = 0 RETURN;
	SET NOCOUNT ON;
	SELECT COUNT(*) AS 'Number of Inserted Rows' 
	FROM Inserted;
	SELECT COUNT(*) AS 'Number of Deleted Rows' 
	FROM Deleted;
END;

select * From ErrorBuffer
insert into ErrorBuffer(ModelID,ErrorID)
values(1,8)
select * From ErrorBuffer

--8.	Trigger pentru autocompletarea adresei de email cu prenume.nume@neo.com 

IF OBJECT_ID('TriggerAutocompleteEmail', 'TR') IS NOT NULL
	DROP TRIGGER TriggerToAddPreferentialNumber;

CREATE TRIGGER TriggerToAddPreferentialNumber
ON Employees
AFTER INSERT
AS
BEGIN
	UPDATE E
	SET E.Email = E.FirstName+'.'+E.LastName+'@neo.com'
	FROM Employees AS E
	INNER JOIN Inserted AS I
	ON E.EmployeeID = I.EmployeeID
END

insert into Employees(EmployeeID,FirstName,LastName,ProjectID,Seniority,PersonalDeduction) values
(14,'Bogdan','Barbu',1000,3,0)
select * from Employees where EmployeeID=14 

--9.	Trigger pentru stergerea erorilor din buffer atunci cand s-a sters o eroare din tabela Common Errors

IF OBJECT_ID('TriggerToDeleteErrors', 'TR') IS NOT NULL
	DROP TRIGGER TriggerToDeleteErrors;

CREATE TRIGGER TriggerToDeleteErrors
ON CommonErrors
AFTER DELETE
AS
BEGIN

	IF @@ROWCOUNT = 0 RETURN;
	DECLARE @Enumerator TABLE(id nvarchar(30));
	DECLARE @id  NVARCHAR(30);

	INSERT INTO @Enumerator
	SELECT D.ErrorID
	FROM Deleted AS D

	WHILE EXISTS(SELECT 1 FROM @Enumerator)
	BEGIN

		-- Delete all from buffer with ID
		DELETE EB
		FROM ErrorBuffer AS EB
		WHERE EB.ErrorID = @id

		DELETE FROM @Enumerator WHERE id = @id;
	END
END

SELECT * FROM CommonErrors;
SELECT * FROM ErrorBuffer;
DELETE CE FROM CommonErrors AS CE WHERE CE.Characteristics = 'Stuck pixels'
SELECT * FROM CommonErrors;
SELECT * FROM ErrorBuffer;

--10.	Trigger care sterge din tabela Details pentru un model toate inregistrarile atunci cand se sterge din tabela de AddIns un feature 

IF OBJECT_ID('TriggerToDeleteDetails', 'TR') IS NOT NULL
	DROP TRIGGER TriggerToDeleteDetails;

CREATE TRIGGER TriggerToDeleteDetails
ON AddIns
AFTER DELETE
AS
BEGIN

	IF @@ROWCOUNT = 0 RETURN;
	DECLARE @Enumerator TABLE(id nvarchar(30));
	DECLARE @id  NVARCHAR(30);

	INSERT INTO @Enumerator
	SELECT A.ID
	FROM AddIns AS A

	WHILE EXISTS(SELECT 1 FROM @Enumerator)
	BEGIN
		-- Delete all from details with id
		DELETE D
		FROM Details AS D
		WHERE D.AddInID = @id

		DELETE FROM @Enumerator WHERE id = @id;
	END
END

select * from AddIns as A where A.AddInName like 'Difuzor%'
select * from Details as D inner join AddIns as A on A.ID=D.AddInID where A.AddInName like 'Difuzor%'

DELETE A FROM AddIns AS A WHERE A.AddInName = 'Difuzor' and A.Details like 'Stereo%'

select * from AddIns as A where A.AddInName like 'Difuzor%'
select * from Details as D inner join AddIns as A on A.ID=D.AddInID where A.AddInName like 'Difuzor%'

--11.	Trigger pentru autocompletarea taxei de la stat cu 45%

IF OBJECT_ID('TriggerForAutocompleteStateTax', 'TR') IS NOT NULL 
	DROP TRIGGER TriggerForAutocompleteStateTax; 

CREATE TRIGGER TriggerForAutocompleteStateTax 
ON Seniority
AFTER INSERT 
AS 
BEGIN 
	UPDATE S
	SET S.StateTax = 45
	FROM Seniority AS S
END;

--12.	Trigger pentru autocompletarea orelor minime de lucru cu 8 pentru fiecare tip de job

IF OBJECT_ID('TriggerForAutocompleteMinHours', 'TR') IS NOT NULL 
	DROP TRIGGER TriggerForAutocompleteMinHours; 

CREATE TRIGGER TriggerForAutocompleteMinHours 
ON Seniority
AFTER INSERT
AS 
BEGIN 
	UPDATE S
	SET S.MinHours = 8
	FROM Seniority AS S
END;

--TRANZACTII

use ITCompany;

--1.	Tranzactie pentru updatarea solutiei unei erori cu una mai performanta. 

BEGIN TRANSACTION UpdateSolutions

	-- Declararea unor variabile
	DECLARE @errorID int = 1;
	DECLARE @newSolution VARCHAR(100) = 'here is how'

	declare @oldSolution varchar(100) = 'old how'
	select * from CommonErrors where ErrorID = @errorID
	select @oldSolution = Solution from CommonErrors where ErrorID=@errorID 
	-- Update-ul assesment-urilor
	UPDATE CE
	SET CE.Solution = @newSolution
	FROM CommonErrors AS CE
	WHERE CE.ErrorID = @errorID;
	select * from CommonErrors where ErrorID = @errorID
	EXEC CatchError @errorCode = @@ERROR;

	--aducerea la forma initiala
	UPDATE CE
	SET CE.Solution = @oldSolution
	FROM CommonErrors AS CE
	WHERE CE.ErrorID = @errorID;
	select * from CommonErrors where ErrorID = @errorID

	-- Verificarea erorilor
	EXEC CatchError @errorCode = @@ERROR;

EXEC CommitTransction;
 
--2.	Tranzactie pentru adaugarea unui nou proiect si a unui angajat care sa fie project manager

BEGIN TRANSACTION AddNewProjects

	DECLARE @newProject INT;
	declare @newEmployee int;

	select @newEmployee = max(EmployeeID) + 1 from Employees
	select @newProject  =max(ProjectID) + 1 from Projects
	
	select * from Projects
	select * from Employees

	INSERT INTO Projects(ProjectID,ProductID,StartDate,DueDate,Investment,Name)
	VALUES (@newProject,1,getDate(),'2022-09-09',100000,'New Proj');

	EXEC CatchError @errorCode = @@ERROR;

	INSERT INTO Employees(EmployeeID,ProjectID,FirstName,LastName,Seniority,PersonalDeduction)
	VALUES (@newEmployee,@newProject,'Andrei','Andrei',1,0);

	EXEC CatchError @errorCode = @@ERROR;

	select * from Projects
	select * from Employees

	EXEC CommitTransction;

--3.	Tranzactie in procedura stocata care insereaza un nou update pentru un anumit produs

IF OBJECT_ID('InsertNewUpdate', 'P') IS NOT NULL 
DROP PROC InsertNewUpdate;

CREATE PROCEDURE InsertNewUpdate(      
 @description varchar(30),
	  @product int)
AS
BEGIN
	BEGIN TRY

    BEGIN TRANSACTION;
	declare @id int,
			 @predecesor int;
	select * from Updates where ProductID=@product
		select @predecesor = max(UpdateID)
		from Updates
		where ProductID = @product

		select @id=max(UpdateID)+1 from Updates

		Insert into Updates(UpdateID,UpdateDescription,ReleaseDate,Predecesor,ProductID) 
		values (@id,@description,GETDATE(),@predecesor,@product)

	COMMIT TRANSACTION ;
	
	END TRY
    
	BEGIN CATCH
       IF ERROR_NUMBER() = 2627 -- Duplicate key violation
		BEGIN
			PRINT 'Primary Key violation';
		END
		ELSE IF ERROR_NUMBER() = 1215 -- Foreign key violations
		BEGIN
			PRINT 'Foreign key violation';
		END
		ELSE
		BEGIN
			PRINT 'Unhandled error';
		END;
		IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
    END CATCH

END;	
 
--4.	Tranzactie care introduce un tip de job ‘Intern’ si care seteaza minimul de ore lucrate de la DEFAULT-ul de 8 ore la 6, apoi sterge inregistrarea

BEGIN TRANSACTION InsertNewJob

	-- Declararea unor variabile
	DECLARE @name VARCHAR(30) = 'Intern';
	DECLARE @id int;

	select @id = max(SeniorityID) + 1 from Seniority;
	
	INSERT INTO Seniority(SeniorityID,SeniorityName,ButeSalary,MinHours,BonusForExtraHours)
	VALUES (@id,@name, 3000,4,0);

	EXEC CatchError @errorCode = @@ERROR;
	--un intern trebuie sa lucreze minim 6 ore
	UPDATE S
	SET S.MinHours = 6
	FROM Seniority AS S
	WHERE S.SeniorityName = @name;

	select * from Seniority where SeniorityName = @name;

	EXEC CatchError @errorCode = @@ERROR;

	DELETE S
	FROM Seniority AS S
	WHERE S.SeniorityName = @name;

	select * from Seniority where SeniorityName = @name;

	EXEC CatchError @errorCode = @@ERROR;
	EXEC CommitTransction;

--5.	Tranzactie care insereaza un nou feature in tabla AddIns si insereaza in Details pentru toate modelele de telefon din 2021
BEGIN TRANSACTION NewAddIn

	-- Declararea unor variabile
	DECLARE @newName VARCHAR(30) = 'Camera principana';
	DECLARE @detail VARCHAR(30) = 'Tripla';
	DECLARE @idADD int;

	select @idADD = max(ID) + 1 from AddIns;
	--inserarare in tabela addins
	insert into AddIns(ID,AddInName,Details) values
	(@idADD,@newName,@detail)
	EXEC CatchError @errorCode = @@ERROR;
	
	select * from AddIns where AddInName = @newName
	--inserare in tabela details modelele de telefoane din 2021 sa aiba Camera principala tripla
	DECLARE @counts INT = 1;
	DECLARE @MAXS INT ;
	Select @MAXS = max(ModelID) from Models
	while(@counts < @MAXS)
	BEGIN
		IF( (SELECT YEAR(ReleaseDate) from Models where ModelID = @counts and ProductID = 3) = 2021)
			begin
			insert into Details(AddInID,ModelID) values (@idADD, @counts)
			end
		else
			BEGIN
			PRINT 'NO'
			END;
	set @counts +=1
	END;
	EXEC CatchError @errorCode = @@ERROR;
	select * from Details where AddInID = @idADD
	EXEC CommitTransction;

--6.	Tranzactie pentru inserarea unui nou tip de procesor si updatarea tututor modelelor aparute in 2021 ca sa contina acel tip de procesor

BEGIN TRANSACTION NewProcessor

	-- Declararea unor variabile
	DECLARE @processor VARCHAR(30) = 'Intel i9';
	DECLARE @cores int =10 ;
	DECLARE @idProcessor int;

	select @idProcessor = max(ProcessorID) + 1 from Processors;
	--inserarare in tabela addins
	insert into Processors(ProcessorID,Generation,Cores,Frequency,Cache) values
	(@idProcessor,@processor,@cores,0.9,16)
	EXEC CatchError @errorCode = @@ERROR;
	
	select * from Processors where Generation = @processor
	--inserare in tabela details modelele de telefoane din 2021 sa aiba Camera principala tripla
	UPDATE M
	SET M.ProcessorID = @idProcessor
	FROM Models AS M
	INNER JOIN Products AS P
	ON M.ProductID = P.ProductID
	WHERE YEAR(M.ReleaseDate)=2021
	EXEC CatchError @errorCode = @@ERROR;

	select * from Models where ProcessorID = @idProcessor
	
	EXEC CommitTransction;

--7.	Tranzactie care insereaza o eroare noua referitoare la RAM si introduce in Error Buffer cate o inregistrare pentru fiecre model care are respectivul tip de RAM

BEGIN TRANSACTION TooSlow

	-- Declararea unor variabile
	DECLARE @errorName VARCHAR(100) = 'Not enough RAM';
	DECLARE @solution VARCHAR(100) = 'Update your RAM in service';
	DECLARE @idERR int;
	DECLARE @idRAM int;

	select @idERR = max(ErrorID) + 1 from CommonErrors;
	select top 1 @idRAM = RAMID from RAM where Maximum =16
	--inserarare in tabela Errors
	insert into CommonErrors(ErrorID,Characteristics,Solution) values
	(@idERR,@errorName,@solution)
	EXEC CatchError @errorCode = @@ERROR;
	
	select * from CommonErrors where Characteristics = @errorName

	--inserare in tabela details modelele de telefoane din 2021 sa aiba Camera principala tripla
	DECLARE @countR INT = 1;
	DECLARE @MAXR INT ;
	Select @MAXR = max(ModelID) from Models
	while(@countR < @MAXR)
	BEGIN
		IF( (SELECT RAMID from Models where ModelID = @countR) = @idRAM)
			begin
			insert into ErrorBuffer(ErrorID,ModelID) values (@idERR, @countR)
			end
		else
			BEGIN
			PRINT 'Model works ok'
			END;
	set @countR +=1
	END;
	EXEC CatchError @errorCode = @@ERROR;
	select * from ErrorBuffer where ErrorID = @idERR
	EXEC CommitTransction;
     
--8.	Tranzactie pentru inserarea unui nou produs  de test si a unui prim update pentru el care va avea predecesorul NULL, urmand sa stergem ulterior produsul

BEGIN TRANSACTION NewProduct

	-- Declararea unor variabile
	DECLARE @product VARCHAR(30) = 'Smartwatch';
	DECLARE @description varchar(100) = 'Update de test pentru noul produs' ;
	DECLARE @idProduct int;
	DECLARE @idUpdate int;

	select @idProduct = max(ProductID) + 1 from Products;
	insert into Products(ProductID,Category) values
	(@idProduct,@product)

	EXEC CatchError @errorCode = @@ERROR;
	
	select * from Products where Category = @product
	
	select @idUpdate = max(UpdateID) + 1 from Updates;
	insert into Updates(UpdateID,ProductID,UpdateDescription,ReleaseDate)
	values(@idUpdate,@idProduct,@description,GETDATE())
	
	EXEC CatchError @errorCode = @@ERROR;
	
	select * from Updates where ProductID=@idProduct
	--se va face delete in cascada
	delete P from Products as P where P.ProductID = @idProduct

	EXEC CommitTransction;

--9.	Tranzactie pentru adaugarea unui nou model de telefon + feature-uri pe care trebuie sa le aiba un smartphone de ultima generatie.


	BEGIN TRANSACTION NewModel

	-- Declararea unor variabile
	DECLARE @model VARCHAR(30) = 'Neo Phone Gen21 MAX';
	DECLARE @idModel int;
	DECLARE @idProcesor int = 305, @idR int = 104, @idScreen int = 1007, @idStorage int = 206, @idwifi int = 804 ,@idOS int = 209 ,@idProd int;

	select @idModel = max(ModelID) + 1 from Models;
	select @idProD = ProductID from Products where Category = 'smartphone';

	insert into Models(ModelID,ModelName,RAMID,StorageID,ScreenID,OSID,Color,ReleaseDate,ProductID,Stock,Price,WIFI) values
	(@idModel,@model,@idR,@idStorage,@idScreen,@idOS,'black',GETDATE(),@idProd,1000,2500,@idwifi);

	EXEC CatchError @errorCode = @@ERROR;
	
	select * from Models where ModelName = @model;
	
	declare @idAddIn int;
	--adaugare features pt telefon
	select @idAddIn = ID from AddIns where AddInName like '%recognition';
	insert into Details(ModelID,AddInID) values (@idModel,@idAddIn);
	EXEC CatchError @errorCode = @@ERROR;

	select @idAddIn = ID from AddIns where AddInName like 'Front camera%' and Details like '32%';
	insert into Details(ModelID,AddInID) values (@idModel,@idAddIn);
	EXEC CatchError @errorCode = @@ERROR;

	select @idAddIn = ID from AddIns where AddInName like 'Wireless%' ;
	insert into Details(ModelID,AddInID) values (@idModel,@idAddIn);
	EXEC CatchError @errorCode = @@ERROR;

	select * from Details where ModelID = @idModel;

	EXEC CommitTransction;

--10.	Tranzactie care insereaza un model nou de laptop in tabela Models si Porturile de care acesta are nevoie in tabela Links

	BEGIN TRANSACTION NewLaptopModel

	-- Declararea unor variabile
	DECLARE @laptop VARCHAR(30) = 'Neo Laptop Gen21 MAX';
	DECLARE @idMod int;
	DECLARE @idProcesorL int = 309, @idRL int = 102, @idScreenL int = 1011, @idStorageL int = 205, @idwifiL int = 804 ,@idOSL int = 209 ,@idProdL int;

	select @idMod = max(ModelID) + 1 from Models;
	select @idProdL = ProductID from Products where Category = 'laptop';

	insert into Models(ModelID,ModelName,RAMID,StorageID,ScreenID,OSID,Color,ReleaseDate,ProductID,Stock,Price,WIFI) values
	(@idMod,@laptop,@idRL,@idStorageL,@idScreenL,@idOSL,'black',GETDATE(),@idProdL,1000,12500,@idwifiL);

	EXEC CatchError @errorCode = @@ERROR;
	
	select * from Models where ModelID = @idMod;
	
	declare @portID int;

	--adaugare porturi pe laptop
	select @portID = PortID from ExternalPorts where PortName like 'Jack%'
	insert into Links(ModelID,PortID,Quantity) values (@idMod,@portID,1)
	EXEC CatchError @errorCode = @@ERROR;

	select @portID = PortID from ExternalPorts where PortName like 'HDMI'
	insert into Links(ModelID,PortID,Quantity) values (@idMod,@portID,2)
	EXEC CatchError @errorCode = @@ERROR;

	select @portID = PortID from ExternalPorts where PortName like '%3.1C'
	insert into Links(ModelID,PortID,Quantity) values (@idMod,@portID,2)
	EXEC CatchError @errorCode = @@ERROR;

	select * from Links where ModelID = @idMod;

	EXEC CommitTransction;

--Nota: Am ales ID-urile inregistrarilor inserate astfel incat sa nu se incalce constrangerile de chei primare.
