USE test5;

CREATE TABLE Students(
StudentID INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
FirstName varchar(50),
LastName varchar(50),
DateOfBirth date,
Gender varchar(10),
StudyYear varchar(25),
Nationality varchar(50),
SpecialNeeds varchar(250),
HomeAddressID INT,
ContactID INT,
FlatID INT,
ResidencyStatus varchar(25),
AdvisorID INT,
HallRoomID INT
);

CREATE TABLE Advisors (
AdvisorID INT IDENTITY (1,1) PRIMARY KEY,
FirstName varchar(50),
LastName varchar(50),
Position varchar(50),
Department varchar(50),
PhoneNumber varchar(25),
OfficeLocation varchar(50)
);

CREATE TABLE Courses (
CourseID INT IDENTITY (1,1) PRIMARY KEY,
CourseNumber INT,
CourseName varchar(50),
Year date,
InstFirstName varchar(50),
InstLastName varchar(50),
RoomNumber INT,
DepartmentName varchar(50)
);

CREATE TABLE HallsOfResidence (
ResidenceHallID INT IDENTITY (1,1) PRIMARY KEY,
HallName varchar(25),
AddressID INT,
PhoneNumber varchar(25),
HallManager INT
);

CREATE TABLE Flats (
FlatID INT IDENTITY(1,1) PRIMARY KEY,
FlatNumber INT,
AddressID INT,
NumberOfRooms INT
);

CREATE TABLE Leases (
LeaseID INT IDENTITY (1,1) PRIMARY KEY,
LeaseNumber INT,
LeaseDuration varchar(25),
StudentID INT,
EntryDate date,
ExitDate date
);

CREATE TABLE Invoices (
InvoiceID INT IDENTITY (1,1) PRIMARY KEY,
InvoiceNumber INT,
LeaseID INT,
StudentID INT,
Quarter varchar(25),
PaymentDue decimal
);

CREATE TABLE Payments (
PaymentID INT IDENTITY (1,1) PRIMARY KEY,
InvoiceID INT,
PaymentDate date,
PaymentMethod varchar(25),
FirstReminderDate date,
SecondReminderDate date
);

CREATE TABLE FlatInspections (
InspectionID INT IDENTITY (1,1) PRIMARY KEY,
FlatID INT,
StaffMemberID INT,
InspectionDate date,
Satisfactory varchar(25),
Comments varchar(250)
);

CREATE TABLE Addresses (
AddressID INT IDENTITY (1,1) PRIMARY KEY,
StreetName varchar(50),
StreetNumber varchar(25),
City varchar(25),
ZipCode varchar(10),
Country varchar(25)
);

CREATE TABLE Contacts (
ContactID INT IDENTITY (1,1) PRIMARY KEY,
SSN INT,
FirstName varchar(50),
LastName varchar(50),
Relationship varchar(50),
AddressID INT,
PhoneNumber varchar(25)
);

CREATE TABLE AccommodationStaff (
AccommodationStaffID INT IDENTITY (1,1) PRIMARY KEY,
FirstName varchar(50),
LastName varchar(50),
AddressID INT,
DateOfBirth date,
Gender varchar(10),
PositionID INT,
OfficeLocationID INT,
HallLocationID INT
);

CREATE TABLE StaffPositions (
StaffPositionID INT IDENTITY (1,1) PRIMARY KEY,
Position varchar(50)
);

CREATE TABLE HallRooms (
HallRoomID INT IDENTITY (1,1) PRIMARY KEY,
HallsOfResidenceID INT,
RoomNumber INT,
PlaceNumber INT,
MonthlyRentRate money
);

CREATE TABLE StudentCourses (
StudentID INT IDENTITY (1,1) PRIMARY KEY,
CourseID INT);

ALTER TABLE Students ADD FOREIGN KEY (HomeAddressID) 
  REFERENCES Addresses(AddressID);

ALTER TABLE Students ADD FOREIGN KEY (HallRoomID) 
  REFERENCES HallRooms(HallRoomID);

