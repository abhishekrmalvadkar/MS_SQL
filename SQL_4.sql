-- Create a table called 'Employees'
CREATE TABLE Employees (
   EmployeeID INT PRIMARY KEY,
   FirstName VARCHAR(50) NOT NULL,
   LastName VARCHAR(50) NOT NULL,
   Email VARCHAR(100) NOT NULL,
   DepartmentID INT NOT NULL,
   HireDate DATE NOT NULL,
   Salary DECIMAL(10,2) NOT NULL,
   CONSTRAINT FK_EmployeesDepartments FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
   CONSTRAINT CK_EmailFormat CHECK (Email LIKE '%@%.%'),
   CONSTRAINT CK_HireDate CHECK (HireDate <= GETDATE()),
   CONSTRAINT CK_Salary CHECK (Salary >= 0),
   CONSTRAINT UC_Employee UNIQUE (FirstName, LastName)
);

-- Create a table called 'Departments'
CREATE TABLE Departments (
   DepartmentID INT PRIMARY KEY,
   DepartmentName VARCHAR(50) NOT NULL,
   ManagerID INT NOT NULL,
   CONSTRAINT FK_DepartmentsManagers FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

-- Insert some sample data into the 'Departments' table
INSERT INTO Departments (DepartmentID, DepartmentName, ManagerID) VALUES
(1, 'Sales', 2),
(2, 'Marketing', 1),
(3, 'IT', 3);

-- Insert some sample data into the 'Employees' table
INSERT INTO Employees (EmployeeID, FirstName, LastName, Email, DepartmentID, HireDate, Salary) VALUES
(1, 'One', 'One', 'One@gmail.com', 2, '2020-01-01', 50000.00),
(2, 'Two', 'Two', 'Two@gmail.com', 1, '2019-01-01', 60000.00),
(3, 'Three', 'Three', 'Three@gmail.com', 3, '2021-01-01', 70000.00);

-- Update the salary of an employee with the ID of 1
UPDATE Employees SET Salary = 65000.00 WHERE EmployeeID = 1;

-- Delete an employee with the ID of 3
DELETE FROM Employees WHERE EmployeeID = 3;

-- Select all records from the 'Employees' table with related data from 'Departments'
SELECT E.EmployeeID, E.FirstName, E.LastName, E.Email, D.DepartmentName, E.HireDate, E.Salary
FROM Employees E
INNER JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- Select all employees with a salary greater than 55000
SELECT EmployeeID, FirstName, LastName, Email, Salary FROM Employees WHERE Salary > 55000;

-- Select all employees hired before January 1st, 2021
SELECT EmployeeID, FirstName, LastName, Email, HireDate FROM Employees WHERE HireDate < '2021-01-01';

-- Select all employees whose first name begins with 'T'
SELECT EmployeeID, FirstName, LastName, Email FROM Employees WHERE FirstName LIKE 'T%';

-- Select the distinct last names of all employees
SELECT DISTINCT LastName FROM Employees;

-- Select all employees sorted by salary in descending order
SELECT EmployeeID, FirstName, LastName, Email, Salary FROM Employees ORDER BY Salary DESC;

-- Select all employees whose email contains the domain 'gmail.com'
SELECT EmployeeID, FirstName, LastName, Email FROM Employees WHERE Email LIKE '%@gmail.com';

-- Select all employees whose salary falls between 50000 and 70000
SELECT EmployeeID, FirstName, LastName, Email, Salary FROM Employees WHERE Salary BETWEEN 50000 AND 70000;

