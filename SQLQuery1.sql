CREATE DATABASE data_base;
GO

USE data_base;
GO

-- Actor Table
CREATE TABLE actor
(
    act_id INT PRIMARY KEY,
    act_fname CHAR(20),
    act_lname CHAR(20),
    act_gender CHAR(1)
);


-- Director Table
CREATE TABLE director
(
    dir_id INT PRIMARY KEY,
    dir_fname CHAR(20),
    dir_lname CHAR(20)
);


-- Movie Table
CREATE TABLE movie
(
    mov_id INT PRIMARY KEY,
    mov_title CHAR(50),
    mov_year INT,
    mov_time INT,
    mov_lang CHAR(50),
    mov_dt_rel DATE,
    mov_rel_country CHAR(5)
);


-- Movie Direction Table
CREATE TABLE movie_direction
(
    dir_id INT,
    mov_id INT,

    FOREIGN KEY (dir_id)
        REFERENCES director(dir_id),

    FOREIGN KEY (mov_id)
        REFERENCES movie(mov_id)
);


-- Movie Cast Table
CREATE TABLE movie_cast
(
    act_id INT,
    mov_id INT,
    role CHAR(30),

    FOREIGN KEY (act_id)
        REFERENCES actor(act_id),

    FOREIGN KEY (mov_id)
        REFERENCES movie(mov_id)
);


-- Reviewer Table
CREATE TABLE reviewer
(
    rev_id INT PRIMARY KEY,
    rev_name CHAR(30)
);


-- Genres Table
CREATE TABLE genres
(
    gen_id INT PRIMARY KEY,
    gen_title CHAR(20)
);


-- Movie Genres Table
CREATE TABLE movie_genres
(
    mov_id INT,
    gen_id INT,

    FOREIGN KEY (mov_id)
        REFERENCES movie(mov_id),

    FOREIGN KEY (gen_id)
        REFERENCES genres(gen_id)
);


-- Rating Table
CREATE TABLE rating
(
    mov_id INT,
    rev_id INT,
    rev_stars INT,
    num_o_ratings INT,

    FOREIGN KEY (mov_id)
        REFERENCES movie(mov_id),

    FOREIGN KEY (rev_id)
        REFERENCES reviewer(rev_id)
);






-- Create Employees table with:
-- ID, Name, Salary

CREATE TABLE Employees
(
    ID INT,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- Add Department column


ALTER TABLE Employees
ADD Department VARCHAR(50);
-- Remove Salary column
ALTER TABLE Employees
DROP COLUMN Salary;


-- Rename Department to DeptName
EXEC sp_rename
    'Employees.Department',
    'DeptName',
    'COLUMN';

-- Create Projects table
CREATE TABLE Projects
(
    ProjectID INT,
    ProjectName VARCHAR(50)
);
-- Add Primary Key to Employees.ID
ALTER TABLE Employees
ADD CONSTRAINT PK_Employees
PRIMARY KEY (ID);
-- ProjectID must be PK/Unique
-- because Employees will reference it

ALTER TABLE Projects
ADD CONSTRAINT PK_Projects
PRIMARY KEY (ProjectID);
-- Foreign Key:
-- Employees.ID -> Projects.ProjectID

ALTER TABLE Employees
ADD CONSTRAINT FK_Employees_Projects
FOREIGN KEY (ID)
REFERENCES Projects(ProjectID);

-- Remove Foreign Key

ALTER TABLE Employees
DROP CONSTRAINT FK_Employees_Projects;

-- Add UNIQUE constraint to Employees.Name
ALTER TABLE Employees
ADD CONSTRAINT UQ_Employees_Name
UNIQUE (Name);
-- Create Customers table

CREATE TABLE Customers
(
    CustomerID INT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Status VARCHAR(20)
);


-- UNIQUE FirstName + LastName

ALTER TABLE Customers
ADD CONSTRAINT UQ_Customers_FirstName_LastName
UNIQUE (FirstName, LastName);


-- Default Status = Active

ALTER TABLE Customers
ADD CONSTRAINT DF_Customers_Status
DEFAULT 'Active' FOR Status;


-- Create Orders table
CREATE TABLE Orders
(
    OrderID INT,
    CustomerID INT,
    OrderDate DATETIME,
    TotalAmount DECIMAL(10,2)
);

-- TotalAmount must be greater than zero

ALTER TABLE Orders
ADD CONSTRAINT CK_Orders_TotalAmount
CHECK (TotalAmount > 0);

-- Create Sales Schema

CREATE SCHEMA Sales;
GO



ALTER SCHEMA Sales
TRANSFER dbo.Orders;
GO

-- Rename Orders to SalesOrders


EXEC sp_rename
    'Sales.Orders',
    'SalesOrders';
GO
ALTER TABLE Employees
ADD Salary DECIMAL(10,2);
-- 1. Select all columns from Employees
SELECT *
FROM Employees;

-- 2. Select only Name and Salary
SELECT Name, Salary
FROM Employees;
-- 3. Select distinct DeptName values
SELECT DISTINCT DeptName
FROM Employees;


-- 4. Select top 5 records
SELECT TOP 5 *
FROM Employees;


-- 5. Select all records ordered by Salary descending
SELECT *
FROM Employees
ORDER BY Salary DESC;


-- 6. Select first 10 records starting from third record
SELECT *
FROM Employees
ORDER BY ID
OFFSET 2 ROWS
FETCH NEXT 10 ROWS ONLY;


-- 7. Select average Salary
SELECT AVG(Salary) AS AverageSalary
FROM Employees;


-- 8. Select maximum and minimum Salary
SELECT
    MAX(Salary) AS MaximumSalary,
    MIN(Salary) AS MinimumSalary
FROM Employees;


-- 9. Select top 3 highest salaries
SELECT TOP 3 *
FROM Employees
ORDER BY Salary DESC;


-- 10. Select all records ordered by Name ascending
SELECT *
FROM Employees
ORDER BY Name ASC;


-- 11. Select first 5 records starting from second record
-- ordered by Salary descending
SELECT *
FROM Employees
ORDER BY Salary DESC
OFFSET 1 ROWS
FETCH NEXT 5 ROWS ONLY;


-- 12. Select sum of all salaries
SELECT SUM(Salary) AS TotalSalaries
FROM Employees;


-- 13. Salary between 40000 and 60000
-- ordered by Salary ascending
SELECT *
FROM Employees
WHERE Salary BETWEEN 40000 AND 60000
ORDER BY Salary ASC;