-- Relationship between sales_report / sales_sku / products

SELECT *
FROM
	products
LEFT JOIN
	sales_report ON sku = productsku

ALTER TABLE products ADD PRIMARY KEY (sku);
ALTER TABLE sales_report ADD PRIMARY KEY (productsku);
ALTER TABLE sales_report 
    ADD CONSTRAINT fk_sku FOREIGN KEY (productsku) REFERENCES products (sku);
ALTER TABLE sales_by_sku ADD PRIMARY KEY (productsku);
ALTER TABLE sales_by_sku 
    ADD CONSTRAINT fk_sku FOREIGN KEY (productsku) REFERENCES products (sku);
    
    
SELECT count(DISTINCT sku) FROM (
	SELECT p.sku
	FROM products p 
	JOIN sales_by_sku sbs
	ON p.sku = sbs.productsku
)tmp

SELECT COUNT(productsku) FROM sales_by_sku

SELECT count(*)
FROM all_sessions 
WHERE fullvisitorid is NULL OR country IS NULL OR city is NULL OR productsku IS NULL

SELECT COUNT(*)
FROM all_sessions
WHERE totaltransactionrevenue != 

SELECT * 
from all_sessions 
where totaltransactionrevenue != (productquantity * productprice)
LIMIT 100

SELECT 
count(DISTINCT als.productsku) as total
FROM all_sessions als 
JOIN products p ON als.productsku = p.sku

SELECT count(*)
FROM products

SELECT 
count(DISTINCT als.productsku) as total
FROM all_sessions als 

SELECT DISTINCT
	productsku
FROM all_sessions als 
WHERE productsku NOT IN (
	SELECT sku
	FROM products
)

DELETE FROM all_sessions
WHERE productsku NOT IN (
	SELECT sku
	FROM products
)
