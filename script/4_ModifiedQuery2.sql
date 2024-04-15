USE BikeStoreDB;

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