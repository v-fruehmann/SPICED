1. Get the names and the quantities in stock for each product.
SELECT productName AS product_name, unitsInStock AS units_in_stock
FROM products;

2. Get a list of current products (Product ID and name).
SELECT productID AS product_id, productName AS product_name
FROM products
WHERE discontinued = 0;

3. Get a list of the most and least expensive products (name and unit price).
SELECT unitPrice AS unit_price, productName AS product_name 
FROM products
WHERE unitprice > 100 OR unitprice < 5
ORDER BY unitprice DESC;
----
SELECT unitPrice AS unit_price, productName AS product_name 
FROM products 
ORDER BY unitprice DESC 
LIMIT 3;
----
SELECT unitPrice AS unit_price, productName AS product_name 
FROM products 
ORDER BY unitprice 
LIMIT 3;

4. Get products that cost less than $20.
SELECT productName AS product_name, unitPrice AS unit_price
FROM products 
WHERE unitprice < 20;

5. Get products that cost between $15 and $25.
SELECT productName AS product_name, unitPrice AS unit_price
FROM products 
WHERE unitprice BETWEEN 15 AND 25;

6. Get products above average price.
SELECT productName AS product_name, unitPrice AS unit_price
FROM products 
WHERE (unitprice) > (SELECT avg(unitprice) FROM products) 
ORDER BY unitprice DESC;

7. Find the ten most expensive products.
SELECT productName AS product_name, unitPrice AS unit_price
FROM products 
ORDER BY unitprice DESC 
LIMIT 10;

8. Get a list of discontinued products (Product ID and name).
SELECT productID AS product_id, productName AS product_name 
FROM products 
WHERE discontinued = 1;

9. Count current and discontinued products.
SELECT discontinued, COUNT(*)
FROM products
GROUP BY discontinued;
----
SELECT COUNT(discontinued) 
FROM products 
WHERE discontinued = 1;

SELECT COUNT(discontinued) 
FROM products 
WHERE discontinued = 0;

10. Find products with less units in stock than the quantity on order.
SELECT unitsInStock AS units_in_stock, unitsOnOrder AS units_in_order
FROM products
WHERE unitsinstock < unitsonorder;

11. Find the customer who had the highest order amount
SELECT customerID AS customer_id, COUNT(*)
FROM orders
GROUP BY customerid
LIMIT 1;
----
SELECT MAX(quantity), customerid 
FROM order_details, orders 
GROUP BY customerid
LIMIT 1;

12. Get orders for a given employee and the according customer
SELECT lastname, orderid 
FROM employees, orders 
ORDER BY lastname;

13. Find the hiring age of each employee
SELECT employeeid, lastname,age(hiredate, birthdate) AS hiring_age
FROM employees;

14. Create views and/or named queries for some of these queries
CREATE VIEW hiring_age AS (
SELECT employeeid, age(hiredate, birthdate) AS hiring_age
FROM employees);


