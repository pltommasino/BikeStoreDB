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

-- Take 1st query and see below

-- Info 3 order that spent the most in the shop.
SELECT * #Order_ID, Customer_ID, Store_ID, Staff_ID 
FROM Orders
WHERE Order_ID IN (1541, 937, 1506);
#Customers= 73,75,10
#Store= 2
#Staff= 7

-- Know customer info
SELECT *
FROM Customers
WHERE Customer_ID IN (73, 75, 10);

-- Know store info
SELECT *
FROM Stores
WHERE Store_ID = 2;

-- Know staff info
SELECT *
FROM Staffs
WHERE Staff_ID = 7;



#QUERY 3
-- What is the most featured brand in the products?
SELECT Brand_ID, COUNT(Brand_ID) AS BrandsCount_inProduct
FROM Products
GROUP BY Brand_ID
ORDER BY BrandsCount_inProduct DESC
LIMIT 2;
#9, 1

#What are the brand name of the most featured?
SELECT *
FROM Brands
WHERE Brand_ID IN (9, 1);



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
SELECT Product_ID, SUM(Quantity) AS TotalQuantity
FROM Order_items
GROUP BY Product_ID
ORDER BY TotalQuantity DESC
LIMIT 3;
#6, 13, 16

-- Product name of product_ID
SELECT Product_ID, Product_Name, Model_year, List_price
FROM Products
WHERE Product_ID IN (6,13,16);



#QUERY 6
-- What is the most featured category in the products?
SELECT Category_ID, COUNT(Category_ID) AS CategoryCount_inProduct
FROM Products
GROUP BY Category_ID
ORDER BY CategoryCount_inProduct DESC;
#3,6,7 e 1

#What are the category name of the most featured?
SELECT *
FROM Categories
WHERE Category_ID IN (3, 6, 7);

#QUERY 7
-- Average order price

select round(avg(p.mean_full),2) as full_price_average
from (select Order_ID, round(avg(List_price*Quantity),2) as mean_full
      from Order_items
      group by Order_ID) p;
   
#QUERY 8
-- Not availabe articles

select Store_ID, Product_name, Quantity
from Stocks s join Products p on s.Product_ID = p.Product_ID
where Quantity = 0;

#QUERY 9
-- TO DO



#QUERY 10
-- City with best customer - Se vuoi TO DO

select City, count(*) as numCust
from Customers 
group by City
order by numCust desc;

