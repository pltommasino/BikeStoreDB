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


