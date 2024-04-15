#Drop database if exists
DROP DATABASE IF EXISTS BikeStoreDB;
#creating the Bike_store database
CREATE DATABASE BikeStoreDB;

#switching to the Bike_store database
USE BikeStoreDB;

#creating brands table
CREATE TABLE BikeStoreDB.Brands 
( 
Brand_ID INT NOT NULL,
Brand_name CHAR(20) UNIQUE NOT NULL
);

#creating categories table
CREATE TABLE BikeStoreDB.Categories
(
Category_ID INT NOT NULL,
Category_name CHAR(20) UNIQUE NOT NULL
);

#creating customers table
CREATE TABLE BikeStoreDB.Customers
(
Customer_ID INT NOT NULL,
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
Order_ID INT NOT NULL,
Customer_ID INT NOT NULL,
Order_status INT NOT NULL,
Order_date DATE,
Required_date DATE,
Shipped_date DATE NULL,
Store_ID INT,
Staff_ID INT
);

#creating order_items table
CREATE TABLE BikeStoreDB.Order_items
(
Order_ID INT NOT NULL,
Item_ID INT NOT NULL,
Product_ID INT NOT NULL,
Quantity INT NOT NULL,
List_price FLOAT,
Discount FLOAT
);

#creating products table
CREATE TABLE BikeStoreDB.Products
(
Product_ID INT NOT NULL,
Product_name VARCHAR(60) NOT NULL,
Brand_ID INT,
Category_ID INT,
Model_year INT,
List_price FLOAT
);

#creating staffs table
CREATE TABLE BikeStoreDB.Staffs
(
Staff_ID INT NOT NULL,
First_name CHAR(20) NOT NULL,
Last_name CHAR(20) NOT NULL,
Email VARCHAR(30),
Phone VARCHAR(20),
Activ INT,
Store_ID INT,
Manager_ID INT NULL
);

#creating stocks table
CREATE TABLE BikeStoreDB.Stocks
(
Store_ID INT NOT NULL,
Product_ID INT NOT NULL,
Quantity INT NOT NULL
);

#creating stores table
CREATE TABLE BikeStoreDB.Stores
(
Store_ID INT NOT NULL,
Store_name CHAR(20) NOT NULL,
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
IGNORE 1 ROWS
(Customer_ID, First_name, Last_name, @Phone, Email, Street, City, State, ZipCode)
SET Phone = NULLIF(@Phone, 'NULL');

#importing orders data
LOAD DATA LOCAL INFILE '/Users/pasquale/Documents/MySQL/DMDS/BikeStoreDB/data/orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
IGNORE 1 ROWS
(Order_ID, Customer_ID, Order_status, Order_date, Required_date, @Shipped_date, Store_ID, Staff_ID)
SET Shipped_date = NULLIF(@Shipped_date, 'NULL');

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
IGNORE 1 ROWS
(Staff_ID, First_name, Last_name, Email, Phone, Activ, Store_ID, @Manager_ID)
SET Manager_ID = NULLIF(@Manager_ID, 'NULL\r');

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