USE BikeStoreDB;

#QUERY 8
-- The most featured category in the products

#OLD QUERY
SELECT C.Category_ID, C.Category_name, COUNT(P.Category_ID) AS CategoryCount_inProduct
FROM Products AS P
INNER JOIN Categories AS C
WHERE P.Category_ID = C.Category_ID
GROUP BY P.Category_ID, C.Category_name
ORDER BY CategoryCount_inProduct DESC
LIMIT 3;

#MODIFIED NEW QUERY
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
-- QUERY COST
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
#5.19


-- ADD PRIMARY KEY
#Categories table
ALTER TABLE BikeStoreDB.Categories
ADD PRIMARY KEY AUTO_INCREMENT (Category_ID);
#Products table
ALTER TABLE BikeStoreDB.Products
ADD PRIMARY KEY AUTO_INCREMENT (Product_ID);


-- QUERY COST
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
#3.89



-- DELETE PRIMARY KEY
#Categories table
ALTER TABLE BikeStoreDB.Categories
DROP PRIMARY KEY;
#Products table
ALTER TABLE BikeStoreDB.Products
DROP PRIMARY KEY;