USE BikeStoreDB;

#QUERY 10
-- Stores with number of shipped orders in a time above the average shipping time (of all store), grouped by store

#OLD QUERY
SELECT s.Store_ID, COUNT(*) AS NumberOfOrders, s.Store_name, s.City, s.State
FROM Orders o
JOIN Stores s ON o.Store_ID = s.Store_ID
WHERE o.Order_status = 4
AND DATEDIFF(o.Shipped_date, o.Order_date) > (
    SELECT ROUND(AVG(DATEDIFF(p.Shipped_date, p.Order_date)))
    FROM Orders p
    WHERE p.Order_status = 4
)
GROUP BY s.Store_ID, s.Store_name, s.City, s.State
ORDER BY NumberOfOrders DESC;

#MODIFIED NEW QUERY
SELECT Store_ID, NumberOfOrders, Store_name, City, State
FROM (
	SELECT Store_ID, COUNT(*) AS NumberOfOrders
    FROM (
		SELECT Order_date, Shipped_date, DATEDIFF(Shipped_date,Order_date) AS Shipping_time, Store_ID
		FROM Orders
		WHERE Order_status = 4) o 
	JOIN Stores USING (Store_ID)
    WHERE o.shipping_time > (
		SELECT ROUND(AVG(p.Shipping_time)) AS average_shipping_time
        FROM (
			SELECT Order_date, Shipped_date, DATEDIFF(Shipped_date,Order_date) AS Shipping_time
			FROM Orders
			WHERE Order_status = 4) p)
	GROUP BY Store_ID) u 
JOIN Stores USING (Store_ID)
ORDER BY NumberOfOrders DESC;
-- QUERY COST
EXPLAIN FORMAT=JSON SELECT Store_ID, NumberOfOrders, Store_name, City, State
FROM (
	SELECT Store_ID, COUNT(*) AS NumberOfOrders
    FROM (
		SELECT Order_date, Shipped_date, DATEDIFF(Shipped_date,Order_date) AS Shipping_time, Store_ID
		FROM Orders
		WHERE Order_status = 4) o 
	JOIN Stores USING (Store_ID)
    WHERE o.shipping_time > (
		SELECT ROUND(AVG(p.Shipping_time)) AS average_shipping_time
        FROM (
			SELECT Order_date, Shipped_date, DATEDIFF(Shipped_date,Order_date) AS Shipping_time
			FROM Orders
			WHERE Order_status = 4) p)
	GROUP BY Store_ID) u 
JOIN Stores USING (Store_ID)
ORDER BY NumberOfOrders DESC;
#19.99


-- ADD PRIMARY KEY
#Orders table
ALTER TABLE BikeStoreDB.Orders
ADD PRIMARY KEY AUTO_INCREMENT (Order_ID);
#Stores table
ALTER TABLE BikeStoreDB.Stores
ADD PRIMARY KEY AUTO_INCREMENT (Store_ID);

-- CONSTRAINT
#Constraint Orders table
ALTER TABLE BikeStoreDB.Orders
ADD CONSTRAINT FK_Store_ID FOREIGN KEY (Store_ID) REFERENCES BikeStoreDB.Stores(Store_ID);



-- NEW QUERY COST
EXPLAIN FORMAT=JSON SELECT Store_ID, NumberOfOrders, Store_name, City, State
FROM (
	SELECT Store_ID, COUNT(*) AS NumberOfOrders
    FROM (
		SELECT Order_date, Shipped_date, DATEDIFF(Shipped_date,Order_date) AS Shipping_time, Store_ID
		FROM Orders
		WHERE Order_status = 4) o 
	JOIN Stores USING (Store_ID)
    WHERE o.shipping_time > (
		SELECT ROUND(AVG(p.Shipping_time)) AS average_shipping_time
        FROM (
			SELECT Order_date, Shipped_date, DATEDIFF(Shipped_date,Order_date) AS Shipping_time
			FROM Orders
			WHERE Order_status = 4) p)
	GROUP BY Store_ID) u 
JOIN Stores USING (Store_ID)
ORDER BY NumberOfOrders DESC;
#5.42