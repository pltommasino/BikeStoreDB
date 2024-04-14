USE BikeStoreDB;

#QUERY 1
-- What are the 3 most expensive orders?
SELECT Order_ID, ROUND(SUM((List_price * Quantity) - (List_price * Quantity * Discount)), 2) AS TotalCost
FROM Order_items
GROUP BY Order_ID
ORDER BY TotalCost DESC
LIMIT 3;
#1541, 937, 1506



#QUERY 2
-- What are the customers, store and staff that are involved in the 3 most expensive orders?
SELECT O.Order_ID, C.Customer_ID, C.First_name AS Customer_FirstName, C.Last_name AS Customer_LastName, 
		C.City AS Customer_City, C.ZipCode AS Customer_ZipCode, C.State AS Customer_State, SO.Store_name,
        SO.State AS Store_State, SO.ZipCode AS Store_ZipCode, SA.Staff_ID, SA.First_name AS Staff_FirstName,
        SA.Last_name AS Staff_LastName, SA.Activ
FROM Orders AS O
LEFT JOIN Customers AS C
ON O.Customer_ID = C.Customer_ID
LEFT JOIN Stores as SO
ON O.Store_ID = SO.Store_ID
LEFT JOIN Staffs AS SA
ON O.Staff_ID = SA.Staff_ID
INNER JOIN (
	SELECT Order_ID
	FROM Order_items
	GROUP BY Order_ID
	ORDER BY ROUND(SUM((List_price * Quantity) - (List_price * Quantity * Discount)), 2) DESC
	LIMIT 3
) AS T2
ON O.Order_ID = T2.Order_ID
ORDER BY O.Order_ID;



#QUERY 3
-- What is the name of the most featured brand in the products?
SELECT B.Brand_ID, B.Brand_name
FROM Brands AS B
INNER JOIN(
	SELECT Brand_ID
	FROM Products
	GROUP BY Brand_ID
	ORDER BY COUNT(Brand_ID) DESC
	LIMIT 1
) AS T3
ON B.Brand_ID = T3.Brand_ID;



#QUERY 4
-- Where do the customers live? Regroup for city
SELECT State, COUNT(State) AS Count_State
FROM Customers
GROUP BY State;
#CA, NY, TX

#Compare whether the cities of the customers are the same as the stores
SELECT *
FROM Stores;
#CA, NY, TX



#QUERY 5
-- What and how many are the 3 best-selling products?
#1
SELECT P.Product_ID, P.Product_Name, P.Model_year, P.List_price, SUM(O.Quantity) AS Total_Quantity
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
GROUP BY P.Product_ID, P.Product_Name, P.Model_year, P.List_price;
#2
SELECT P.Product_ID, P.Product_Name, P.Model_year, P.List_price, T4.Total_Quantity
FROM Products AS P
INNER JOIN (
    SELECT Product_ID, SUM(Quantity) AS Total_Quantity
    FROM Order_items
    GROUP BY Product_ID
    ORDER BY SUM(Quantity) DESC
    LIMIT 3
) AS T4
ON P.Product_ID = T4.Product_ID;



#QUERY 6
-- What is the most featured category in the products?
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

#2 #226.65 cost before #34.89 cost after
EXPLAIN FORMAT=json SELECT C.Category_ID, C.Category_name, COUNT(P.Category_ID) AS CategoryCount_inProduct
FROM Products AS P
INNER JOIN Categories AS C
WHERE P.Category_ID = C.Category_ID
GROUP BY P.Category_ID, C.Category_name
ORDER BY CategoryCount_inProduct DESC
LIMIT 3;



#QUERY 7
-- Average order price

select round(avg(p.full_order),2) as full_order_price_average
from (select Order_ID, round(sum(List_price*Quantity),2) as full_order
      from Order_items
      group by Order_ID) p;
  
  
  
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
-- Best-selling store
select Store_ID, count(*) as Orders
from Orders
group by Store_ID
order by Orders desc
