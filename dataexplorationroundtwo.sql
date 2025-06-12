--  Sales Performance KPIs
-- Total Sales Revenue:

SELECT * FROM staging_sale;

SELECT *FROM  staging_customers;
SELECT * FROM staging_productfull;

SELECT COUNT(*)  FROM staging_productfull;
SELECT COUNT(*)  FROM staging_sale;

-- total revenue per category
SELECT SUM(p.`Unit Price USD`* s.Quantity) AS total_revenue_category ,SUM(s.Quantity) AS total_units , p.Category
 FROM staging_sale s
INNER JOIN staging_productfull p 
ON s.productkey = p.ProductKey
GROUP BY  p.Category
ORDER BY total_revenue_category DESC;

-- total revenue 

SELECT SUM(p.`Unit Price USD`* s.Quantity) AS total_revenue 
 FROM staging_sale s
INNER JOIN staging_productfull p 
ON s.productkey = p.ProductKey;


-- gross profit margin 
SELECT SUM((`Unit Price USD`- `Unit Cost USD`)/`Unit Price USD`*100)AS gross_profit_margin 
 FROM staging_sale s
INNER JOIN staging_productfull p 
ON s.productkey = p.ProductKey;

-- average unit price per category

SELECT AVG(`Unit Price USD`),AVG(`Unit Cost USD`),p.Category
 FROM staging_sale s
INNER JOIN staging_productfull p 
ON s.productkey = p.ProductKey
GROUP BY Category
ORDER BY AVG(`Unit Price USD`) DESC;


-- Customer Count by Region:
SELECT country,COUNT(customerkey)
FROM staging_customers
GROUP BY country 
ORDER BY COUNT(customerkey) DESC;


-- customer gender distribution count and percentage 
SELECT gender,COUNT(*) AS customer_count,(ROUND ((COUNT(*)*100.0)/ SUM(COUNT(*))OVER(),2)) AS percentage_count_gender
FROM staging_customers
GROUP BY gender;


-- avg customer age

SELECT substring(birthday,1,4)AS yr, ( CURRENT_DATE ()-substring(birthday,1,4))AS age
FROM staging_customers;

SELECT 
    CASE
        WHEN YEAR(CURRENT_DATE) - YEAR(birthday) < 18 THEN 'underage'
        WHEN YEAR(CURRENT_DATE) - YEAR(birthday) BETWEEN 18 AND 25 THEN 'youth'
        WHEN YEAR(CURRENT_DATE) - YEAR(birthday) BETWEEN 26 AND 40 THEN 'adult'
        WHEN YEAR(CURRENT_DATE) - YEAR(birthday) BETWEEN 41 AND 60 THEN 'middleaged'
        ELSE 'senior'
    END AS age_group,
    COUNT(*) AS total_customers
FROM
    staging_customers
    GROUP BY age_group
    ORDER BY total_customers DESC;

-- store demographics

SELECT*FROM staging_stores;
SELECT*FROM staging_sale;
-- Number of Stores per Country/State:
SELECT COUNT(*)AS total_stores_country,country
FROM staging_stores
GROUP BY country
ORDER BY total_stores_country DESC;

-- Average Store Size (Square Meters):
