#Drop database if exists
DROP DATABASE IF EXISTS BikeStoreDB;
#creating the Bike_store database
CREATE DATABASE BikeStoreDB;

#switching to the Bike_store database
USE BikeStoreDB;

#creating brands table
CREATE TABLE BikeStoreDB.Brands 
( 
Brand_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Brand_name CHAR(20) UNIQUE
);

#creating categories table
CREATE TABLE BikeStoreDB.Categories
(
Category_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Category_name CHAR(20) UNIQUE
);

#creating customers table
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

#creating orders table
CREATE TABLE BikeStoreDB.Orders
(
Order_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Customer_ID INT,
Order_status INT,
Order_date DATE,
Required_date DATE,
Shipped_date DATE,
Store_ID INT,
Staff_ID INT
);

#creating order_items table
CREATE TABLE BikeStoreDB.Order_items
(
Order_ID INT NOT NULL,
Item_ID INT,
Product_ID INT,
Quantity INT,
List_price FLOAT,
Discount FLOAT,
PRIMARY KEY (Order_ID, Item_ID)
);

#creating products table
CREATE TABLE BikeStoreDB.Products
(
Product_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Product_name VARCHAR(60),
Brand_ID INT,
Category_ID INT,
Model_year INT,
List_price FLOAT
);

#creating staffs table
CREATE TABLE BikeStoreDB.Staffs
(
Staff_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
First_name CHAR(20),
Last_name CHAR(20),
Email VARCHAR(30),
Phone VARCHAR(20),
Activ INT,
Store_ID INT,
Manager_ID INT
);

#creating stocks table
CREATE TABLE BikeStoreDB.Stocks
(
Store_ID INT NOT NULL,
Product_ID INT,
Quantity INT,
PRIMARY KEY (Store_ID, Product_ID)
);

#creating stores table
CREATE TABLE BikeStoreDB.Stores
(
Store_ID INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
Store_name CHAR(20),
Phone VARCHAR(20),
Email VARCHAR(30),
Street VARCHAR(30),
City CHAR(20),
State CHAR(2),
ZipCode INT
);

#importing brands data
LOAD DATA LOCAL INFILE '/Users/pasquale/Documents/MySQL/DMDS/BikeStoreDB/data/brands.csv'
INTO TABLE Brands
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

#importing categories data
LOAD DATA LOCAL INFILE '/Users/pasquale/Documents/MySQL/DMDS/BikeStoreDB/data/categories.csv'
INTO TABLE Categories
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

#importing customer data
LOAD DATA LOCAL INFILE '/Users/pasquale/Documents/MySQL/DMDS/BikeStoreDB/data/customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

#importing orders data
LOAD DATA LOCAL INFILE '/Users/pasquale/Documents/MySQL/DMDS/BikeStoreDB/data/orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

#importing order_items data
LOAD DATA LOCAL INFILE '/Users/pasquale/Documents/MySQL/DMDS/BikeStoreDB/data/order_items.csv'
INTO TABLE Order_items
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

#importing products data
LOAD DATA LOCAL INFILE '/Users/pasquale/Documents/MySQL/DMDS/BikeStoreDB/data/products.csv'
INTO TABLE Products
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

#importing staffs data
LOAD DATA LOCAL INFILE '/Users/pasquale/Documents/MySQL/DMDS/BikeStoreDB/data/staffs.csv'
INTO TABLE Staffs
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

#importing stocks data
LOAD DATA LOCAL INFILE '/Users/pasquale/Documents/MySQL/DMDS/BikeStoreDB/data/stocks.csv'
INTO TABLE Stocks
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

#importing stores data
LOAD DATA LOCAL INFILE '/Users/pasquale/Documents/MySQL/DMDS/BikeStoreDB/data/stores.csv'
INTO TABLE Stores
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;