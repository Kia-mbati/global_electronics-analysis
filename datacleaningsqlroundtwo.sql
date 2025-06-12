-- inspecting all tables to find all issues inorder to create an issue log 
SELECT*FROM customers;
SELECT*FROM products_full;
SELECT*FROM sales_full;
SELECT*FROM stores;
SELECT*FROM exchange_rates;


SELECT*FROM customers;

-- create a staging table 
CREATE TABLE staging_customers
LIKE customers;

-- transfer all the data from the initial table to the staging table 
INSERT INTO staging_customers
SELECT*FROM customers;


-- checking for duplicates 
SELECT customerkey ,`Name`,COUNT(*)
FROM customers 
GROUP BY customerkey ,`Name`
HAVING COUNT(*)>1;

WITH duplicates AS
(SELECT *,
 ROW_NUMBER() OVER (PARTITION BY CustomerKey,`Name`,birthday
 ORDER BY CustomerKey) 
 AS rownum
 FROM customers)
 SELECT * FROM duplicates
WHERE rownum > 1;

-- deleting the duplicates from stagingcustomers

WITH duplicates AS (SELECT *,ROW_NUMBER() OVER ( PARTITION BY CustomerKey,`Name`,birthday
ORDER BY CustomerKey)AS rownum
FROM staging_customers)
DELETE FROM staging_customers
WHERE CustomerKey IN 
(SELECT CustomerKey
 FROM duplicates
 WHERE rownum>1);
 
 
 SELECT*
 FROM staging_customers
 WHERE City IS NULL;
 
 SELECT * FROM staging_customers;
 SELECT  City ,LOWER(City)AS lower_city  FROM staging_customers;
 
 UPDATE staging_customers
 SET city = LOWER(City);
 
 SELECT *
 FROM staging_customers
 WHERE country IS NULL ;
 
 SELECT MIN(Birthday), MAX(Birthday) FROM customers;


SELECT Customerkey FROM sales_full
WHERE customerkey NOT IN (SELECT CustomerKey FROM staging_customers);

 SELECT *
FROM sales_full
WHERE CustomerKey NOT IN (SELECT CustomerKey FROM staging_customers);
-- checking all the customerkeys in sales that are not in stagingcustomers
 SELECT *
FROM sales_full
WHERE CustomerKey IN (
  SELECT CustomerKey
  FROM sales_full
  WHERE CustomerKey NOT IN (
    SELECT CustomerKey FROM staging_customers
  )
);

SELECT Gender, COUNT(*) FROM customers GROUP BY Gender;
-- 4622 female
-- 4670 male

 -- lets inspect the productsfull
 SELECT*FROM products_full;
 
 CREATE TABLE staging_productfull
 LIKE products_full;
 
 INSERT INTO staging_productfull 
 SELECT* FROM products_full;
 
SELECT * FROM staging_productfull;

UPDATE staging_productfull
SET `Unit Cost USD` = REPLACE(REPLACE(`Unit Cost USD`, '$', ''), ',', '');


ALTER TABLE staging_productfull
MODIFY COLUMN `Unit Cost USD` DECIMAL(10,2);


UPDATE staging_productfull
SET `Unit Price USD` = REPLACE(REPLACE(`Unit Price USD`, '$', ''), ',', '');
-- chaging the datatype 
ALTER TABLE staging_productfull
MODIFY COLUMN `Unit Price USD` DECIMAL(10,2);

-- inspecting for irregularities 
SELECT*
FROM staging_productfull
WHERE `Unit Cost USD` <`Unit Cost USD`;
-- inspecting for nulls 
SELECT 
    *
FROM
    products_full
WHERE
    productkey IS NULL
        OR `Product Name` IS NULL
        OR Brand IS NULL
        OR Category IS NULL
        OR Subcategory IS NULL;
        
        
  -- inspecting salesfull table       
SELECT*FROM staging_sale;
       
 CREATE TABLE staging_sale
 LIKE sales_full;
  
  INSERT INTO staging_sale
  SELECT*FROM sales_full;
  
  
