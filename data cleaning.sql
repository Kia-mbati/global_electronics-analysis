-- Inspecting Raw Tables
SELECT * FROM sales;
SELECT * FROM exchange_rates;
SELECT * FROM products;
SELECT * FROM customers;
SELECT * FROM stores;

-- Checking for Missing Values
SELECT Quantity FROM sales WHERE Quantity IS NULL OR Quantity = '';
SELECT `Unit Price USD` FROM products WHERE `Unit Price USD` IS NULL OR `Unit Price USD` = '';

-- Summary of Data Quality Issues
SELECT 
  COUNT(*) AS total_rows,
  COUNT(*) - COUNT(`Unit Price USD`) AS null_unit_price,
  COUNT(*) - COUNT(Quantity) AS null_quantity,
  SUM(CASE WHEN `Unit Price USD` = 0 THEN 1 ELSE 0 END) AS zero_price,
  SUM(CASE WHEN Quantity = 0 THEN 1 ELSE 0 END) AS zero_quantity
FROM sales s
JOIN products p ON p.ProductKey = s.ProductKey
JOIN stores sk ON sk.StoreKey = s.StoreKey;

-- Checking for zero prices
SELECT `Unit Price USD` FROM products WHERE `Unit Price USD` = '0';

-- Check for non-numeric values in `Unit Price USD`
SELECT `Unit Price USD` FROM products WHERE CAST(`Unit Price USD` AS DECIMAL(10,2)) IS NULL;

-- Data Type Inspection
SELECT 
  DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'products' AND COLUMN_NAME = 'Unit Price USD';

-- Changing data type of Unit Price USD
ALTER TABLE products ADD COLUMN UnitPrice DECIMAL(10, 2);

-- Removing '$' sign and converting to decimal
UPDATE products
SET UnitPrice = CAST(REPLACE(`Unit Price USD`, '$', '') AS DECIMAL(10, 2));

-- Dropping old column and renaming cleaned one
ALTER TABLE products DROP COLUMN `Unit Price USD`;
ALTER TABLE products CHANGE COLUMN UnitPrice `Unit Price USD` DECIMAL(10, 2);

-- Converting Order Date to DATE format
UPDATE sales
SET `Order Date` = STR_TO_DATE(`Order Date`, '%m/%d/%Y');

ALTER TABLE sales
MODIFY COLUMN `Order Date` DATE;
