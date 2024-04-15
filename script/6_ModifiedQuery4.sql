USE BikeStoreDB;

#QUERY 9
-- Stores with number of shipped orders in a time above the average shipping time (of all store), grouped by store
SELECT Store_ID, NumberOfOrders, Store_name, City, State
FROM (
	SELECT Store_ID, COUNT(*) AS NumberOfOrders
    FROM (
		SELECT Order_status, Order_date, Shipped_date, DATEDIFF(Shipped_date,Order_date) AS Shipping_time, Store_ID
		FROM Orders
		WHERE Order_status = 4) o 
	JOIN Stores USING (Store_ID)
    WHERE o.shipping_time > (
		SELECT ROUND(AVG(p.Shipping_time)) AS average_shipping_time
        FROM (
			SELECT Order_status, Order_date, Shipped_date, DATEDIFF(Shipped_date,Order_date) AS Shipping_time
			FROM Orders
			WHERE Order_status = 4) p)
	GROUP BY Store_ID) u 
JOIN Stores USING (Store_ID)
ORDER BY NumberOfOrders DESC;