ALTER TABLE HallRooms ADD FOREIGN KEY (HallsOfResidenceID) 
  REFERENCES HallsOfResidence(ResidenceHallID);

ALTER TABLE Students ADD FOREIGN KEY (AdvisorID) 
  REFERENCES Advisors(AdvisorID);

  ALTER TABLE Students ADD FOREIGN KEY (ContactID) 
  REFERENCES Contacts(ContactID);

  ALTER TABLE Students ADD FOREIGN KEY (FlatID) 
  REFERENCES Flats(FlatID);

  ALTER TABLE Students ADD FOREIGN KEY (AdvisorID) 
  REFERENCES Advisors(AdvisorID);

  ALTER TABLE Flats ADD FOREIGN KEY (AddressID) 
  REFERENCES Addresses(AddressID);

  ALTER TABLE Students ADD FOREIGN KEY (AdvisorID) 
  REFERENCES Advisors(AdvisorID);

  ALTER TABLE HallsOfResidence ADD FOREIGN KEY (HallManager) 
  REFERENCES StaffPositions(StaffPositionID);

  ALTER TABLE HallsOfResidence ADD FOREIGN KEY (AddressID) 
  REFERENCES Addresses(AddressID);

  ALTER TABLE Leases ADD FOREIGN KEY (StudentID) 
  REFERENCES Students(StudentID);

  ALTER TABLE Invoices ADD FOREIGN KEY (LeaseID) 
  REFERENCES Leases(LeaseID);

  ALTER TABLE Payments ADD FOREIGN KEY (InvoiceID) 
  REFERENCES Invoices(InvoiceID);

  ALTER TABLE FlatInspections ADD FOREIGN KEY (StaffMemberID) 
  REFERENCES StaffPositions(StaffPositionID);

  ALTER TABLE AccommodationStaff ADD FOREIGN KEY (AddressID) 
  REFERENCES Addresses(AddressID);

  ALTER TABLE AccommodationStaff ADD FOREIGN KEY (PositionID) 
  REFERENCES StaffPositions(StaffPositionID);

  ALTER TABLE Contacts ADD FOREIGN KEY (AddressID) 
  REFERENCES Addresses(AddressID);

  ALTER TABLE AccommodationStaff ADD FOREIGN KEY (HallLocationID) 
  REFERENCES HallsOfResidence(ResidenceHallID);

  ALTER TABLE AccommodationStaff ADD FOREIGN KEY (OfficeLocationID) 
  REFERENCES HallsOfResidence(ResidenceHallID);

  ALTER TABLE StudentCourses ADD FOREIGN KEY (StudentID)
  REFERENCES Students(StudentID);

  ALTER TABLE StudentCourses ADD FOREIGN KEY (CourseID)
  REFERENCES Courses(CourseID);

ALTER TABLE Students
ADD CONSTRAINT CheckGender
CHECK (Gender IN ('male', 'female'));

ALTER TABLE Students
ADD CONSTRAINT CheckResidencyStatus
CHECK (ResidencyStatus IN ('placed', 'waiting'));

ALTER TABLE Payments
ADD CONSTRAINT CheckPaymentMethod
CHECK (PaymentMethod IN ('cheque','cash','credit','debit' ));

ALTER TABLE FlatInspections
ADD CONSTRAINT CheckSatisfactory
CHECK (Satisfactory IN ('yes','no'));

ALTER TABLE AccommodationStaff
ADD CONSTRAINT CheckStaffGender
CHECK (Gender IN ('male', 'female'));

ALTER TABLE Students
ADD CONSTRAINT Check_HallID_RoomID
CHECK (NOT FlatID IS NOT NULL AND HallRoomID IS NOT NULL);

ALTER TABLE Students
DROP CONSTRAINT Check_HallID_RoomID;

ALTER TABLE Students
ADD CONSTRAINT check_HallRoomID
CHECK ((FlatID IS NOT NULL) OR (HallRoomID IS NOT NULL));

