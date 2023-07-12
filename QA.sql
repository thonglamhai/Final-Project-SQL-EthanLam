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
    
    
    
SELECT *
FROM sales_by_sku sbs 
JOIN all_sessions a ON sbs.productsku = a.productsku 
WHERE sbs.productsku = 'GGOEYAXR066128';

SELECT *
FROM sales_by_sku sbs 
JOIN sales_report sr ON sbs.productsku = sr.productsku 
WHERE sbs.productsku = 'GGOEYAXR066128';