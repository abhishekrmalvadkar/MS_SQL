-- Create a table called 'Orders'
CREATE TABLE Orders (
   OrderID INT PRIMARY KEY,
   CustomerID INT NOT NULL,
   OrderDate DATE NOT NULL,
   TotalAmount DECIMAL(10,2) NOT NULL,
   CONSTRAINT FK_CustomerOrders FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create a table called 'OrderItems'
CREATE TABLE OrderItems (
   OrderItemID INT PRIMARY KEY,
   OrderID INT NOT NULL,
   ProductID INT NOT NULL,
   Quantity INT NOT NULL,
   Price DECIMAL(10,2) NOT NULL,
   CONSTRAINT FK_OrderItemsOrders FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
   CONSTRAINT FK_OrderItemsProducts FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert some sample data into the 'Orders' table
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(1, 1, '2020-01-01', 100.00),
(2, 2, '2020-02-01', 200.00),
(3, 3, '2020-03-01', 300.00);

-- Insert some sample data into the 'OrderItems' table
INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1, 1, 1, 50.00),
(2, 1, 2, 2, 25.00),
(3, 2, 3, 3, 30.00),
(4, 2, 4, 1, 70.00),
(5, 3, 1, 2, 50.00),
(6, 3, 2, 1, 50.00);

-- Select all records from the 'Orders' table with related data from 'OrderItems' and 'Customers'
SELECT O.OrderID, O.CustomerID, C.FirstName, C.LastName, O.OrderDate, O.TotalAmount, SUM(OI.Quantity * OI.Price) AS TotalItemsAmount
FROM Orders O
INNER JOIN OrderItems OI ON O.OrderID = OI.OrderID
INNER JOIN Customers C ON O.CustomerID = C.CustomerID
GROUP BY O.OrderID, O.CustomerID, C.FirstName, C.LastName, O.OrderDate, O.TotalAmount;

-- Add a check constraint to the 'Orders' table to ensure the TotalAmount is greater than 0
ALTER TABLE Orders ADD CONSTRAINT CHK_TotalAmount CHECK (TotalAmount > 0);

-- Add a check constraint to the 'OrderItems' table to ensure the Quantity and Price are greater than 0
ALTER TABLE OrderItems ADD CONSTRAINT CHK_Quantity CHECK (Quantity > 0);
ALTER TABLE OrderItems ADD CONSTRAINT CHK_Price CHECK (Price > 0);

-- Insert a new order with related order items
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(4, 2, '2020-04-01', 250.00);

INSERT INTO OrderItems (OrderItemID, OrderID, ProductID, Quantity, Price) VALUES
(7, 4, 2, 3, 25.00),
(8, 4, 5, 2, 100.00);

-- Attempt to insert an order with a total amount of 0, which will fail due to the check constraint
INSERT INTO Orders (OrderID, CustomerID, OrderDate, TotalAmount) VALUES
(5, 1, '2020-05-01', 0.00);
