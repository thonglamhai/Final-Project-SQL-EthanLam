What are your risk areas? Identify and describe them.

The risk areas are defined in the duplicated values in the tables
The total transaction revenue is not matched with the ordered and unit price values
There are some NULL values in the tables

QA Process:
Describe your QA process and include the SQL queries used to execute it.

Looking for
complete (i.e. no blank or null values)
```
SELECT count(*)
FROM all_sessions 
WHERE fullvisitorid is NULL OR country IS NULL OR city is NULL OR productsku IS NULL
```
unique (i.e. no duplicate values)
```
SELECT count(DISTINCT sku) FROM (
	SELECT p.sku
	FROM products p 
	JOIN sales_by_sku sbs
	ON p.sku = sbs.productsku
)tmp

SELECT COUNT(productsku) FROM sales_by_sku
```
consistent with what we expect (eg. a decimal between a certain range)
```
SELECT * 
from all_sessions 
where totaltransactionrevenue != (productquantity * productprice)
```
