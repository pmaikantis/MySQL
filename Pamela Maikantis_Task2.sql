CREATE DATABASE task2;
USE task2;

SELECT * FROM Customers;
SELECT * FROM OrderDetails;
SELECT * FROM Orders;
SELECT * FROM Products;

ALTER TABLE Customers
ADD Customer_ID INT IDENTITY (1,1) PRIMARY KEY

ALTER TABLE Orders
ADD Order_ID INT IDENTITY (1,1) PRIMARY KEY

ALTER TABLE OrderDetails
ADD Order_ID INT IDENTITY (1,1) PRIMARY KEY

ALTER TABLE Products
ADD Product_ID INT IDENTITY (1,1) PRIMARY KEY

ALTER TABLE Products
ADD FOREIGN KEY (Product_ID) REFERENCES Orders(Order_ID);

ALTER TABLE Customers
ADD FOREIGN KEY (Customer_ID) REFERENCES Orders(Order_ID);

ALTER TABLE Orders
ADD FOREIGN KEY (Order_ID) REFERENCES OrderDetails(Order_ID);


SELECT  Ord.CustomerID, Cust.CompanyName, Cust.Address, Ord.OrderID, 
SUM(Ordtl.UnitPrice * Ordtl.Quantity) AS Total
FROM Customers Cust
INNER JOIN 
Orders Ord ON Cust.CustomerID = Ord.CustomerID
INNER JOIN
OrderDetails Ordtl ON Ordtl.OrderID = Ord.OrderID
GROUP BY Ord.CustomerID, Cust.CompanyName, Cust.Address,Ord.OrderID 
ORDER BY CustomerID

CREATE VIEW CustomersView AS
SELECT Cust.CompanyName, Cust.Address, Cust.City, Ord.OrderDate
FROM Customers Cust
JOIN Orders Ord ON Cust.CustomerID = Ord.CustomerID;

SELECT * FROM CustomersView;

SELECT * FROM CustomersView 
WHERE City ='London' 
ORDER BY CompanyName

CREATE PROCEDURE ProductSearch
    @CategoryID INT = NULL,
    @SupplierID INT = NULL
AS
BEGIN
    SELECT *
    FROM Products
    WHERE (@CategoryID IS NULL OR CategoryID = @CategoryID)
      AND (@SupplierID IS NULL OR SupplierID = @SupplierID)
END;

EXEC ProductSearch @CategoryID = 1, @SupplierID = 1;

CREATE FUNCTION GetOrdersByCountry
(
    @CountryName NVARCHAR(100),
    @StartDate DATE,
    @EndDate DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT Cust.CompanyName, Cust.Address, Cust.City, Ord.OrderDate
    FROM Customers Cust
    JOIN Orders Ord ON Cust.CustomerID = Ord.CustomerID
    WHERE Cust.Country = @CountryName
      AND Ord.OrderDate BETWEEN @StartDate AND @EndDate
);

SELECT * FROM GetOrdersByCountry
('Germany', '1996-01-01', '1997-12-31');

CREATE NONCLUSTERED INDEX IX_Customers_CustomerID
ON Customers(CustomerID);

CREATE CLUSTERED INDEX IX_Customers_CompanyName
ON Customers(CompanyName);

ALTER TABLE Customers
DROP CONSTRAINT PK__Customer__8CB286B98A4863C3;

CREATE UNIQUE NONCLUSTERED INDEX IX_Customers_CompanyName
ON Customers(CompanyName);