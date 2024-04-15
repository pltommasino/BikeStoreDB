USE BikeStoreDB;

#QUERY 1
-- Average order price
select round(avg(p.full_order),2) as full_order_price_average
from (select Order_ID, round(sum(List_price*Quantity),2) as full_order
      from Order_items
      group by Order_ID) p;



#QUERY 2
-- The 3 most expensive orders
SELECT Order_ID, ROUND(SUM((List_price * Quantity) - (List_price * Quantity * Discount)), 2) AS TotalCost
FROM Order_items
GROUP BY Order_ID
ORDER BY TotalCost DESC
LIMIT 3;
#937, 1506 and 1541



#QUERY 3
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



#QUERY 4
-- Name of the most featured brand in the products
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



#QUERY 5
-- Number of bicycles in stock group by Store
SELECT Stores.Store_name, Stores.State, SUM(Stocks.Quantity) AS Total_Bicycles_In_Stock
FROM Stores
LEFT JOIN Stocks ON Stores.Store_ID = Stocks.Store_ID
GROUP BY Stores.Store_name, Stores.State
ORDER BY Total_Bicycles_In_Stock DESC;




#QUERY 6
-- The name and quantity of 3 best-selling products
#1
SELECT P.Product_ID, P.Product_Name, C.Category_name, P.Model_year, P.List_price, SUM(O.Quantity) AS Total_QuantitySold
FROM Products AS P
INNER JOIN (
    SELECT Product_ID
    FROM Order_items
    GROUP BY Product_ID
    ORDER BY SUM(Quantity) DESC
    LIMIT 3
) AS T4
ON P.Product_ID = T4.Product_ID
INNER JOIN Order_items AS O ON P.Product_ID = O.Product_ID
INNER JOIN Categories AS C ON P.Category_ID = C.Category_ID
GROUP BY P.Product_ID, P.Product_Name, P.Model_year, P.List_price, C.Category_name
ORDER BY Total_QuantitySold DESC;
#2
SELECT P.Product_ID, P.Product_Name, C.Category_name, P.Model_year, P.List_price, T4.Total_QuantitySold
FROM Products AS P
INNER JOIN (
    SELECT Product_ID, SUM(Quantity) AS Total_QuantitySold
    FROM Order_items
    GROUP BY Product_ID
    ORDER BY SUM(Quantity) DESC
    LIMIT 3
) AS T4
ON P.Product_ID = T4.Product_ID
INNER JOIN Categories AS C ON P.Category_ID = C.Category_ID;



#QUERY 7
-- The most featured category in the products
#1 #5.19 cost before #3.89 cost after
EXPLAIN FORMAT=json SELECT C.Category_ID, C.Category_name, TAB5.CategoryCount_inProduct
FROM Categories AS C
INNER JOIN (
	SELECT Category_ID, COUNT(Category_ID) AS CategoryCount_inProduct
	FROM Products
	GROUP BY Category_ID
	ORDER BY CategoryCount_inProduct DESC
	LIMIT 3
) AS TAB5
ON C.Category_ID = TAB5.Category_ID;

SELECT C.Category_ID, C.Category_name, TAB5.CategoryCount_inProduct
FROM Categories AS C
INNER JOIN (
	SELECT Category_ID, COUNT(Category_ID) AS CategoryCount_inProduct
	FROM Products
	GROUP BY Category_ID
	ORDER BY CategoryCount_inProduct DESC
	LIMIT 3
) AS TAB5
ON C.Category_ID = TAB5.Category_ID;

#2 #226.65 cost before #146.32 cost with only primary key #34.89 cost after
EXPLAIN FORMAT=json SELECT C.Category_ID, C.Category_name, COUNT(P.Category_ID) AS CategoryCount_inProduct
FROM Products AS P
INNER JOIN Categories AS C
WHERE P.Category_ID = C.Category_ID
GROUP BY P.Category_ID, C.Category_name
ORDER BY CategoryCount_inProduct DESC
LIMIT 3;
  
  
  
#QUERY 8
-- Not availabe articles
select Store_ID, Product_name, Quantity
from Stocks s join Products p on s.Product_ID = p.Product_ID
where Quantity = 0;



#QUERY 9
-- average shipping-time
select round(avg(o.shipping_time)) as average_shipping_time
from (select Order_status, Order_date, Shipped_date, datediff(Shipped_date,Order_date) as shipping_time
      from Orders
      where Order_status = 4
      ) o; 



#QUERY 10
-- Info of customers that have more than one not shipped orders
select *
from Customers c
where c.Customer_ID in (select c2.Customer_ID 
                        from (select Customer_ID, count(*) as numOrd
                              from Orders join Customers using (Customer_ID)
                              where Order_status in (1,2,3)
                              group by Customer_ID) c2
						where numOrd > 1)
order by Last_name;
