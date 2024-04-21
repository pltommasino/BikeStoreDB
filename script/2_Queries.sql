#Select the created database
USE BikeStoreDB;


########################################################################
#         	   			     QUERY 1  			                       #
#       	  	   	The 3 most expensive orders  	                   #
########################################################################

## In this query we select two columns: the order ID (Order_ID) and the total cost for each order (TotalCost).
## The total cost is calculated by summing (SUM()) all products within the order by their respective quantity (List_price * Quantity), 
## applying the discount applied to each (List_price * Quantity * Discount). The result is rounded to two decimal places
## with the ROUND(, 2) function. Grouping for each order was possible with the GROUP BY Order_ID command.
## Finally, we sorted descendingly by total cost, and took the first three results (LIMIT 3).

SELECT Order_ID, ROUND(SUM((List_price * Quantity) - (List_price * Quantity * Discount)), 2) AS TotalCost
FROM Order_items
GROUP BY Order_ID
ORDER BY TotalCost DESC
LIMIT 3;


########################################################################
#         	   			     QUERY 2  			                       #
#			   The 3 most expensive orders' details				 	   #
########################################################################

## In this query we want to show the customers info and store info that are involved in the previous query. For this reason, 
## we did a join among orders, customers and stores tables. After this we filtered the entire table that we made, 
## with the previous query. We ordered it all by Order_ID and finally we selected only the columns listed below
## for the info of the 3 most expensive orders.

SELECT O.Customer_ID, C.First_name AS Customer_FirstName, C.Last_name AS Customer_LastName, 
		C.City AS Customer_City, C.ZipCode AS Customer_ZipCode, C.State AS Customer_State, SO.Store_name,
        SO.State AS Store_State, SO.ZipCode AS Store_ZipCode
FROM Orders AS O
INNER JOIN Customers AS C
ON O.Customer_ID = C.Customer_ID
INNER JOIN Stores as SO
ON O.Store_ID = SO.Store_ID
INNER JOIN (
	SELECT Order_ID
	FROM Order_items
	GROUP BY Order_ID
	ORDER BY ROUND(SUM((List_price * Quantity) - (List_price * Quantity * Discount)), 2) DESC
	LIMIT 3
) AS T2
ON O.Order_ID = T2.Order_ID
ORDER BY O.Order_ID;
#Melanie, Abby and Pamelia - Baldwin Bikes, NY


########################################################################
#         	   			     QUERY 3  			                       #
# 	  Name of the 3 most featured (present) brand in the products 	   #
########################################################################

## In this query we want to show the 3 most present brand in the product. We did at first, in the nested query,
## a count of all brand (Count_Brand) grouped by Brand_ID in the Products table. We took the first 3 featured
## brand sorting by Count_Brand in descending order, and put Limit to 3. After we did a join from this table
## with Brands table, in this way we can know the name of brands.

SELECT B.Brand_ID, B.Brand_name, T3.Count_Brand
FROM Brands AS B
INNER JOIN(
	SELECT Brand_ID, COUNT(Brand_ID) AS Count_Brand
	FROM Products
	GROUP BY Brand_ID
	ORDER BY Count_Brand DESC
	LIMIT 3
) AS T3
ON B.Brand_ID = T3.Brand_ID
ORDER BY T3.Count_Brand DESC;


########################################################################
#         	   			     QUERY 4  			                       #
# 			  Number of bicycles in stock group by Store			   #
########################################################################

## In this query we want to show the number of bicycles in stock group by store. We create a left join
## between Stocks and Stores. For this we sum every product quantity for each store (GROUP BY Store_name, State)
## and finally, we order the column of total bikes in descendingly way.

SELECT Stores.Store_name, Stores.State, SUM(Stocks.Quantity) AS Total_Bicycles_In_Stock
FROM Stores
LEFT JOIN Stocks ON Stores.Store_ID = Stocks.Store_ID
GROUP BY Stores.Store_name, Stores.State
ORDER BY Total_Bicycles_In_Stock DESC;

  
########################################################################
#         	   			     QUERY 5  			                       #
# 						Average order price			     			   #
########################################################################

## In the fifth query we wanted to show the average order price among all the orders. In the subquery we returns a table 
## grouped by Order_ID, containing the Order_ID and the order price computed using the sum() function among all the items for 
## each order. The price of each item of each group was computed multipling the list price for the respective quantity 
## (List_price * Quantity), then we subtracted the corresponding discount (List_price * Quantity * Discount). 
## Finally in the main query we selected the average (with the avg() function) of the order prices calculated in the subquery, 
## rounded using the round(,2) function.

SELECT ROUND(AVG(t1.Full_order_price),2) AS Full_order_price_average
FROM (SELECT Order_ID, ROUND(SUM((List_price*Quantity) - (List_price*Quantity*Discount)),2) AS Full_order_price
      FROM Order_items
      GROUP BY Order_ID) t1;



########################################################################
#         	   			     QUERY 6  			                       #
# 	 	 	Number of processing orders, grouped by state			   #
########################################################################

## In this query we wanted to show the number of customers having at least one processing orders, grouped by customer's State.
## The order status is indicated in the Order_status column from the Orders table. The number that corresponds to a processing 
## order is 2. We selected the State and the number of each customers processing orders from the Customer table.
## The where statement filters the customers with the results of subquery that returns the customers from the joined table 
## between Orders and Customers having at least one processing order. Finally we grouped by State and we ordered in descending way.

SELECT State, COUNT(*) AS NumberOfProcessingOrders
FROM Customers
WHERE Customer_ID IN (
	SELECT Customer_ID
	FROM Orders JOIN Customers USING (Customer_ID)
	WHERE Order_status = 2
	GROUP BY Customer_ID)
GROUP BY State
ORDER BY NumberOfProcessingOrders DESC;