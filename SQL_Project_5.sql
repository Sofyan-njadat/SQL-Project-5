CREATE DATABASE Library_Management_System;
USE Library_Management_System;


CREATE TABLE Books  (
	ID INT PRIMARY KEY IDENTITY (1,1),
    Title NVARCHAR(100) NOT NULL,
    Author NVARCHAR(100) NOT NULL,
    Genre NVARCHAR(50) NOT NULL,
    PublicationYear INT NOT NULL,
    AvailabilityStatus NVARCHAR(10) CHECK (AvailabilityStatus IN ('Available', 'N/A')) NOT NULL
);

CREATE TABLE Members (
	ID INT PRIMARY KEY IDENTITY (1,1),
	Name NVARCHAR(100) NOT NULL,
	ContactInformation INT NOT NULL,
	MembershipType NVARCHAR(10) CHECK (MembershipType IN ('Student', 'Teacher', 'Visitor')),
	RegistrationDate DATE
);
ALTER TABLE Members ALTER COLUMN ContactInformation BIGINT;

CREATE TABLE Borrowing (
    ID INT PRIMARY KEY IDENTITY(1,1),
    MemberID INT FOREIGN KEY REFERENCES Members(ID),
    BookID INT FOREIGN KEY REFERENCES Books(ID),
    BorrowingDate DATETIME,
    DueDate DATETIME,
    ReturnDate DATETIME
);

CREATE TABLE LibraryStaff (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    ContactInfo BIGINT,
    AssignedSection NVARCHAR(50),
    EmploymentDate DATE
);

CREATE TABLE Categories (
    ID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(50) NOT NULL,
    Description NVARCHAR(255)
);

CREATE TABLE BookCategory (
	ID INT PRIMARY KEY IDENTITY(1,1),
	BookID INT FOREIGN KEY REFERENCES Books(ID),
	CategorieID INT FOREIGN KEY REFERENCES Categories(ID)
);

CREATE TABLE Reservations (
    ID INT PRIMARY KEY IDENTITY(1,1),
    MemberID INT FOREIGN KEY REFERENCES Members(ID),
    BookID INT FOREIGN KEY REFERENCES Books(ID),
    ReservationDate DATETIME,
    Status NVARCHAR(20) CHECK (Status IN ('Pending', 'Cancelled', 'Completed'))
);

CREATE TABLE FinancialFines (
    ID INT PRIMARY KEY IDENTITY(1,1),
    MemberID INT FOREIGN KEY REFERENCES Members(ID),
    Amount DECIMAL(10, 2),
    PaymentStatus NVARCHAR(20) CHECK (PaymentStatus IN ('Paid', 'Unpaid'))
);


---------------------------------------------------------------------
------- INSERT DATA -------
---------------------------------------------------------------------

INSERT INTO Books (Title, Author, Genre, PublicationYear, AvailabilityStatus)
VALUES 
('Database Fundamentals', 'John Doe', 'Computer Science', 2020, 'Available'),
('SQL for Beginners', 'Jane Smith', 'Computer Science', 2019, 'Available'),
('C# Programming', 'Alice Johnson', 'Programming', 2021, 'Available'),
('The Great Gatsby', 'F. Scott Fitzgerald', 'Fiction', 1925, 'Available'),
('1984', 'George Orwell', 'Science Fiction', 1949, 'Available'),
('To Kill a Mockingbird', 'Harper Lee', 'Fiction', 1960, 'Available');


INSERT INTO Members (Name, ContactInformation, MembershipType, RegistrationDate)
VALUES 
('Ahmed', 1234567890, 'Student', '2025-01-01'),
('Fatima', 0987654321, 'Teacher', '2024-06-05'),
('Ali', 1122334455, 'Visitor', '2024-07-15'),
('Layla', 2233445566, 'Student', '2024-08-20'),
('Mohammed', 3344556677, 'Teacher', '2024-09-25'),
('Aisha', 4455667788, 'Visitor', '2024-10-30');


INSERT INTO Borrowing (MemberID, BookID, BorrowingDate, DueDate, ReturnDate)
VALUES 
(13, 1, '2024-01-01', '2024-01-15', '2024-01-14'),
(14, 2, '2024-01-02', '2024-01-16', '2024-01-17'),
(15, 3, '2024-01-03', '2024-01-17', '2024-01-18'),
(16, 4, '2024-01-04', '2024-01-18', '2024-01-19'),
(17, 5, '2024-01-05', '2024-01-19', '2024-01-20'),
(18, 6, '2024-01-06', '2024-01-20', '2024-01-21');
------------------------------------------------------------------------------------------
INSERT INTO Borrowing (MemberID, BookID, BorrowingDate, DueDate, ReturnDate)
VALUES 
(13, 4, '2024-01-01', '2024-01-15', '2024-01-14'),
(15, 4, '2024-01-01', '2024-01-15', '2024-01-14'),
(17, 4, '2024-01-01', '2024-01-15', '2024-01-14'),
(14, 2, '2024-01-01', '2024-01-15', '2024-01-14'),
(16, 2, '2024-01-01', '2024-01-15', '2024-01-14');

