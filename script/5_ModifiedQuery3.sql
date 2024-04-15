USE BikeStoreDB;

#QUERY 1
-- Average order price
SELECT ROUND(AVG(t1.Full_order_price),2) AS Full_order_price_average
FROM (SELECT Order_ID, ROUND(SUM((List_price*Quantity) - (List_price*Quantity*Discount)),2) AS Full_order_price
      FROM Order_items
      GROUP BY Order_ID) t1;