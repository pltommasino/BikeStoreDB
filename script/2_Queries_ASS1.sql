USE BikeStoreDB;

#QUERY 1
-- The 3 most expensive orders
SELECT Order_ID, ROUND(SUM((List_price * Quantity) - (List_price * Quantity * Discount)), 2) AS TotalCost
FROM Order_items
GROUP BY Order_ID
ORDER BY TotalCost DESC
LIMIT 3;
#937, 1506 and 1541



#QUERY 2
-- Customers and store that are involved in the 3 most expensive orders
SELECT C.Customer_ID, C.First_name AS Customer_FirstName, C.Last_name AS Customer_LastName, 
		C.City AS Customer_City, C.ZipCode AS Customer_ZipCode, C.State AS Customer_State, SO.Store_name,
        SO.State AS Store_State, SO.ZipCode AS Store_ZipCode
FROM Orders AS O
INNER JOIN Customers AS C
ON O.Customer_ID = C.Customer_ID
INNER JOIN Stores as SO
ON O.Store_ID = SO.Store_ID
INNER JOIN (
	SELECT Order_ID
	FROM Order_items
	GROUP BY Order_ID
	ORDER BY ROUND(SUM((List_price * Quantity) - (List_price * Quantity * Discount)), 2) DESC
	LIMIT 3
) AS T2
ON O.Order_ID = T2.Order_ID
ORDER BY O.Order_ID;
#Melanie, Abby and Pamelia - Baldwin Bikes, NY



#QUERY 3
-- Name of the 3 most featured brand in the products
SELECT B.Brand_ID, B.Brand_name, T3.Count_Brand
FROM Brands AS B
INNER JOIN(
	SELECT Brand_ID, COUNT(Brand_ID) AS Count_Brand
	FROM Products
	GROUP BY Brand_ID
	ORDER BY Count_Brand DESC
	LIMIT 3
) AS T3
ON B.Brand_ID = T3.Brand_ID
ORDER BY T3.Count_Brand DESC;



#QUERY 4
-- Number of bicycles in stock group by Store
SELECT Stores.Store_name, Stores.State, SUM(Stocks.Quantity) AS Total_Bicycles_In_Stock
FROM Stores
LEFT JOIN Stocks ON Stores.Store_ID = Stocks.Store_ID
GROUP BY Stores.Store_name, Stores.State
ORDER BY Total_Bicycles_In_Stock DESC;

  
  
  
#QUERY 5
-- Average order price
SELECT ROUND(AVG(t1.Full_order_price),2) AS Full_order_price_average
FROM (SELECT Order_ID, ROUND(SUM((List_price*Quantity) - (List_price*Quantity*Discount)),2) AS Full_order_price
      FROM Order_items
      GROUP BY Order_ID) t1;



#QUERY 6
-- Number of processing orders, grouped by state
SELECT State, COUNT(*) AS NumberOfProcessingOrders
FROM Customers c
WHERE c.Customer_ID IN (
	SELECT c2.Customer_ID
	FROM (
		SELECT Customer_ID, COUNT(*) AS numOrd
		FROM Orders JOIN Customers USING (Customer_ID)
		WHERE Order_status = 2
		GROUP BY Customer_ID) c2)
GROUP BY State
ORDER BY NumberOfProcessingOrders DESC;
