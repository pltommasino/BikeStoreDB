-- IMPORTANT!
## For this file, it is important to run file '1_Initial_Database' before run each query, to create Bike Store database without
## primary keys and relation between tables with foreign key, for analyze the query. We analyze the cost of the query with
## 'query_cost' in the 'EXPLAIN format=JSON' section, having unfortunately a not too big database, and the execution time is 
## really small. 'query_cost' refers to how expensive MySQL considers this particular query in terms of the overall cost 
## of the query execution, and it is based on many factore like computer architecture, disk access and CPU cycles.


########################################################################
#         	   			     QUERY 7   			                       #
# 	    	    The 3 best-selling products details	                   #
########################################################################

## In this query we want to show the name and quantity of 3 best-selling product. We did a join among Products, Order_items
## and Categories tables. From the Products table we select the product Id, its name, category, model year and list price.
## So, from the table order_items we sum all the quantity of each product (Total_QuantitySold), grouped py product ID.
## Finally, we sort in descendingly order the column Total_QuantitySold, and we take the first three best result (Limit 3)

# UN-OPTIMIZED VERSION
SELECT P.Product_ID, P.Product_Name, C.Category_name, P.Model_year, P.List_price, SUM(O.Quantity) AS Total_QuantitySold
FROM Products AS P
INNER JOIN Order_items AS O ON P.Product_ID = O.Product_ID
INNER JOIN Categories AS C ON P.Category_ID = C.Category_ID
GROUP BY P.Product_ID, P.Product_Name, C.Category_name, P.Model_year, P.List_price
ORDER BY Total_QuantitySold DESC
LIMIT 3;

## To optimize this query, we created a subquery on the order_items table in order to work on a single, smaller table
## We summed all the quantities of products purchased, sorted in descending order and took the best three results. 
## We then, did an inner join with the Products table that allows us to return only those records that are matched in both tables,
## and only finally did the inner join with the Categories table. In the optimized version, the query tends to be more
## performant since we decided to perform the Selection operation for rows, and Projection operation for columns as soon as
## possible to then do the Join operations.

# OPTIMIZED VERSION
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


# OPTIMIZED VERSION QUERY COST
## If we run the Optimized Version in 'EXPLAIN format=JSON', we can discover that query_cost is #167.82
EXPLAIN FORMAT=json SELECT P.Product_ID, P.Product_Name, C.Category_name, P.Model_year, P.List_price, T4.Total_QuantitySold
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


## To demonstrate how to improve the query cost, let's add primary keys and relation (CONSTRAINT Foreign Key) to improve
## the interactions between the tables considered in this query.

-- ADD PRIMARY KEY
#Categories table
ALTER TABLE BikeStoreDB.Categories
ADD PRIMARY KEY AUTO_INCREMENT (Category_ID);
#Order_items table
ALTER TABLE BikeStoreDB.Order_items
ADD PRIMARY KEY (Order_ID, Item_ID);
#Products table
ALTER TABLE BikeStoreDB.Products
ADD PRIMARY KEY AUTO_INCREMENT (Product_ID);
-- CONSTRAINT FOREIGN KEY
#Constraint Order_items table
ALTER TABLE BikeStoreDB.Order_items
ADD CONSTRAINT FK_Product_ID FOREIGN KEY (Product_ID) REFERENCES BikeStoreDB.Products(Product_ID);
#Constraint Products table
ALTER TABLE BikeStoreDB.Products
ADD CONSTRAINT FK_Category_ID FOREIGN KEY (Category_ID) REFERENCES BikeStoreDB.Categories(Category_ID);


#NEW OPTIMIZED VERSION QUERY COST
## If we now, run the new Optimized Version in 'EXPLAIN format=JSON', we can discover that query_cost is #1.40 instead of #167.82.
## The cost of the query has come down significantly.
EXPLAIN FORMAT=json SELECT P.Product_ID, P.Product_Name, C.Category_name, P.Model_year, P.List_price, T4.Total_QuantitySold
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



########################################################################
#         	   			     QUERY 8   			                       #
# 	    	 The most featured category in the products	               #
########################################################################

## In this query we want to show the most featured category in the products. We did an inner join between two tables: Products
## and Categories, where we return the records that have the matched value in both tables. We count every category, grouped by
## category ID and its name, and sort in descendigly order by this column of count (CategoryCount_inProduct), in the big table.
## From this, we selected the best three result (most featured category in products).

#UN-OPTIMIZED VERSION
SELECT C.Category_ID, C.Category_name, COUNT(P.Category_ID) AS CategoryCount_inProduct
FROM Products AS P
INNER JOIN Categories AS C
WHERE P.Category_ID = C.Category_ID
GROUP BY P.Category_ID, C.Category_name
ORDER BY CategoryCount_inProduct DESC
LIMIT 3;

## To optimize this query, we created a subquery on the products table in order to work on a smaller table than in the query before.
## In the subquery we counted the number of times each category appears in the table of products, sort in descendigly order and
## selected only the best three result. From this we had only three record, and we did an inner join with Categories table.
## Finally, we returned only the columns of our interest.

#OPTIMIZED VERSION
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

#OPTIMIZED VERSION QUERY COST
## If we run the Optimized Version in 'EXPLAIN format=JSON', we can discover that query_cost is #5.19
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


## To demonstrate how to improve the query cost, let's add primary keys and relation (CONSTRAINT Foreign Key) to improve
## the interactions between the tables considered in this query.

