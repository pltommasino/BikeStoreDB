USE BikeStoreDB;

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