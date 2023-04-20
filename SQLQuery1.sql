CREATE TABLE departments (
  department_id INT NOT NULL CONSTRAINT PK_departments PRIMARY KEY,
  department_name VARCHAR(50) NOT NULL CONSTRAINT UQ_departments_department_name UNIQUE
);

CREATE TABLE employees (
  employee_id INT NOT NULL CONSTRAINT PK_employees PRIMARY KEY,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  hire_date DATE NOT NULL,
  salary DECIMAL(10,2) NOT NULL CONSTRAINT CK_employees_salary CHECK (salary > 0),
  department_id INT NOT NULL CONSTRAINT FK_employees_department_id FOREIGN KEY REFERENCES departments(department_id)
);
