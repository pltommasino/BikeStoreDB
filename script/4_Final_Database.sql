#########################################################################
#                   CREATION OF FINAL DATABASE                          #
#########################################################################

#Drop database if exists
DROP DATABASE IF EXISTS BikeStoreDB;

#Creating the Bike Store database
CREATE DATABASE BikeStoreDB;


#Creating Brands table
CREATE TABLE BikeStoreDB.Brands 
( 
Brand_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Brand_name CHAR(20) UNIQUE NOT NULL
);

#Creating Categories table
CREATE TABLE BikeStoreDB.Categories
(
Category_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Category_name CHAR(20) UNIQUE NOT NULL
);

#Creating Customers table
CREATE TABLE BikeStoreDB.Customers
(
Customer_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
First_name CHAR(20) NOT NULL,
Last_name CHAR(20) NOT NULL,
Phone VARCHAR(20),
Email VARCHAR(40),
Street VARCHAR(30),
City CHAR(30),
State CHAR(2),
ZipCode INT
);

#Creating Orders table
CREATE TABLE BikeStoreDB.Orders
(
Order_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Customer_ID INT NOT NULL,
Order_status INT NOT NULL,
Order_date DATE,
Required_date DATE,
Shipped_date DATE NULL,
Store_ID INT,
Staff_ID INT
);

#Creating Order_items table
CREATE TABLE BikeStoreDB.Order_items
(
Order_ID INT NOT NULL,
Item_ID INT NOT NULL,
Product_ID INT NOT NULL,
Quantity INT NOT NULL,
List_price FLOAT,
Discount FLOAT,
PRIMARY KEY (Order_ID, Item_ID)
);

#Creating Products table
CREATE TABLE BikeStoreDB.Products
(
Product_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Product_name VARCHAR(60) NOT NULL,
Brand_ID INT,
Category_ID INT,
Model_year INT,
List_price FLOAT
);

#Creating Staffs table
CREATE TABLE BikeStoreDB.Staffs
(
Staff_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
First_name CHAR(20) NOT NULL,
Last_name CHAR(20) NOT NULL,
Email VARCHAR(30),
Phone VARCHAR(20),
Activ INT,
Store_ID INT,
Manager_ID INT NULL
);

#Creating Stocks table
CREATE TABLE BikeStoreDB.Stocks
(
Store_ID INT NOT NULL,
Product_ID INT NOT NULL,
Quantity INT NOT NULL,
PRIMARY KEY (Store_ID, Product_ID)
);

#Creating Stores table
CREATE TABLE BikeStoreDB.Stores
(
Store_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Store_name CHAR(20) NOT NULL,
Phone VARCHAR(20),
Email VARCHAR(30),
Street VARCHAR(30),
City CHAR(20),
State CHAR(2),
ZipCode INT
);


-- CONSTRAINT
#Constraint Categories table
ALTER TABLE BikeStoreDB.Categories
ADD CONSTRAINT FK_Category_ID FOREIGN KEY (Category_ID) REFERENCES BikeStoreDB.Products(Category_ID);

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
ADD CONSTRAINT FK_Category_ID2 FOREIGN KEY (Category_ID) REFERENCES BikeStoreDB.Categories(Category_ID);

#Constraint Staffs table
ALTER TABLE BikeStoreDB.Staffs
ADD CONSTRAINT FK_Store_ID2 FOREIGN KEY (Store_ID) REFERENCES BikeStoreDB.Stores(Store_ID);

#Constraint Stocks table
ALTER TABLE BikeStoreDB.Stocks
ADD CONSTRAINT FK_Store_ID3 FOREIGN KEY (Store_ID) REFERENCES BikeStoreDB.Stores(Store_ID),
ADD CONSTRAINT FK_Product_ID2 FOREIGN KEY (Product_ID) REFERENCES BikeStoreDB.Products(Product_ID);