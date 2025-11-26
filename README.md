# SQL Developer Mini Project

This repository contains a SQL mini project created for an assignment. It includes the database schema and a set of SQL queries from basic to advanced levels.

## Files in the Repository
- schema.sql – Contains the database tables and relationships.
- query.sql – Contains all SQL queries (Level 1 to Level 4).
- SQL Developer Assignment.docx – Assignment description.

## Database Schema
The project uses three tables:

### Customers
- CustomerID (Primary Key)
- CustomerName
- City
- JoinDate

### Products
- ProductID (Primary Key)
- ProductName
- Category
- Price

### Orders
- OrderID (Primary Key)
- CustomerID (Foreign Key referencing Customers)
- ProductID (Foreign Key referencing Products)
- Quantity
- OrderDate

## Query Levels
- Level 1: Basic SELECT and WHERE queries
- Level 2: Joins, Group By, aggregate functions
- Level 3: Revenue calculations, top customers, recent orders
- Level 4: Window functions, monthly reports, advanced analysis

## How to Run
1. Open MySQL Workbench or any MySQL-supported tool.
2. Create a new database (optional but recommended).
3. Run the schema file to create all tables and import the sample data.
4. After the tables and data are successfully created, run the query file.
5. All output for each query will be displayed in your SQL client.

## Purpose of the Assignment
This project demonstrates SQL concepts including database design, joins, aggregations, data loading, and analytical SQL queries. It serves as the complete submission for the ASBL SQL assignment.
