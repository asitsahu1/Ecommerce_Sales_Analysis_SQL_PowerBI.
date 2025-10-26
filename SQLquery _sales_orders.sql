create database customer_data


SELECT * from [dbo].[data_of_cust]

-- Create a clean table with filtered data
SELECT *
INTO clean_orders
FROM [dbo].[data_of_cust]
WHERE CustomerID IS NOT NULL
  AND Quantity IS NOT NULL AND Quantity > 0
  AND UnitPrice IS NOT NULL AND UnitPrice > 0
  AND InvoiceNo NOT LIKE 'C%';


SELECT TOP 10 * 
FROM clean_orders;

-- Quantity as INT
ALTER TABLE clean_orders
ALTER COLUMN Quantity INT;

-- UnitPrice as DECIMAL(10,2)
ALTER TABLE clean_orders
ALTER COLUMN UnitPrice DECIMAL(10,2);

-- CustomerID as INT
ALTER TABLE clean_orders
ALTER COLUMN CustomerID INT;

SELECT * from clean_orders

--Check for any remaining NULL values
SELECT 
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS NullCustomerID,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS NullQuantity,
    SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END) AS NullUnitPrice
FROM clean_orders;

--Check for canceled invoices (should be none)
select count(*) as cancelledorder
from clean_orders
where InvoiceNo like 'c%';

SELECT COUNT(*) AS TotalRawRows FROM [dbo].[data_of_cust]
SELECT COUNT(*) AS TotalCleanRows FROM clean_orders;

--1️ Total Revenue

SELECT 
    ROUND(SUM(Quantity * UnitPrice), 2) AS Total_Revenue
FROM clean_orders;

--2️ Total Orders & Unique Customers

SELECT 
    COUNT(DISTINCT InvoiceNo) AS Total_Orders,
    COUNT(DISTINCT CustomerID) AS Unique_Customers
FROM clean_orders;

--3️ Top 10 Best-Selling Products
SELECT TOP 10 
    Description AS Product,
    SUM(Quantity) AS Total_Quantity_Sold
FROM clean_orders
GROUP BY Description
ORDER BY Total_Quantity_Sold DESC;

--4.Top 10 Customers by Spending
SELECT TOP 10 
    CustomerID,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Total_Spent
FROM clean_orders
GROUP BY CustomerID
ORDER BY Total_Spent DESC;

--5.Monthly Revenue Trend
SELECT 
    YEAR(CONVERT(datetime, InvoiceDate, 103)) AS Year,
    MONTH(CONVERT(datetime, InvoiceDate, 103)) AS Month,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Monthly_Revenue
FROM clean_orders
GROUP BY YEAR(CONVERT(datetime, InvoiceDate, 103)), MONTH(CONVERT(datetime, InvoiceDate, 103))
ORDER BY Year, Month;
 
-- 6.Sales by Country
SELECT 
    Country,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Total_Sales
FROM clean_orders
GROUP BY Country
ORDER BY Total_Sales DESC;

--7.Average Order Value (AOV)
SELECT 
    ROUND(SUM(Quantity * UnitPrice) / COUNT(DISTINCT InvoiceNo), 2) AS Avg_Order_Value
FROM clean_orders;

--Most Active Customers (by Number of Orders)
SELECT TOP 10 
    CustomerID,
    COUNT(DISTINCT InvoiceNo) AS Orders_Count
FROM clean_orders
GROUP BY CustomerID
ORDER BY Orders_Count DESC;

--Peak Order Times (Hour of Day)
SELECT 
    DATEPART(HOUR, InvoiceDate) AS Hour_Of_Day,
    COUNT(DISTINCT InvoiceNo) AS Orders_Count
FROM clean_orders
GROUP BY DATEPART(HOUR, InvoiceDate)
ORDER BY Orders_Count DESC;

--🔟 Revenue by Product Category (if Description grouped)
SELECT 
    CASE 
        WHEN Description LIKE '%BAG%' THEN 'Bags'
        WHEN Description LIKE '%SHIRT%' THEN 'Clothing'
        WHEN Description LIKE '%MUG%' THEN 'Mugs'
        ELSE 'Others'
    END AS Category,
    ROUND(SUM(Quantity * UnitPrice), 2) AS Total_Sales
FROM clean_orders
GROUP BY 
    CASE 
        WHEN Description LIKE '%BAG%' THEN 'Bags'
        WHEN Description LIKE '%SHIRT%' THEN 'Clothing'
        WHEN Description LIKE '%MUG%' THEN 'Mugs'
        ELSE 'Others'
    END
ORDER BY Total_Sales DESC;






SELECT TOP 5 * 
FROM clean_orders;