INSERT INTO Addresses
VALUES (
  'Mockingbird Lane',
  6633,
  'Mississauga',
  'L3X1S5',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'John Street',
  24,
  'Brampton',
  'L5T1V5',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Creditview Road',
  1400,
  'Mississauga',
  'L5W1P4',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Polonia Avenue',
  20,
  'Brampton',
  'L6Y0K9',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Arvida Circle',
  34,
  'Mississauga',
  'L5N1R4',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Mockingbird Lane',
  6633,
  'Mississauga',
  'L3X1S5',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Rose Lane',
  16,
  'Brantford',
  'L8N6R4',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Edenwood Drive',
  6700,
  'Mississauga',
  'L4T1S4',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Northmount Avenue',
  217,
  'Mississauga',
  'L7N19P',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Paisley Boulevard',
  90,
  'Mississauga',
  'L4T3s8',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Higgins Avenue',
  27,
  'Hamilton',
  'L6V1R9',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Front Street',
  42,
  'Toronto',
  'L8S1B1',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'King Street',
  874,
  'Toronto',
  'L9N1N8',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Lyndon Avenue',
  33,
  'Toronto',
  'L4R5T7',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Cowley Crescent',
  36282,
  'Milton',
  'L8N5T6',
  'Canada'
)


INSERT INTO Addresses
VALUES (
  'Spectrum Way',
  27239,
  'Newmarket',
  'L8B6C6',
  'Canada'
) 


INSERT INTO Addresses
VALUES (
  'Erin Centre Boulvard',
  1900,
  'Mississauga',
  'L5M0A5',
  'Canada'
)


INSERT INTO Addresses
VALUES (
  'Richmond Road',
   11,
  'Brampton',
  'L8V7G6',
  'Canada'
)


INSERT INTO Addresses
VALUES (
  'Thomas Street',
  222,
  'Hamilton',
  'L6G7H6',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Queen Street',
  6252,
  'Mississauga',
  'L5N7T6',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Constable Road',
  2345,
  'Brampton',
  'L6Y7U8',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Union Avenue',
  12,
  'Toronto',
  'L4N6T7',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Garibaldi Court',
  77,
  'Oakville',
  'M8T1Y7',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'City Centre Drive',
  100,
  'Mississauga',
  'L5W1D4',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Marcellus Drive',
  24,
  'Barrie',
  'L4T1R6',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Yonge Street',
  11863,
  'Newmarket',
  'L9N1R3',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Woodsend Run',
  3,
  'Brampton',
  'L6Y0K1',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'First Street',
  626,
  'Mississauga',
  'L6M1W3',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Orange Street',
  88,
  'Alliston',
  'L7V6T4',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'North Street',
  22,
  'Mississauga',
  'L8N7T6',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Blue Road',
  9,
  'Etobicoke',
  'L7V6R2',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Spadina Avenue',
  62,
  'Toronto',
  'M8T6H7',
  'Canada'
)

INSERT INTO Addresses
VALUES (
  'Ontario Street',
  11863,
  'Guelph',
  'L8W7F5',
  'Canada'
)

SELECT * FROM Addresses;

SELECT * FROM Contacts;

INSERT INTO Contacts
VALUES (
  12345678,
  'John',
  'Smith',
  'Father',
  11,
  '(905) 274 1889'
)

INSERT INTO Contacts
VALUES (
  346729225,
  'Mary',
  'Jones',
  'Aunt',
  12,
  '(905) 681 1657'
)

INSERT INTO Contacts
VALUES (
  835398537,
  'Tyler',
  'Robert',
  'Father',
  13,
  '(905) 353 2638'
)

INSERT INTO Contacts
VALUES (
  453662987,
  'Matthew',
  'Dior',
  'Brother',
  14,
  '(647) 998 1645'
)

INSERT INTO Contacts
VALUES (
  373648902,
  'Rita',
  'Frances',
  'Mother',
  15,
  '(647) 334 2625'
)

INSERT INTO Contacts
VALUES (
  473930263,
  'William',
  'Parker',
  'Brother',
  16,
  '(416) 322 1563'
)

