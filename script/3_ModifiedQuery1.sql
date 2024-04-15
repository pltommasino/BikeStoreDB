USE BikeStoreDB;

#QUERY 6
-- The name and quantity of 3 best-selling products

#OLD QUERY
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
INNER JOIN Categories AS C ON P.Category_ID = C.Category_ID
GROUP BY P.Product_ID, P.Product_Name, P.Model_year, P.List_price, C.Category_name
ORDER BY Total_QuantitySold DESC;
-- QUERY COST
EXPLAIN FORMAT=json SELECT P.Product_ID, P.Product_Name, C.Category_name, P.Model_year, P.List_price, SUM(O.Quantity) AS Total_QuantitySold
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


######################### SELEZIONA SOLO QUELLO CHE SERVE #######################
-- ADD PRIMARY KEY
#Brands table
ALTER TABLE BikeStoreDB.Brands
ADD PRIMARY KEY AUTO_INCREMENT (Brand_ID);
#Categories table
ALTER TABLE BikeStoreDB.Categories
ADD PRIMARY KEY AUTO_INCREMENT (Category_ID);
#Customers table
ALTER TABLE BikeStoreDB.Customers
ADD PRIMARY KEY AUTO_INCREMENT (Customer_ID);
#Order_items table ####
ALTER TABLE BikeStoreDB.Order_items
ADD PRIMARY KEY (Order_ID, Item_ID);
#Orders table
ALTER TABLE BikeStoreDB.Orders
ADD PRIMARY KEY AUTO_INCREMENT (Order_ID);
#Products table
ALTER TABLE BikeStoreDB.Products
ADD PRIMARY KEY AUTO_INCREMENT (Product_ID);
#Staffs table
ALTER TABLE BikeStoreDB.Staffs
ADD PRIMARY KEY AUTO_INCREMENT (Staff_ID);
#Stocks table ####
ALTER TABLE BikeStoreDB.Stocks
ADD PRIMARY KEY (Store_ID, Product_ID);
#Stores table
ALTER TABLE BikeStoreDB.Stores
ADD PRIMARY KEY AUTO_INCREMENT (Store_ID);
-- CONSTRAINT
#Constraint Orders table
ALTER TABLE BikeStoreDB.Orders
ADD CONSTRAINT FK_Customer_ID FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID),
ADD CONSTRAINT FK_Store_ID FOREIGN KEY (Store_ID) REFERENCES BikeStoreDB.Stores(Store_ID),
ADD CONSTRAINT FK_Staff_ID FOREIGN KEY (Staff_ID) REFERENCES BikeStoreDB.Staffs(Staff_ID);
#Constraint Order_items table
ALTER TABLE BikeStoreDB.Order_items
ADD CONSTRAINT FK_Order_ID FOREIGN KEY (Order_ID) REFERENCES BikeStoreDB.Orders(Order_ID),
ADD CONSTRAINT FK_Product_ID FOREIGN KEY (Product_ID) REFERENCES BikeStoreDB.Products(Product_ID);
#Constraint Products table
ALTER TABLE BikeStoreDB.Products
ADD CONSTRAINT FK_Brand_ID FOREIGN KEY (Brand_ID) REFERENCES BikeStoreDB.Brands(Brand_ID),
ADD CONSTRAINT FK_Category_ID FOREIGN KEY (Category_ID) REFERENCES BikeStoreDB.Categories(Category_ID);
#Constraint Staffs table
ALTER TABLE BikeStoreDB.Staffs
ADD CONSTRAINT FK_Store_ID2 FOREIGN KEY (Store_ID) REFERENCES BikeStoreDB.Stores(Store_ID);
#Constraint Stocks table
ALTER TABLE BikeStoreDB.Stocks
ADD CONSTRAINT FK_Store_ID3 FOREIGN KEY (Store_ID) REFERENCES BikeStoreDB.Stores(Store_ID),
ADD CONSTRAINT FK_Product_ID2 FOREIGN KEY (Product_ID) REFERENCES BikeStoreDB.Products(Product_ID);


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




######################### ELIMINA TUTTO QUELLO CHE SERVE #######################
-- DROP PRIMARY KEY
#Brands table
ALTER TABLE BikeStoreDB.Brands
DROP PRIMARY KEY;