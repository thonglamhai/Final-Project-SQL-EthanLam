--**Question 1: Which cities and countries have the highest level of transaction revenues on the site?**
SELECT
	country,
	clean_city,
	RANK() OVER (
		ORDER BY SUM(totaltransactionrevenue) DESC
	) revenue_rank
FROM
	all_sessions
GROUP BY country, clean_city


--**Question 2: What is the average number of products ordered from visitors in each city and country
SELECT 
	a.country,
	a.clean_city,
	AVG(p.orderedquantity) as quantity 
FROM all_sessions a 
JOIN products p ON a.productsku = p.sku 
WHERE a.transactions != 0 AND p.orderedquantity != 0
--WHERE p.orderedquantity != 0
GROUP BY a.country, a.clean_city
ORDER BY a.country, a.clean_city;

	
	
--**Question 3: Is there any pattern in the types (product categories) of products ordered from visitors in each city and country?**
SELECT 
	a.country,
	a.clean_city,
	a.v2productcategory
FROM all_sessions a 
JOIN products p ON a.productsku = p.sku
WHERE a.transactions != 0 AND p.orderedquantity != 0
--WHERE p.orderedquantity != 0
GROUP BY a.country, a.clean_city, a.v2productcategory
ORDER BY a.v2productcategory


--*Question 4: What is the top-selling product from each city/country?
--Can we find any pattern worthy of noting in the products sold?**


WITH cte1 AS (
	SELECT 
		a.country,
		a.clean_city,
		p.name,
 		SUM(p.orderedQuantity) AS total_quantity
 	FROM all_sessions a 
 	JOIN products p ON a.productSKU = p.SKU
 	WHERE a.transactions !=0 AND p.orderedQuantity != 0
 	GROUP BY a.country, a.clean_city, p.name
 	ORDER BY total_quantity DESC
)
SELECT 
	country, 
	clean_city, 
	name,
	MAX(total_quantity) AS top_selling
FROM cte1 c
GROUP BY country, clean_city, name


-- **Question 5: Can we summarize the impact of revenue generated from each city/country?**
SELECT 
	a.country,
	a.clean_city,
	p.clean_restockingleadtime
FROM all_sessions a 
JOIN products p ON a.productsku = p.sku 
WHERE a.transactions != 0 AND p.orderedquantity != 0
GROUP BY a.country, a.clean_city, p.clean_restockingleadtime
ORDER BY a.country, a.clean_city;
