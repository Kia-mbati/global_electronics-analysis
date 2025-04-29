-- Revenue by Region (Ascending)
WITH revenue AS (
  SELECT 
    s.Quantity,
    sk.State AS state,
    s.Quantity * p.`Unit Price USD` AS total_amount 
  FROM sales s
  JOIN products p ON p.ProductKey = s.ProductKey 
  JOIN stores sk ON sk.StoreKey = s.StoreKey
)
SELECT total_amount, state
FROM revenue
ORDER BY total_amount ASC;

-- Revenue by Region (Descending)
WITH revenue AS (
  SELECT 
    s.Quantity,
    sk.State AS state,
    s.Quantity * p.`Unit Price USD` AS total_amount 
  FROM sales s
  JOIN products p ON p.ProductKey = s.ProductKey 
  JOIN stores sk ON sk.StoreKey = s.StoreKey
)
SELECT total_amount, state
FROM revenue
ORDER BY total_amount DESC;

-- Product Category Performance Across Markets
SELECT 
    p.Category,
    sk.State,
    SUM(s.Quantity * p.`Unit Price USD`) AS total_revenue,
    SUM(s.Quantity) AS total_units_sold
FROM sales s
JOIN products p ON p.ProductKey = s.ProductKey
JOIN stores sk ON sk.StoreKey = s.StoreKey
GROUP BY p.Category, sk.State
ORDER BY total_revenue DESC;

-- Top Customers by Revenue
SELECT 
    c.`Name`, 
    SUM(s.Quantity) AS total_units,
    SUM(s.Quantity * p.`Unit Price USD`) AS total_revenue
FROM customers c
JOIN sales s ON c.CustomerKey = s.CustomerKey
JOIN products p ON p.ProductKey = s.ProductKey
GROUP BY c.`Name`
ORDER BY total_revenue DESC
LIMIT 10;

-- Customer Purchase Behavior by Category
SELECT 
    c.`Name`,
    p.Category,
    COUNT(*) AS purchase_count,
    SUM(s.Quantity * p.`Unit Price USD`) AS category_revenue
FROM customers c
JOIN sales s ON c.CustomerKey = s.CustomerKey
JOIN products p ON p.ProductKey = s.ProductKey
GROUP BY c.`Name`, p.Category
ORDER BY category_revenue DESC;

-- Inspecting Specific Customers
SELECT * FROM customers WHERE `Name` LIKE 'Bera%';

-- Order Date Distribution
SELECT COUNT(`Order Date`) FROM sales;

-- Monthly Units Sold - Raw Extract
SELECT SUBSTRING(`Order Date`, 6, 6) AS MONTH, `Order Date`, Quantity
FROM sales;
