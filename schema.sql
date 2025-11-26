-- Creating Database
CREATE DATABASE shop;
USE shop;

-- Creating Tables and filling it using table data import wizard

-- customer table
CREATE TABLE IF NOT EXISTS customers (
  CustomerID INT PRIMARY KEY,
  CustomerName VARCHAR(255),
  City VARCHAR(255),
  JoinDate DATE
) ;

-- products table
CREATE TABLE IF NOT EXISTS products (
  ProductID INT PRIMARY KEY,
  ProductName VARCHAR(255),
  Category VARCHAR(100),
  Price INT
);

-- orders table
CREATE TABLE IF NOT EXISTS orders (
  OrderID INT PRIMARY KEY,
  CustomerID INT,
  ProductID INT,
  Quantity INT,
  OrderDate DATE,
  FOREIGN KEY (CustomerID) REFERENCES customers(CustomerID),
  FOREIGN KEY (ProductID) REFERENCES products(ProductID)
);

-- marketing_dataset table
CREATE TABLE IF NOT EXISTS marketing_dataset (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  Date DATE,
  Adset VARCHAR(255),
  URL VARCHAR(500),
  Platform VARCHAR(100),
  Spend DECIMAL(10,2),
  Visitors INT,
  Leads INT,
  SiteVisits INT,
  Closure INT,
  Project VARCHAR(255)
);


