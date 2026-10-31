CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50) NOT NULL UNIQUE
);

SELECT * FROM Departments;


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    Salary DECIMAL(10,2),
    DepartmentID int
);

SELECT * FROM Employees;
SELECT * FROM Departments;

ALTER TABLE Employees ADD PhoneNumber VARCHAR(20);
DROP TABLE TemporaryStaff;

INSERT INTO Departments
VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');


INSERT INTO Employees
VALUES
(1, 'Ahmad Ali', 'ahmad@techworld.com', 1200.00, 1, '0791111111'),
(2, 'Sara Hassan', 'sara@techworld.com', 950.00, 2, '0792222222'),
(3, 'Zaid Omar', 'zaid@techworld.com', 1500.00, 1, '0793333333'),
(4, 'Mona Khaled', 'mona@techworld.com', 800.00, 3, '0794444444');



UPDATE Employees
SET Salary = 1350.00
WHERE EmployeeID = 1;



DELETE FROM Employees
WHERE EmployeeID = 4;
SELECT * FROM Employees;


SELECT FullName, Salary
FROM Employees;


SELECT SUM(Salary) AS TotalSalaries
FROM Employees;


SELECT AVG(Salary) AS AverageSalary
FROM Employees;




SELECT
    MAX(Salary) AS HighestSalary,
    MIN(Salary) AS LowestSalary
FROM Employees;


SELECT COUNT(*) AS TotalEmployees
FROM Employees;




-----------------------task2-----------------------------------------------------------------
select * from Employees;

create table AccessCards (
CardID int primary key,
CardNumber varchar(50) not null unique,
EmployeeID int unique ,
FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID))
;
select * from AccessCards;

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL
);


CREATE TABLE EmployeeProjects (
    EmployeeID INT NOT NULL,
    ProjectID INT NOT NULL,
    AssignedDate DATE,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

INSERT INTO AccessCards (CardID, CardNumber, EmployeeID)
VALUES
(101, 'CARD-101', 1),
(102, 'CARD-102', 2),
(103, 'CARD-103', 3);

INSERT INTO Projects (ProjectID, ProjectName)
VALUES
(1, 'AI & Security Training'),
(2, 'Cloud Migration');

INSERT INTO EmployeeProjects (EmployeeID, ProjectID, AssignedDate)
VALUES
(1, 1, GETDATE()),
(1, 2, GETDATE()),
(2, 1, GETDATE()),
(3, 2, GETDATE());

SELECT
    E.FullName,
    E.Salary,
    D.DepartmentName
FROM Employees AS E
INNER JOIN Departments AS D
    ON E.DepartmentID = D.DepartmentID;

select * from EmployeeProjects;

SELECT
    D.DepartmentName,
    E.FullName
FROM Departments AS D
LEFT JOIN Employees AS E
    ON D.DepartmentID = E.DepartmentID;

SELECT
    E.FullName,
    A.CardNumber
FROM Employees AS E
INNER JOIN AccessCards AS A
    ON E.EmployeeID = A.EmployeeID;


SELECT
    E.FullName,
    P.ProjectName,
    EP.AssignedDate
FROM Employees AS E
INNER JOIN EmployeeProjects AS EP
    ON E.EmployeeID = EP.EmployeeID
INNER JOIN Projects AS P
    ON EP.ProjectID = P.ProjectID;


--Task 7.1: Department Salary Analysis (GROUP BY)
SELECT
    DepartmentID,
    SUM(Salary) AS TotalSalary,
    COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID;

--Task 7.2: Filtering Grouped Results (HAVING)

SELECT
    DepartmentID,
    AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentID
HAVING AVG(Salary) > 1000.00;


--Task 7.3: Subqueries
SELECT *
FROM Employees
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employees
);

--Task 7.4: Views
CREATE VIEW vw_EmployeeDetails
AS
SELECT
    E.EmployeeID,
    E.FullName,
    E.Email,
    D.DepartmentName
FROM Employees AS E
INNER JOIN Departments AS D
    ON E.DepartmentID = D.DepartmentID;

SELECT *
FROM vw_EmployeeDetails;


--Task 7.5: Stored Procedures
CREATE PROCEDURE sp_GetEmployeesByDepartment
    @DeptID INT
AS
BEGIN
    SELECT *
    FROM Employees
    WHERE DepartmentID = @DeptID;
END;

EXEC sp_GetEmployeesByDepartment @DeptID = 1;