# queries used for creating the Metabase dashboard

#1. Average order value by date
SELECT AVG(order_details.productid * order_details.unitprice - order_details.discount) AS order_value, orders.orderdate
FROM order_details
JOIN orders on orders.orderid = order_details.orderid
GROUP BY orders.orderdate
ORDER BY order_value DESC;

#2. Order value by country
SELECT order_details.orderid, SUM(order_details.quantity * order_details.unitprice) AS order_value, orders.orderdate, orders.shipcountry
FROM order_details
JOIN orders on orders.orderid = order_details.orderid
GROUP BY order_details.orderid, orders.orderdate, orders.shipcountry;

#3. Average Days to Ship
SELECT EXTRACT(DAY FROM AVG(shippeddate - orderdate)) 
FROM orders;

#4. Average Days to Ship per Shipping Company
SELECT shippers.companyname, EXTRACT(DAY FROM AVG(shippeddate - orderdate))
FROM orders 
JOIN shippers ON orders.shipvia = shippers.shipperid
GROUP BY shippers.companyname;

#5. Average of shipping days per shipping company
SELECT shippers.companyname, EXTRACT(DAY FROM AVG(shippeddate - orderdate))
FROM orders 
JOIN shippers ON orders.shipvia = shippers.shipperid
GROUP BY shippers.companyname;

#6. Day with the highest order value
SELECT MAX(order_details.productid * order_details.unitprice - order_details.discount), orders.orderdate
FROM order_details
JOIN orders on orders.orderid = order_details.orderid
GROUP BY orders.orderdate
ORDER BY orders.orderdate DESC
LIMIT 2;

#7. Average order value per customer
SELECT AVG(order_details.productid * order_details.unitprice - order_details.discount) AS order_value, orders.customerid
FROM order_details
JOIN orders on orders.orderid = order_details.orderid
GROUP BY orders.customerid
ORDER BY order_value DESC;

#8. Discounted products
SELECT productid, productname, discontinued
FROM products
WHERE discontinued = 1;

#9. Gross Revenue
SELECT SUM(quantity * unitprice) total_sales
FROM order_details;

#10. Maximum order value per country
SELECT MAX(order_details.productid * order_details.unitprice - order_details.discount) AS order_value, orders.shipcountry
FROM order_details
JOIN orders on orders.orderid = order_details.orderid
GROUP BY orders.shipcountry
ORDER BY order_value DESC;

#11. Orders grouped by shipping companies
SELECT shippers.companyname, COUNT(orders.orderid) 
FROM shippers JOIN orders ON orders.shipvia = shippers.shipperid 
GROUP BY shippers.companyname;

#12. Products that cost less than $20
SELECT productname, unitprice
FROM products
WHERE unitprice < 20
ORDER BY unitprice ASC;
  
#13. Sum of units in stock
SELECT sum(unitsinstock )
FROM products;

#14. The hiring age of the employees
SELECT employeeid, lastname,age(hiredate, birthdate) AS hiring_age
FROM employees;

#15. Top 10 purchased products
SELECT products.productname, SUM(order_details.quantity) AS total_units_sold
FROM orders
INNER JOIN order_details ON orders.orderID = order_details.orderid
INNER JOIN products ON order_details.productid = products.productid
GROUP BY products.productname
ORDER BY total_units_sold DESC
LIMIT 10;

#16. Top 10 Profitable Products
SELECT products.productname, SUM(order_details.unitprice * order_details.quantity * (1 - order_details.discount)) as products_revenue
FROM products 
JOIN  order_details ON products.productid = order_details.productid
GROUP BY products.productname
ORDER BY products_revenue DESC
LIMIT 10;
