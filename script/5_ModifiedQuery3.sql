USE BikeStoreDB;

#QUERY 9
-- Number of not available products in the Mountain (bike) category

#OLD QUERY
SELECT Category_name, COUNT(*) AS NumberOfNotAvailableProducts
FROM Stocks s 
JOIN Products p USING(Product_ID) 
JOIN Categories USING (Category_ID)
WHERE Quantity = 0
GROUP BY Category_name
HAVING Category_name like 'Mountain%';

#MODIFIED NEW QUERY
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
-- QUERY COST
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



-- NEW QUERY COST
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