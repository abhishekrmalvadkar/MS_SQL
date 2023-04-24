--Create customers table

create table customers(
id int Primary key,
name varchar(10) not null,
email varchar(20) unique not null,
phone varchar(13) not null,
constraint check_phone check(phone like '+91%')
)

--Create orders table

create table orders(
order_id int primary key,
customer_id int not null,
order_date date not null,
total decimal (10,2) not null,
constraint fk_customer_id foreign key (customer_id) references customers(id),
constraint check_total check(total > 0)
);

--Insert records into customers and orders tables

INSERT INTO customers (id, name, email, phone)
VALUES (1, 'CustOne', 'CustOne@email.com', '+9184848484'),
       (2, 'CustTwo', 'CustTwo@email.com', '+9184848484'),
       (3, 'CustThree', 'CustThree@email.com', '+9184848484');
	   

-- Alter the table to change the data length of phone attribute from varchar(13) to varchar(15)
	   
alter table customers 
alter column phone varchar(15);

-- create a view to fecth the details of customers whose spend is greater than or equal to 1000.00
create view some_customers 
as select c.id,c.[name],c.email,c.phone, o.order_id,o.order_date,o.total from customers c join orders o on 
c.id = o.customer_id
where total >= 1000.00

select * from some_customers;

--Rename the recently created temp table name

sp_rename 'some_customers', 'some_cust';

select * from some_customers;

select * from some_cust;

-- SP to get the total order counts and the corresponding sum value of the orders

CREATE PROCEDURE get_customer_orders (
   @customer_id INT,
   @order_count INT OUTPUT,
   @total_spent DECIMAL(10,2) OUTPUT
)
AS
BEGIN
   SELECT @order_count = COUNT(*), @total_spent = SUM(total)
   FROM orders
   WHERE customer_id = @customer_id;
END;

DECLARE @order_count INT;
DECLARE @total_spent DECIMAL(10,2);

EXEC get_customer_orders @customer_id = 1, @order_count = @order_count OUTPUT, @total_spent = @total_spent OUTPUT;

SELECT @order_count AS 'Order Count', @total_spent AS 'Total Spent';

-- SP to INSERT the records:

CREATE PROCEDURE insert_employee (
   @cust_id INT,
   @cust_name VARCHAR(50),
   @cust_email VARCHAR(50),
   @cust_phone VARCHAR(15)
)
AS
BEGIN
   INSERT INTO customers (id,[name],email,phone)
   VALUES (@cust_id,@cust_name, @cust_email, @cust_phone);
END;

EXEC insert_employee @cust_id = 13, @cust_name = 'Abhishek', @cust_email = 'email@gmail',@cust_phone='+9199009900';

--SP to fetch the records 


CREATE PROCEDURE get_cust_orders (
   @customer_id INT
)
AS
BEGIN
   SELECT * FROM orders
   WHERE customer_id = @customer_id;
END;

EXEC get_cust_orders @customer_id = 1;

--SP to UPDATE the records

CREATE PROCEDURE update_order_date (
   @order_id INT,
   @new_date DATE
)
AS
BEGIN
   UPDATE orders SET order_date = @new_date
   WHERE order_id = @order_id;
END;


EXEC update_order_date @order_id = 1, @new_date='2023-05-10';

--SP to DELETE customers 

-- We have to first set the DELETE CASCADE to ON state because orders and customers tables are linked with the cusomer_id as a foreign key

ALTER TABLE orders
DROP CONSTRAINT fk_customer_id;

ALTER TABLE orders
ADD CONSTRAINT fk_customer_id
FOREIGN KEY (customer_id)
REFERENCES customers(id)
ON DELETE CASCADE;

CREATE PROCEDURE delete_cust (
   @customer_id INT
)
AS
BEGIN
   DELETE FROM customers
   WHERE id = @customer_id;
END;

EXEC delete_cust @customer_id = 1
