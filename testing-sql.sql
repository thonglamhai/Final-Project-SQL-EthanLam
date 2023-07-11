SELECT
	a.country,
	a.clean_city,
	AVG(p.orderedquantity) as quantity 
FROM all_sessions a 
JOIN products p ON a.productsku = p.sku
WHERE a.totaltransactionrevenue != 0
GROUP BY a.country, a.clean_city
ORDER BY a.country, a.clean_city;


SELECT *
FROM products;

SELECT 
DISTINCT
country,
productsku
FROM all_sessions 
GROUP BY country, productsku
HAVING COUNT(productsku) > 1
ORDER by productsku


SELECT *
FROM products 
WHERE sku IN (
SELECT
	productsku
FROM
	all_sessions
WHERE country = 'Israel' AND totaltransactionrevenue != 0);

SELECT
	a.country,
	a.clean_city,
	a.totaltransactionrevenue,
	a.productsku,
	p.orderedquantity
FROM
	all_sessions a 
JOIN
	products p ON a.productsku = p.sku
WHERE country = 'Albania';