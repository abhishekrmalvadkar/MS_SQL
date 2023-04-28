--create department table 

create table view_department
(
id int primary key,
dept_name varchar(10),
constraint check_id check(id in (1,2,3,4,5))
)


--create employee table

create table view_employee
(
emp_id int primary key,
emp_name varchar(20),
gender varchar(10),
salary int,
city varchar(20), 
dept_id int not null,
constraint fk_dept_id foreign key(dept_id) references view_department(id)
)

--Insert data into dept and employee tables

insert into view_department (id, dept_name) values ('1','DE'),('2', 'DA'),('3','HR'),('4','Accounts'),('5','admin');

insert into view_employee (emp_id,emp_name,gender,salary,city,dept_id) values 
(2,'empTwo','male',2000,'hyd',1),(3,'empThree','female',3000,'hyd',2),(4,'empFour','female',5000,'Bangalore',3),
(5,'empFive','male',10000,'Mumbai',1),(6,'empSix','female',2000,'hyd',4),(7,'empSeven','male',12000,'hyd',5)

--create view to fetch all the records

create view emp_view
as
select * from view_employee as A inner join view_department as B on 
A.dept_id = B.id;

select * from emp_view

--create a view to fetch the highest salary from each dept 

create view emp_view1
as
SELECT A.dept_id, B.dept_name, MAX(A.salary) AS highest_salary
FROM view_employee AS A
INNER JOIN view_department AS B ON A.dept_id = B.id
GROUP BY A.dept_id, B.dept_name;

select * from emp_view1

--display the code of the view

sp_helptext emp_view1

--Alter the view 

create view emp_view2
as
SELECT *
FROM view_employee AS A
INNER JOIN view_department AS B ON A.dept_id = B.id
where B.dept_name in ('HR','de')

select * from emp_view2

alter view emp_view2
as
SELECT *
FROM view_employee AS A
INNER JOIN view_department AS B ON A.dept_id = B.id
where B.dept_name in ('HR','de')

select * from emp_view2

--drop view 

drop view emp_view2

--Insert data by creating views 

create view insert_data
as
SELECT *
FROM view_employee 

insert into insert_data values (8,'empEight','male',13000,'BLR',2)
select * from insert_data

--Update the data from views

update insert_data 
set salary = '20000' where emp_id = 8

--Delete the data from views 

delete from insert_data where emp_id = 7


--Uses of creating views: -

--Simplifying queries: Views can be used to simplify complex queries that involve multiple tables or joins by encapsulating the logic in a single view. 
--This can make it easier for developers and analysts to write and maintain queries, and can also improve query performance by reducing the amount of 
--data that needs to be processed.

--Enhancing security: Views can be used to control access to sensitive data by restricting access to specific columns or rows of a table. 
--This can help to prevent unauthorized access to sensitive data and can also help to ensure that users only see the data that they are authorized 
--to access.
