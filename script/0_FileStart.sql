SHOW DATABASES;

SET GLOBAL local_infile=1;

SET @@global.sql_mode='';

USE BikeStoreDB;

SHOW GLOBAL VARIABLES LIKE 'sql_mode';






-- The first 3 person who spent the most in the shop
SELECT * #Order_ID, Customer_ID, Store_ID, Staff_ID 
FROM Orders AS Tab1
INNER JOIN (
	SELECT Order_ID
	FROM Order_items
	GROUP BY Order_ID
	ORDER BY ROUND(SUM((List_price * Quantity) - (List_price * Quantity * Discount)), 2) DESC
	LIMIT 3
) AS Tab2
ON Tab1.Order_ID = Tab2.Order_ID;


-- Info 3 order that spent the most in the shop.
SELECT * #Order_ID, Customer_ID, Store_ID, Staff_ID 
FROM Orders
WHERE Order_ID IN (1541, 937, 1506);

-- Know customer info
SELECT *
FROM Customers
WHERE Customer_ID IN (73, 75, 10);
