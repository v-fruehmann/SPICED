\c northwind

DROP TABLE IF EXISTS regions;
CREATE TABLE regions(
    regionID SERIAL PRIMARY KEY,
    regionDescription VARCHAR(255)
    );
COPY regions 
FROM '/Users/Varvara/spiced_projects/cascabel-curve-student-code/week_05/data/regions.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS categories;
CREATE TABLE categories (
    categoryID SERIAL PRIMARY KEY,
    categoryName VARCHAR(255),
    description VARCHAR(255),
    picture bytea
    );
COPY categories 
FROM '/Users/Varvara/spiced_projects/cascabel-curve-student-code/week_05/data/categories.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    id varchar(255) UNIQUE NOT NULL PRIMARY KEY,
    companyName VARCHAR(255),
    contactName VARCHAR(255),
    contactTitle VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(255),
    region VARCHAR(255),
    postalCode VARCHAR(255),
    country VARCHAR(255),
    phone VARCHAR(255),
    fax VARCHAR(255)
    );
COPY customers (
    customerID,
    companyName,
    contactName,
    contactTitle, 
    address, 
    city,
    region, 
    postalCode, 
    country,
    phone,
    fax) 
FROM '/Users/Varvara/spiced_projects/cascabel-curve-student-code/week_05/data/customers.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS employee_territories;
CREATE TABLE employee_territories (
    employeeID INT,
    territoryID VARCHAR(255) UNIQUE NOT NULL
);
COPY employee_territories (
    employeeID, 
    territoryID) 
FROM '/Users/Varvara/spiced_projects/cascabel-curve-student-code/week_05/data/employee_territories.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    employeeID SERIAL PRIMARY KEY,
    lastName VARCHAR(255),
    firstName VARCHAR(255),
    title VARCHAR(255),
    titleOfCourtesy VARCHAR(10),
    birthDate TIMESTAMP,
    hireDate TIMESTAMP,
    address VARCHAR(255),
    city VARCHAR(255),
    region VARCHAR(255),
    postalCode VARCHAR(255),
    country VARCHAR(255),
    homePhone VARCHAR(255),
    extension VARCHAR(255),
    photo bytea,
    notes TEXT,
    reportsTO VARCHAR(255),
    photoPath TEXT
);
COPY employees 
FROM '/Users/Varvara/spiced_projects/cascabel-curve-student-code/week_05/data/employees.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS products;
CREATE TABLE products (
    productID SERIAL PRIMARY KEY,
    productName VARCHAR(255),
    supplierID INT,
    categoryID INT,
    quantityPerUnit VARCHAR(255),
    unitPrice REAL,
    unitsInStock INT,
    unitsOnOrder INT,
    reorderLevel INT,
    discontinued INT);

COPY products 
FROM '/Users/Varvara/spiced_projects/cascabel-curve-student-code/week_05/data/products.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS order_details;
CREATE TABLE order_details (
    id SERIAL PRIMARY KEY,
    orderID INT,
    productID INT,
    unitPrice REAL,
    quantity INT,
    discount REAL
);

COPY order_details (
    orderID,
    productID,
    unitPrice,
    quantity,
    discount) 
FROM '/Users/Varvara/spiced_projects/cascabel-curve-student-code/week_05/data/order_details.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
    orderID INT PRIMARY KEY,
    customerID varchar(255),
    employeeID INT,
    orderDate TIMESTAMP,
    requiredDate TIMESTAMP,
    shippedDate TIMESTAMP,
    shipVia INT,
    freight REAL,
    shipName VARCHAR(255),
    shipAddress VARCHAR(255),
    shipCity VARCHAR(255),
    shipRegion VARCHAR(255),
    shipPostalCode VARCHAR(255),
    shipCountry VARCHAR(255)
);
COPY orders 
FROM '/Users/Varvara/spiced_projects/cascabel-curve-student-code/week_05/data/orders.csv' DELIMITER ',' NULL AS 'NULL' CSV HEADER;

DROP TABLE IF EXISTS shippers;
CREATE TABLE shippers (
    shipperID SERIAL PRIMARY KEY,
    companyName VARCHAR(255),
    phone VARCHAR(255)
);
COPY shippers 
FROM '/Users/Varvara/spiced_projects/cascabel-curve-student-code/week_05/data/shippers.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS suppliers;
CREATE TABLE suppliers (
    supplierID SERIAL PRIMARY KEY,
    companyName VARCHAR(255),
    contactName VARCHAR(255),
    contactTitle VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(255),
    region VARCHAR(255),
    postalCode VARCHAR(255),
    country VARCHAR(255),
    phone VARCHAR(255),
    fax VARCHAR(255),
    homePage VARCHAR(255)
    );
COPY suppliers 
FROM '/Users/Varvara/spiced_projects/cascabel-curve-student-code/week_05/data/suppliers.csv' DELIMITER ',' CSV HEADER;

DROP TABLE IF EXISTS territories;
CREATE TABLE territories (
    territoryID VARCHAR(255) UNIQUE NOT NULL,
    territoryDescription VARCHAR(255),
    regionID INT
    );
COPY territories 
FROM '/Users/Varvara/spiced_projects/cascabel-curve-student-code/week_05/data/territories.csv' DELIMITER ',' CSV HEADER;