-- ADD PRIMARY KEY
#Categories table
ALTER TABLE BikeStoreDB.Categories
ADD PRIMARY KEY AUTO_INCREMENT (Category_ID);
#Products table
ALTER TABLE BikeStoreDB.Products
ADD PRIMARY KEY AUTO_INCREMENT (Product_ID);
-- CONSTRAINT FOREIGN KEY
#Constraint Categories table
ALTER TABLE BikeStoreDB.Categories
ADD CONSTRAINT FK_Category_ID FOREIGN KEY (Category_ID) REFERENCES BikeStoreDB.Products(Category_ID);
#Constraint Products table
ALTER TABLE BikeStoreDB.Products
ADD CONSTRAINT FK_Category_ID2 FOREIGN KEY (Category_ID) REFERENCES BikeStoreDB.Categories(Category_ID);

#NEW OPTIMIZED VERSION QUERY COST
## If we now, run the new Optimized Version in 'EXPLAIN format=JSON', we can discover that query_cost is #1.05 instead of #5.19.
## The cost of the query has come down.
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



#######################################################################################################################
#         	   			                          QUERY 9                       			                          #
#   Stores with number of shipped orders in a time above the average shipping time (of all store), grouped by store   #
#######################################################################################################################

## In this query we want to show the number of not available products in the Mountain (bike) category. 
##
##
##

#UN-OPTIMIZED VERSION
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

#OPTIMIZED VERSION
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

#OPTIMIZED VERSION QUERY COST
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
			SELECT Order_date, Shipped_date, DATEDIFF(Shipped_date,Order_date) AS Shipping_time, Store_ID
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

#OPTIMIZED VERSION QUERY COST 2
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


#CREATE TABLE
CREATE TABLE SubTab(
Order_ID INT,
Order_date DATE,
Shipped_date DATE,
Shipping_time INT,
Store_ID int 
);

#INSERT DATA
INSERT INTO SubTab 
SELECT Order_ID, Order_date, Shipped_date, DATEDIFF(Shipped_date,Order_date), Store_ID
FROM Orders
WHERE Order_status = 4;

#ADD PRIMARY KEY
ALTER TABLE BikeStoreDB.SubTab
ADD PRIMARY KEY AUTO_INCREMENT (Order_ID);

#OPTIMIZED VERSION QUERY COST 3
SELECT Store_ID, NumberOfOrders, Store_name, City, State
FROM (
	SELECT Store_ID, COUNT(*) AS NumberOfOrders
    FROM SubTab o 
	JOIN Stores USING (Store_ID)
    WHERE o.shipping_time > (
		SELECT ROUND(AVG(p.Shipping_time)) AS average_shipping_time
        FROM SubTab p)
	GROUP BY Store_ID) u 
JOIN Stores USING (Store_ID)
ORDER BY NumberOfOrders DESC;



########################################################################
#         	   			     QUERY 10  			                       #
#   Number of not available products in the Mountain (bike) category   #
########################################################################

## In this query we want to show the number of not available products in the Mountain (bike) category. 
##
##
##

USE BikeStoreDB;

#UN-OPTIMIZED VERSION
SELECT Category_name, COUNT(*) AS NumberOfNotAvailableProducts
FROM Stocks s 
JOIN Products p USING(Product_ID) 
JOIN Categories USING (Category_ID)
WHERE Quantity = 0
GROUP BY Category_name
HAVING Category_name like 'Mountain%';

#OPTIMIZED VERSION
SELECT Category_name, COUNT(*) AS NumberOfNotAvailableProducts
FROM (
    SELECT c.Category_name
    FROM Stocks s
    JOIN Products p ON s.Product_ID = p.Product_ID
    JOIN Categories c ON p.Category_ID = c.Category_ID
    WHERE s.Quantity = 0
) AS NotAvailableProducts
WHERE Category_name LIKE 'Mountain%'
GROUP BY Category_name;
#OPTIMIZED VERSION QUERY COST 1
EXPLAIN FORMAT=JSON SELECT Category_name, COUNT(*) AS NumberOfNotAvailableProducts
FROM (
    SELECT c.Category_name
    FROM Stocks s
    JOIN Products p ON s.Product_ID = p.Product_ID
    JOIN Categories c ON p.Category_ID = c.Category_ID
    WHERE s.Quantity = 0
) AS NotAvailableProducts
WHERE Category_name LIKE 'Mountain%'
GROUP BY Category_name;
#420.70


-- ADD PRIMARY KEY
#Categories table
ALTER TABLE BikeStoreDB.Categories
ADD PRIMARY KEY AUTO_INCREMENT (Category_ID);
#Products table
ALTER TABLE BikeStoreDB.Products
ADD PRIMARY KEY AUTO_INCREMENT (Product_ID);
#Stocks table ####
ALTER TABLE BikeStoreDB.Stocks
ADD PRIMARY KEY (Store_ID, Product_ID);

-- CONSTRAINT
#Constraint Products table
ALTER TABLE BikeStoreDB.Products
ADD CONSTRAINT FK_Category_ID FOREIGN KEY (Category_ID) REFERENCES BikeStoreDB.Categories(Category_ID);
#Constraint Stocks table
ALTER TABLE BikeStoreDB.Stocks
ADD CONSTRAINT FK_Product_ID2 FOREIGN KEY (Product_ID) REFERENCES BikeStoreDB.Products(Product_ID);


#OPTIMIZED VERSION QUERY COST 2
EXPLAIN FORMAT=JSON SELECT Category_name, COUNT(*) AS NumberOfNotAvailableProducts
FROM (
    SELECT c.Category_name
    FROM Stocks s
    JOIN Products p ON s.Product_ID = p.Product_ID
    JOIN Categories c ON p.Category_ID = c.Category_ID
    WHERE s.Quantity = 0
) AS NotAvailableProducts
WHERE Category_name LIKE 'Mountain%'
GROUP BY Category_name;
#1.05
