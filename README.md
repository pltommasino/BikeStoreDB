# BikeStoreDB

Sample database for a retail bike store. Learning SQL and practicing querying relational databases.

Database diagram:
![inbox-4146319-c5838eb006bab3938ad94de02f58c6c1-SQL-Server-Sample-Database](https://github.com/pltommasino/BikeStoreDB/assets/123829470/8c0f4ca1-773f-45cd-8a2e-b2bd71fbe369)

## 0. Intro

This project was carried out by Group 42 of Data Management for Data Science, consisting of:

| NAME and SURNAME | MATRICOLA | EMAIL |
| --- | --- | --- |
| Pasquale Luca Tommasino | 1912107 | tommasino.1912107@studenti.uniroma1.it | 
| Francesco Proietti | 1873188 | proietti.1873188@studenti.uniroma1.it |

## 1. Data

Database is builded from the following tables:

1. Brands
> The brands table stores the brand’s information of bikes, for example, Electra, Haro, and Heller.

2. Categories
> The categories table stores the bike’s categories such as children bicycles, comfort bicycles, and electric bikes.

3. Customers
> The customers table stores customer’s information including first name, last name, phone, email, street, city, state and zip code.

4. Order_items
> The order_items table stores the line items of a sales order. Each line item belongs to a sales order specified by the order_id column. A sales order line item includes product, order quantity, list price, and discount. Order_status= 1: Pending, 2: Processing, 3: Rejected, 4: Completed

5. Orders
> The orders table stores the sales order’s header information including customer, order status, order date, required date, shipped date. It also stores the information on where the sales transaction was created (store) and who created it (staff). Each sales order has a row in the sales_orders table. A sales order has one or many line items stored in the order_items table.

6. Products
> The products table stores the product’s information such as name, brand, category, model year, and list price. Each product belongs to a brand specified by the brand_id column. Hence, a brand may have zero or many products. Each product also belongs a category specified by the category_id column. Also, each category may have zero or many products.

7. Staffs
> The staffs table stores the essential information of staffs including first name, last name. It also contains the communication information such as email and phone. A staff works at a store specified by the value in the store_id column. A store can have one or more staffs. A staff reports to a store manager specified by the value in the manager_id column. If the value in the manager_id is null, then the staff is the top manager. If a staff no longer works for any stores, the value in the active column is set to zero.

8. Stocks
> The stocks table stores the inventory information i.e. the quantity of a particular product in a specific store.

9. Stores
> The stores table includes the store’s information. Each store has a store name, contact information such as phone and email, and an address including street, city, state, and zip code.