INSERT INTO Contacts
VALUES (
  464520567,
  'Jane',
  'Luisa',
  'Sister',
  17,
  '(289) 191 2263'
)

INSERT INTO Contacts
VALUES (
  363829454,
  'Melissa',
  'Prechner',
  'Legal Guardian',
  18,
  '(905) 234 5678'
)

INSERT INTO Contacts
VALUES (
  238765434,
  'Jimena',
  'Paul',
  'Uncle',
  19,
  '(234) 222 2353'
)

INSERT INTO Contacts
VALUES (
  342735935,
  'Grace',
  'Sean',
  'Grandmother',
  20,
  '(647) 998 1645'
)

INSERT INTO Advisors
VALUES (
'Henry',
'Miller',
'Manager',
'Housing',
'7054567766',
'Montreal'
)

INSERT INTO Advisors
VALUES (
'Jack',
'Johnston',
'Manager',
'Housing',
'6478871999',
'Toronto'
)

SELECT * FROM Advisors;
SELECT * FROM StaffPositions;
SELECT * FROM HallsOfResidence;

INSERT INTO StaffPositions
VALUES (
'Hall Manager'
)

INSERT INTO StaffPositions
VALUES (
'Administrative Assistant'
)

INSERT INTO HallsOfResidence
VALUES (
'Alpha',
28,
'(905) 455 1770',
1
)

INSERT INTO HallsOfResidence
VALUES (
'Beta',
29,
'(905) 778 9977',
2
)

INSERT INTO HallsOfResidence
VALUES (
'Gamma',
29,
'(905) 367 5657',
1
)

INSERT INTO HallsOfResidence
VALUES (
'Delta',
30,
'(905) 478 4573',
2
)

INSERT INTO HallRooms
VALUES (
1,
24,
103,
1300
);

INSERT INTO HallRooms
VALUES (
2,
18,
95,
1200
);

INSERT INTO HallRooms
VALUES (
3,
6,
108,
1100
);

INSERT INTO HallRooms
VALUES (
4,
21,
110,
1250
);

INSERT INTO Flats
VALUES (
213,
5,
3
);

INSERT INTO Flats
VALUES (
476,
15,
4
);

INSERT INTO Students
VALUES (
'Albert', 'Presley', '19871015', 'male', 'sophomore', 'Argentinian', NULL, 1, 1, NULL, 'placed', 1, 1
)
INSERT INTO Students 
VALUES (
'Robert', 'Alpert', '20010214', 'male', 'junior', 'French', 'wheelchair accessibility', 2, 2, 1, 'placed', 2, NULL
)

INSERT INTO Students 
VALUES ('Indiana', 'Jones', '19880418', 'male', 'freshmen', 'Indian', NULL, 7, 3, 1, 'placed', 2, NULL
)

INSERT INTO Students 
VALUES ('Dior', 'Reyes', '19850328', 'female', 'freshmen', 'French', NULL, 9, 4, 1, 'placed', 1, NULL
)

INSERT INTO Students 
VALUES ('Francis', 'Knew', '20010622', 'male', 'senior', 'Korean', NULL, 11, 5, NULL, 'placed', 2, 2
)

INSERT INTO Students 
VALUES ('Peter', 'Parker', '19971212', 'male', 'junior', 'American', NULL, 12, 6, NULL, 'placed', 2, 3
)

INSERT INTO Students 
VALUES ('Luisa', 'Arellano', '19950310', 'female', 'senior', 'German', 'Wheelchair accessibility', 14, 7, 2, 'placed', 2, NULL
)

INSERT INTO Students 
VALUES ('Javeria', 'Vargas', '19931005', 'female', 'sophomore', 'Serbian', NULL, 15, 8, 2, 'placed', 1, NULL
)

INSERT INTO Students 
VALUES ('Jimena', 'Garcias', '20010103', 'female', 'junior', 'Kenyan', NULL, 16, 9, 2, 'placed', 2, NULL
)

