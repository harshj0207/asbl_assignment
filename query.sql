-- LEVEL-1

-- Q1: select customers where City is Mumbai
SELECT * FROM customers
WHERE City = 'Mumbai';

-- Q2: products with Price > 20000
SELECT * FROM products
WHERE Price > 20000;

-- Q3: orders after Jan 1, 2024
SELECT * FROM orders
WHERE OrderDate > '2024-01-01';

-- LEVEL-2

-- Q4: count of orders per customer (includes customers with 0 orders)
SELECT c.CustomerID, c.CustomerName, COUNT(o.OrderID) AS total_orders
FROM customers c LEFT JOIN orders o 
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY total_orders DESC;

-- Q5: total quantity sold per product
SELECT p.ProductID, p.ProductName, COALESCE(SUM(o.Quantity),0) AS total_quantity_sold
FROM products p LEFT JOIN orders o 
ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY total_quantity_sold DESC;

-- Q6: customers without orders
SELECT c.* 
FROM customers c LEFT JOIN orders o 
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL;

-- Q7: total revenue (sum of quantity * product price)
SELECT COALESCE(SUM(o.Quantity * p.Price), 0) AS total_revenue
FROM orders o JOIN products p 
ON o.ProductID = p.ProductID;


-- LEVEL-3

-- Q8: revenue aggregated by product category
SELECT p.Category, COALESCE(SUM(o.Quantity * p.Price), 0) AS revenue_by_category
FROM products p LEFT JOIN orders o 
ON p.ProductID = o.ProductID
GROUP BY p.Category
ORDER BY revenue_by_category DESC;

-- Q9: top 5 customers by total spent (quantity * price)
SELECT c.CustomerID, c.CustomerName, COALESCE(SUM(o.Quantity * p.Price),0) AS total_spent
FROM customers c LEFT JOIN orders o 
ON c.CustomerID = o.CustomerID LEFT JOIN products p 
ON o.ProductID = p.ProductID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY total_spent DESC
LIMIT 5;

-- Q10: most recent order date per customer
SELECT c.CustomerID, c.CustomerName, MAX(o.OrderDate) AS most_recent_order
FROM customers c LEFT JOIN orders o 
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY most_recent_order DESC;


-- LEVEL-4

-- Q11: city with highest revenue (sum of quantity*price across customers in that city)
SELECT c.City, COALESCE(SUM(o.Quantity * p.Price),0) AS revenue_by_city
FROM customers c JOIN orders o 
ON c.CustomerID = o.CustomerID JOIN products p 
ON o.ProductID = p.ProductID
GROUP BY c.City
ORDER BY revenue_by_city DESC
LIMIT 1;

-- Q12: product with highest total quantity sold
SELECT p.ProductID, p.ProductName, COALESCE(SUM(o.Quantity),0) AS total_quantity
FROM products p LEFT JOIN orders o 
ON p.ProductID = o.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY total_quantity DESC
LIMIT 1;

-- Q13 most sold product per category using RANK()
SELECT Category, ProductID, ProductName, total_qty
FROM (
  SELECT p.Category, p.ProductID, p.ProductName,
         COALESCE(SUM(o.Quantity),0) AS total_qty,
         RANK() OVER (PARTITION BY p.Category ORDER BY COALESCE(SUM(o.Quantity),0) DESC) AS rk
  FROM products p LEFT JOIN orders o 
  ON p.ProductID = o.ProductID
  GROUP BY p.Category, p.ProductID, p.ProductName
) t
WHERE rk = 1
ORDER BY Category;

-- Q14: monthly revenue
SELECT EXTRACT(YEAR FROM OrderDate) as Year, 
EXTRACT(MONTH FROM OrderDate) as Month, 
SUM(p.Price * o.Quantity) as MonthlyRevenue
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY Year, Month
ORDER BY Year, Month;

-- Q15: customers with total_spent > average_spent
WITH customer_spend AS (
  SELECT c.CustomerID, c.CustomerName, COALESCE(SUM(o.Quantity * p.Price), 0) AS total_spent
  FROM customers c LEFT JOIN orders o 
  ON c.CustomerID = o.CustomerID LEFT JOIN products p 
  ON o.ProductID = p.ProductID
  GROUP BY c.CustomerID, c.CustomerName
)
SELECT cs.CustomerID, cs.CustomerName, cs.total_spent
FROM customer_spend cs
WHERE cs.total_spent > (SELECT AVG(total_spent) FROM customer_spend)
ORDER BY cs.total_spent DESC;
