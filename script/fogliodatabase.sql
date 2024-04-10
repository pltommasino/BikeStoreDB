SHOW DATABASES;

USE BikeStoreDB;
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
ON Tab1.Order_ID = Tab2.Order_ID