SELECT COUNT(DISTINCT `Line Item`, `Order Date`, `Delivery Date`, CustomerKey, StoreKey, ProductKey, Quantity)
FROM staging_sales;



SELECT `Line Item`, `Order Date`, `Delivery Date`, CustomerKey, StoreKey, ProductKey, Quantity,
       COUNT(*) AS count
FROM staging_sales
GROUP BY `Line Item`, `Order Date`, `Delivery Date`, CustomerKey, StoreKey, ProductKey, Quantity
HAVING COUNT(*) > 1;

SELECT *FROM staging_sale
WHERE ProductKey = '1648' AND  CustomerKey = '254540' ;


SELECT *FROM staging_sale
WHERE ProductKey = '1798' AND  CustomerKey = '1039440' ;
SELECT COUNT(*) FROM staging_sale;


WITH duplicates AS (
  SELECT 
    id,
    ROW_NUMBER() OVER (
      PARTITION BY `Order Number`, CustomerKey, ProductKey, Quantity, `Currency Code`
      ORDER BY id
    ) AS rn
  FROM staging_sale
)
SELECT * FROM staging_sale
WHERE id IN (
  SELECT id FROM duplicates WHERE rn > 1
);

SHOW COLUMNS FROM staging_sale;

SELECT 
  `Order Number`, 
  CustomerKey, 
  ProductKey, 
  Quantity,
  `Currency Code`,
  COUNT(*) AS duplicate_count
FROM staging_sale
GROUP BY 
  `Order Number`, 
  CustomerKey, 
  ProductKey, 
  Quantity,
  `Currency Code`
HAVING COUNT(*) > 1;








SELECT 
  `Order Number`, 
  CustomerKey, 
  ProductKey, 
  Quantity,
  `Currency Code`,
  COUNT(*) AS duplicate_count
FROM staging_sale
GROUP BY 
 `Order Number`, 
  CustomerKey, 
  ProductKey, 
  Quantity,
  `Currency Code`
HAVING COUNT(*) > 1;






ALTER TABLE staging_sale ADD COLUMN id INT AUTO_INCREMENT PRIMARY KEY;

SELECT* FROM staging_sale;




SELECT*FROM stores;

CREATE TABLE staging_stores
LIKE stores;

INSERT INTO staging_stores
SELECT *FROM stores;


SELECT*FROM staging_stores;





ALTER TABLE staging_stores
MODIFY COLUMN `Open Date` DATE;

SELECT TRIM(`Open Date`)
FROM staging_stores;

UPDATE staging_stores 
SET `Open Date` = TRIM(`Open Date`);

-- If current format is 'DD/MM/YYYY'
UPDATE staging_stores
SET `Open Date` = DATE_FORMAT(STR_TO_DATE(`Open Date`, '%c/%e/%Y'), '%Y-%m-%d');



CREATE TABLE staging_exchangerates
LIKE exchange_rates;

INSERT INTO staging_exchangerates
SELECT*FROM exchange_rates;

SELECT TRIM(`Date`)
FROM staging_exchangerates;

UPDATE staging_exchangerates
SET `Date`= TRIM(`Date`);

SELECT * FROM staging_exchangerates;

ALTER TABLE  staging_exchangerates
MODIFY COLUMN `Date` DATE;

 UPDATE staging_exchangerates
SET `Date` = DATE_FORMAT(STR_TO_DATE(`Date`, '%c/%e/%Y'), '%Y-%m-%d');





SHOW VARIABLES WHERE Variable_name IN ('net_read_timeout', 'net_write_timeout', 'wait_timeout', 'max_allowed_packet');
SET SESSION net_read_timeout = 600;
SET SESSION net_write_timeout = 600;
SET GLOBAL max_allowed_packet = 1073741824; 
SET GLOBAL net_buffer_length = 1048576;
SELECT*FROM staging_sale;
SET GLOBAL wait_timeout = 28800;
SET GLOBAL max_allowed_packet = 1073741824;
SHOW TABLE STATUS LIKE 'staging_sale';


