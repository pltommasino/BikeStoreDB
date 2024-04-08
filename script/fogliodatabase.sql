SHOW DATABASES;

#SELECT COUNT(*) AS check_warning_row FROM BikeStoreDB.Orders
#WHERE Shipped_date=0000-00-00;

#SELECT COUNT(*) AS total_row FROM BikeStoreDB.Orders;

-- The first 3 person who spent the most in the shop
SELECT *
FROM Customers
WHERE Customer_ID IN
(
SELECT Customer_ID
FROM Orders
WHERE Order_ID IN (1541, 937, 1506)
);
