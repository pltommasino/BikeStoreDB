# **BIKE STORE DATABASES** :department_store: :bike:

## PRESENTATION

The purpose of this project was to develop a database that would track sales and production of bike stores in America. This project was carried out by Group 42 of Data Management for Data Science, consisting of:

| NAME and SURNAME | MATRICOLA | EMAIL |
| --- | --- | --- |
| Pasquale Luca Tommasino | 1912107 | tommasino.1912107@studenti.uniroma1.it | 
| Francesco Proietti | 1873188 | proietti.1873188@studenti.uniroma1.it |

## SCRIPT

For the planned delivery, the project required only the following 4 files:

`1_Initial_Database.sql`
> Create the first version of database (limite ourselves to very simple tables to create a comparison with the queries we will see later).

`2_Queries.sql`
> The SQL code of the first 6 queries (with explanation);

`3_Modified_Queris.sql`
> The SQL code of the last 4 queries (with explanation), doing a cost analysis, and creating for each, its own best version;

`4_Final_Database.sql`
> The SQL code that we have used to create the schema of our final database (create tables, primary keys and costraint foreign key)


But for proper replication of what we have done, we recommend that first running the `0_FileStart.sql` file first, and only after running the above mentioned files (in order), load the last file, `5_Load_Data.sql`. Very simply, the files have a starting number in the name, do the run of the files in ascending order.


## EER DIAGRAM

EER diagrams provide a visual representation of the relationships among the tables (entity) in the model. The image below represent our database.

<img width="965" alt="EER-Diagram" src="https://github.com/pltommasino/BikeStoreDB/assets/123829470/3dd91575-e802-4b88-a5e6-69b43266d9fe">


## LOGIC MODEL

A logical model establishes the structure of data elements and the relationships among them.

| ENTITY | ATTRIBUTES | FOREIGN KEY |
| --- | --- | --- |
| `Brands` | :key: ***Brand ID*** <br> :small_blue_diamond: Brand Name | --- |
| `Categories` | :key: ***Category ID*** <br> :small_blue_diamond: Category Name | --- |
| `Customers` | :key: ***Customer ID*** <br> :small_blue_diamond: First Name <br> :small_blue_diamond: Last Name <br> :small_blue_diamond: Phone Number <br> :small_blue_diamond: E-mail <br> :small_blue_diamond: Street <br> :small_blue_diamond: City <br> :small_blue_diamond: State <br> :small_blue_diamond: Zip Code | --- |
| `Order_items` | :key: (***Order ID***, ***Item ID***) <br> :small_blue_diamond: Product ID <br> :small_blue_diamond: Quantity <br> :small_blue_diamond: List Price <br> :small_blue_diamond: Discount | :link: Order ID (Ref. *`Orders`: Order ID*) <br> :link: Product ID (Ref. *`Products`: Product ID*) |
| `Orders` | :key: ***Order ID*** <br> :small_blue_diamond: Customer ID <br> :small_blue_diamond: Order Status <br> :small_blue_diamond: Order Date <br> :small_blue_diamond: Required Date <br> :small_blue_diamond: Shipped Date <br> :small_blue_diamond: Store ID <br> :small_blue_diamond: Staff ID | :link: Customer ID (Ref. *`Customers`: Customer ID*) <br> :link: Staff ID (Ref. *`Staffs`: Staff ID*) <br> :link: Store ID (Ref. *`Stores`: Store ID*) |
| `Products` | :key: ***Product ID*** <br> :small_blue_diamond: Product Name <br> :small_blue_diamond: Brand ID <br> :small_blue_diamond: Category ID <br> :small_blue_diamond: Model Year <br> :small_blue_diamond: List Price | :link: Brand ID (Ref. *`Brands`: Brand ID*) <br> :link: Category ID (Ref. *`Categories`: Category ID*) |
| `Staffs` | :key: ***Staff ID*** <br> :small_blue_diamond: First Name <br> :small_blue_diamond: Last Name <br> :small_blue_diamond: E-mail <br> :small_blue_diamond: Phone Number <br> :small_blue_diamond: Active <br> :small_blue_diamond: Store ID <br> :small_blue_diamond: Manager ID | :link: Store ID (Ref. *`Stores`: Store ID*) |
| `Stocks` | :key: (***Store_ID***, ***Product ID***) <br> :small_blue_diamond: Quantity | :link: Store ID (Ref. *Stores: Store ID*) <br> :link: Product ID (Ref. *`Products`: Product ID*) |
| `Stores` | :key: ***Store ID*** <br> :small_blue_diamond: Store Name <br> :small_blue_diamond: Phone Number <br> :small_blue_diamond: E-mail <br> :small_blue_diamond: Street <br> :small_blue_diamond: City <br> :small_blue_diamond: State <br> :small_blue_diamond: Zip Code | --- |


## DATA

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

