# Bike Store Database :bike: :department_store:

## INTRO

This project was carried out by Group 42 of Data Management for Data Science, consisting of:

| NAME and SURNAME | MATRICOLA | EMAIL |
| --- | --- | --- |
| Pasquale Luca Tommasino | 1912107 | tommasino.1912107@studenti.uniroma1.it | 
| Francesco Proietti | 1873188 | proietti.1873188@studenti.uniroma1.it |

The purpose of our project was to develop a database that would track sales and production of bike stores in America.

## SCRIPT

Our work is divided into 9 files:
0_FileStart.sql
> 

1_BikeStoreDB_ASS1.sql
>

2_Queries_ASS1.sql
>

3_ModifiedQuery1.sql
>

4_ModifiedQuery2.sql
>

5_ModifiedQuery3.sql
>

6_ModifiedQuery4.sql
>

7_BikeStoreDB_ASS2.sql
>

8_ForeignKey_references.sql
>

## TABLES (DATASETS)

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


## EER DIAGRAM

EER diagrams provide a visual representation of the relationships among the tables (entity) in the model. The image below represent our database.

<img width="965" alt="EER-Diagram" src="https://github.com/pltommasino/BikeStoreDB/assets/123829470/3dd91575-e802-4b88-a5e6-69b43266d9fe">


## LOGIC MODEL

Once the conceptual phase has been completed, and the EER model validated, we proceed to the second phase: **logical** design. In this phase we begin to name the tables, the fields each table should contain, and link them together.

| ENTITY | ATTRIBUTES | FOREIGN KEY |
| `Brands` | :key: Brand ID <br> Brand Name | --- |
| `Categories` | :key: Category ID <br> Category Name | --- |
| `Customers` | :key: Customer ID <br> First Name <br> Last Name <br> Phone Number <br> E-mail <br> Street <br> City <br> State <br> Zip Code | --- |
| `Order_items` | :key: (Order ID, Item ID) <br> Product ID <br> Quantity <br> List Price <br> Discount | Order ID (Ref. *Orders: Order ID*) <br> Product ID (Ref. *Products: Product ID*) |
| `Orders` | :key: Order ID <br> Customer ID <br> Order Status <br> Order Date <br> Required Date <br> Shipped Date <br> Store ID <br> Staff ID | Customer ID (Ref. *Customers: Customer ID*) <br> Staff ID (Ref. *Staffs: Staff ID*) <br> Store ID (Ref. *Stores: Store ID*) |
| `Products` | :key: Product ID <br> Product Name <br> Brand ID <br> Category ID <br> Model Year <br> List Price | Brand ID (Ref. *Brands: Brand ID*) <br> Category ID (Ref. *Categories: Category ID*) |
| `Staffs` | :key: Staff ID <br> First Name <br> Last Name <br> E-mail <br> Phone Number <br> Active <br> Store ID <br> Manager ID | Store ID (Ref. *Stores: Store ID*) |
| `Stocks` | :key: (Store_ID, Product ID) <br> Quantity | Store ID (Ref. *Stores: Store ID*) <br> Product ID (Ref. *Products: Product ID*) |
| `Stores` | :key: Store ID <br> Store Name <br> Phone Number <br> E-mail <br> Street <br> City <br> State <br> Zip Code | --- |

