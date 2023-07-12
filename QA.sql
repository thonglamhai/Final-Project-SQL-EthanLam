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