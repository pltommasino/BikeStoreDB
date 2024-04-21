#Importing Brands data
LOAD DATA LOCAL INFILE '/home/francesco/bike_store_files/brands.csv'
INTO TABLE Brands
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

#Importing Categories data
LOAD DATA LOCAL INFILE '/home/francesco/bike_store_files/categories.csv'
INTO TABLE Categories
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

#Importing Customer data
LOAD DATA LOCAL INFILE '/home/francesco/bike_store_files/customers.csv'
INTO TABLE Customers
FIELDS TERMINATED BY ','
IGNORE 1 ROWS
(Customer_ID, First_name, Last_name, @Phone, Email, Street, City, State, ZipCode)
SET Phone = NULLIF(@Phone, 'NULL');

#Importing Orders data
LOAD DATA LOCAL INFILE '/home/francesco/bike_store_files/orders.csv'
INTO TABLE Orders
FIELDS TERMINATED BY ','
IGNORE 1 ROWS
(Order_ID, Customer_ID, Order_status, Order_date, Required_date, @Shipped_date, Store_ID, Staff_ID)
SET Shipped_date = NULLIF(@Shipped_date, 'NULL');

#Importing Order_items data
LOAD DATA LOCAL INFILE '/home/francesco/bike_store_files/order_items.csv'
INTO TABLE Order_items
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

#Importing Products data
LOAD DATA LOCAL INFILE '/home/francesco/bike_store_files/products.csv'
INTO TABLE Products
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

#Importing Staffs data
LOAD DATA LOCAL INFILE '/home/francesco/bike_store_files/staffs.csv'
INTO TABLE Staffs
FIELDS TERMINATED BY ','
IGNORE 1 ROWS
(Staff_ID, First_name, Last_name, Email, Phone, Activ, Store_ID, @Manager_ID)
SET Manager_ID = NULLIF(@Manager_ID, 'NULL\r');

#Importing Stocks data
LOAD DATA LOCAL INFILE '/home/francesco/bike_store_files/stocks.csv'
INTO TABLE Stocks
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

#Importing Stores data
LOAD DATA LOCAL INFILE '/home/francesco/bike_store_files/stores.csv'
INTO TABLE Stores
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;