INSERT INTO Students 
VALUES ('Sean', 'Depal', '19940128', 'male', 'senior', 'Jamaican', NULL, 17, 10, NULL, 'placed', 1, 4
)

CREATE NONCLUSTERED INDEX IX_Payments_InvoiceID
ON Payments (InvoiceID);

CREATE NONCLUSTERED INDEX IX_Payments_DateOfPayment
ON Payments (PaymentDate);

CREATE NONCLUSTERED INDEX IX_Invoices_LeaseID
ON Invoices (LeaseID);

CREATE NONCLUSTERED INDEX IX_Invoices_InvoiceNumber
ON Invoices (InvoiceNumber);

CREATE NONCLUSTERED INDEX IX_Leases_StudentID
ON Leases (StudentID);

CREATE NONCLUSTERED INDEX IX_Leases_LeaseNumber
ON Leases (LeaseNumber);

CREATE NONCLUSTERED INDEX IX_Students_FirstName_LastName
ON Students (FirstName, LastName);

CREATE NONCLUSTERED INDEX IX_Students_HomeAddressID
ON Students (HomeAddressID);

CREATE NONCLUSTERED INDEX IX_Students_ContactID
ON Students (ContactID);

CREATE NONCLUSTERED INDEX IX_Students_FlatID
ON Students (FlatID);

CREATE NONCLUSTERED INDEX IX_Students_AdvisorID
ON Students (AdvisorID);

CREATE NONCLUSTERED INDEX IX_Students_HallRoomID
ON Students (HallRoomID);

CREATE NONCLUSTERED INDEX IX_Contacts_FirstName_LastName
ON Contacts (FirstName, LastName);

CREATE NONCLUSTERED INDEX IX_Flats_AddressID
ON Flats (AddressID);

CREATE NONCLUSTERED INDEX IX_Addresses_StreetName_StreetNumber
ON Addresses (StreetName, StreetNumber);

CREATE NONCLUSTERED INDEX IX_Contacts_AddressID
ON Contacts (AddressID);

CREATE NONCLUSTERED INDEX IX_HallsOfResidence_HallName
ON HallsOfResidence (HallName);

CREATE NONCLUSTERED INDEX IX_HallsOfResidence_AddressID
ON HallsOfResidence (AddressID);

CREATE NONCLUSTERED INDEX IX_HallRooms_HallsOfResidenceID
ON HallRooms (HallsOfResidenceID);

CREATE NONCLUSTERED INDEX IX_HallRooms_PlaceNumber
ON HallRooms (PlaceNumber);

CREATE NONCLUSTERED INDEX IX_HallRooms_RoomNumber
ON HallRooms (RoomNumber);

CREATE NONCLUSTERED INDEX IX_AccommodationStaff_FirstName_LastName
ON AccommodationStaff (FirstName, LastName);

CREATE NONCLUSTERED INDEX IX_AccomodationStaff_AddressID
ON AccommodationStaff (AddressID);

CREATE NONCLUSTERED INDEX IX_AccomodationStaff_PositionID
ON AccommodationStaff (PositionID);

CREATE NONCLUSTERED INDEX IX_AccomodationStaff_OfficeLocationID
ON AccommodationStaff (OfficeLocationID);

CREATE NONCLUSTERED INDEX IX_AccommodationStaff_HallLocationID
ON AccommodationStaff (HallLocationID);

CREATE NONCLUSTERED INDEX IX_FlatInspections_StaffMemberID
ON FlatInspections (StaffMemberID);

CREATE NONCLUSTERED INDEX IX_FlatInspections_InspectionDate
ON FlatInspections (InspectionDate);

DBCC SHRINKDATABASE (test5, 10);

DECLARE @BackupDirectory NVARCHAR(500);
SET @BackupDirectory = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL';

DECLARE @BackupFileName NVARCHAR(500);
SET @BackupFileName = @BackupDirectory + DB_NAME() + '_' + REPLACE(CONVERT(NVARCHAR(20), GETDATE(), 120), ':', '_') + '.bak';