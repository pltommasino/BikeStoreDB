#QUERY 7
-- The name and quantity of 3 best-selling products

#OLD QUERY
SELECT P.Product_ID, P.Product_Name, C.Category_name, P.Model_year, P.List_price, SUM(O.Quantity) AS Total_QuantitySold
FROM Products AS P
INNER JOIN Order_items AS O ON P.Product_ID = O.Product_ID
INNER JOIN Categories AS C ON P.Category_ID = C.Category_ID
GROUP BY P.Product_ID, P.Product_Name, C.Category_name, P.Model_year, P.List_price
ORDER BY Total_QuantitySold DESC
LIMIT 3;

#MODIFIED NEW QUERY
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
-- QUERY COST
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
#167.82


-- ADD PRIMARY KEY
#Categories table
ALTER TABLE BikeStoreDB.Categories
ADD PRIMARY KEY AUTO_INCREMENT (Category_ID);
#Order_items table ####
ALTER TABLE BikeStoreDB.Order_items
ADD PRIMARY KEY (Order_ID, Item_ID);
#Products table
ALTER TABLE BikeStoreDB.Products
ADD PRIMARY KEY AUTO_INCREMENT (Product_ID);

-- CONSTRAINT
#Constraint Order_items table
ALTER TABLE BikeStoreDB.Order_items
ADD CONSTRAINT FK_Product_ID FOREIGN KEY (Product_ID) REFERENCES BikeStoreDB.Products(Product_ID);
#Constraint Products table
ALTER TABLE BikeStoreDB.Products
ADD CONSTRAINT FK_Category_ID FOREIGN KEY (Category_ID) REFERENCES BikeStoreDB.Categories(Category_ID);



-- NEW QUERY COST
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
#1.40