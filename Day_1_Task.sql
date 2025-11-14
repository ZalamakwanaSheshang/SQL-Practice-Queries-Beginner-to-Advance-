-- Advance SQL Day 1 Task: Create Store Procedure for 1-7 query question from Assesment-2.

USE SHESHANG1

SELECT * FROM CUSTOMERS
SELECT * FROM PRODUCTS
SELECT * FROM ORDERS

-- 1. Write a query to retrieve the CustomerName and the OrderDate for all orders placed.
SELECT C.CustomerName, O.OrderDate
FROM Customers C
JOIN Orders O
ON C.CustomerID = O.CustomerID

-- 2. Find the CustomerName and City of all customers who have placed at least one order.
SELECT C.CustomerName, C.City, COUNT(O.CustomerID) AS TOTAL_ORDER_PLACED
FROM Customers C
JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName, C.City
HAVING COUNT(O.CustomerID) >= 1

-- 3. List all CustomerNames and their corresponding OrderIDs. Include customers who have 
-- not placed any orders. 
SELECT C.CustomerName, O.OrderID
FROM Customers C
LEFT JOIN Orders O
ON C.CustomerID = O.CustomerID

-- 4. Calculate the total revenue generated from each City. Display the City and the 
-- TotalRevenue, sorted in descending order of revenue.
SELECT C.City, SUM(O.TotalAmount) AS TotalRevenue
FROM Customers C
JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.City
ORDER BY TotalRevenue DESC

-- 5. Find the top 3 customers who have spent the most money. Display their CustomerName 
-- and TotalSpending.
SELECT TOP 3 C.CustomerName, SUM(O.TotalAmount) AS TotalSpending
FROM Customers C
JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName
ORDER BY TotalSpending DESC

-- 6. Retrieve the CustomerName and TotalAmount for all orders placed on the Date: 15th 
-- August.
SELECT C.CustomerName, O.TotalAmount, O.OrderDate
FROM Customers C
JOIN Orders O
ON C.CustomerID = O.CustomerID
WHERE O.OrderDate = '2025-08-15'

-- 7. Retrieve the CustomerName and CustomerID of customers who have placed an order 
-- but their TotalAmount is greater than 1000.
SELECT C.CustomerName, C.CustomerID, SUM(O.TotalAmount) AS TotalAmount
FROM Customers C
JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerName, C.CustomerID
HAVING SUM(O.TotalAmount) > 1000