INSERT INTO Borrowing (MemberID, BookID, BorrowingDate, DueDate, ReturnDate)
VALUES 
(13, 2, '2024-01-01', '2024-01-15', '2024-01-14');

INSERT INTO Borrowing (MemberID, BookID, BorrowingDate, DueDate)
VALUES 
(18, 5, '2024-01-01', '2024-01-15');
------------------------------------------------------------------------------------------

INSERT INTO LibraryStaff (Name, ContactInfo, AssignedSection, EmploymentDate)
VALUES 
('Sara', 5566778899, 'Section A', '2020-01-01'),
('Khalid', 6677889900, 'Section B', '2021-02-02'),
('Noura', 7788990011, 'Section C', '2022-03-03'),
('Fahad', 8899001122, 'Section D', '2023-04-04'),
('Hessa', 9900112233, 'Section E', '2024-05-05'),
('Abdullah', 0011223344, 'Section F', '2025-06-06');


INSERT INTO Categories (Name, Description)
VALUES 
('Computer Science', 'Books related to computer science'),
('Fiction', 'Fictional books'),
('Science Fiction', 'Science fiction books'),
('Programming', 'Books about programming languages'),
('Literature', 'Classic literature'),
('History', 'Historical books');


INSERT INTO BookCategory (BookID, CategorieID)
VALUES 
(1, 1),
(2, 1),
(3, 4),
(4, 2),
(5, 3),
(6, 2);


INSERT INTO Reservations (MemberID, BookID, ReservationDate, Status)
VALUES 
(13, 1, '2024-01-01', 'Completed'),
(14, 2, '2024-01-02', 'Pending'),
(15, 3, '2024-01-03', 'Cancelled'),
(16, 4, '2024-01-04', 'Completed'),
(17, 5, '2024-01-05', 'Pending'),
(18, 6, '2024-01-06', 'Cancelled');


INSERT INTO FinancialFines (MemberID, Amount, PaymentStatus)
VALUES 
(13, 10.00, 'Paid'),
(14, 15.00, 'Unpaid'),
(15, 20.00, 'Paid'),
(16, 25.00, 'Unpaid'),
(17, 30.00, 'Paid'),
(18, 35.00, 'Unpaid');


---------------------------------------------------------------------
------- Querie Questions -------
---------------------------------------------------------------------

-- Q1-
SELECT * FROM Members WHERE RegistrationDate = '2025-01-01';

-- Q2-
SELECT * FROM Books WHERE Title = 'Database Fundamentals'

-- Q3-
ALTER TABLE Members ADD Email VARCHAR(100);

-- Q4-
INSERT INTO Members (Name, ContactInformation, MembershipType, RegistrationDate, Email)
VALUES ('Omar', 9876543210, 'Student', '2024-06-05', 'Omar@gmail.com');

-- Q5-
SELECT DISTINCT M.* 
FROM Members M
JOIN Reservations R ON M.ID = R.MemberID;

-- Q6-
SELECT M.* 
FROM Members M
JOIN Borrowing B ON M.ID = B.MemberID
JOIN Books BK ON B.BookID = BK.ID
WHERE BK.Title = 'SQL for Beginners';

-- Q7-
SELECT M.* 
FROM Members M
JOIN Borrowing B ON M.ID = B.MemberID
JOIN Books BK ON B.BookID = BK.ID
WHERE BK.Title = 'C# Programming' AND B.ReturnDate IS NOT NULL;

-- Q8-
SELECT M.* 
FROM Members M
JOIN Borrowing B ON M.ID = B.MemberID
WHERE B.ReturnDate > B.DueDate;

-- Q9-
SELECT BK.Title, COUNT(B.BookID) AS BorrowCount 
FROM Books BK
JOIN Borrowing B ON BK.ID = B.BookID
GROUP BY BK.Title
HAVING COUNT(B.BookID) > 3;

-- Q10-
SELECT M.* 
FROM Members M
JOIN Borrowing B ON M.ID = B.MemberID
WHERE B.BorrowingDate BETWEEN '2024-01-01' AND '2024-01-10';

-- Q11-
SELECT COUNT (B.ID) AS Total_Books FROM Books B

-- Q12-
SELECT M.* 
FROM Members M
JOIN Borrowing B ON M.ID = B.MemberID
WHERE B.ReturnDate IS NULL

-- Q13-
SELECT M.*
FROM Members M
JOIN Borrowing B ON M.ID = B.MemberID
JOIN Books BK ON B.BookID = BK.ID
JOIN BookCategory BC ON BK.ID = BC.BookID
JOIN Categories C ON BC.CategorieID = C.ID
WHERE C.Name = 'Science Fiction';












