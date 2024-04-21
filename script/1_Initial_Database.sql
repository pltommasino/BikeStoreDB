#########################################################################
#                 CREATION OF INITIAL DATABASE                          #
#########################################################################

#Drop database if exists (useful for the file '3_Modified_Queries.sql')
DROP DATABASE IF EXISTS BikeStoreDB;

#Creating the Bike Store database
CREATE DATABASE BikeStoreDB;

#Creating Brands table
CREATE TABLE BikeStoreDB.Brands 
( 
Brand_ID INT NOT NULL,
Brand_name CHAR(20) UNIQUE NOT NULL
);

#Creating Categories table
CREATE TABLE BikeStoreDB.Categories
(
Category_ID INT NOT NULL,
Category_name CHAR(20) UNIQUE NOT NULL
);

#Creating Customers table
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

#Creating Orders table
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

#Creating Order_items table
CREATE TABLE BikeStoreDB.Order_items
(
Order_ID INT NOT NULL,
Item_ID INT NOT NULL,
Product_ID INT NOT NULL,
Quantity INT NOT NULL,
List_price FLOAT,
Discount FLOAT
);

#Creating Products table
CREATE TABLE BikeStoreDB.Products
(
Product_ID INT NOT NULL,
Product_name VARCHAR(60) NOT NULL,
Brand_ID INT,
Category_ID INT,
Model_year INT,
List_price FLOAT
);

#Creating Staffs table
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

#Creating Stocks table
CREATE TABLE BikeStoreDB.Stocks
(
Store_ID INT NOT NULL,
Product_ID INT NOT NULL,
Quantity INT NOT NULL
);

#Creating Stores table
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