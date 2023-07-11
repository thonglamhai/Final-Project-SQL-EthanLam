--**Question 1: Which cities and countries have the highest level of transaction revenues on the site?**
SELECT
	country,
	clean_city,
	SUM(totaltransactionrevenue) as revenue
FROM
	all_sessions
GROUP BY country, clean_city
ORDER BY revenue DESC
LIMIT 10;

-- SELECT
-- 	city,
-- 	SUM(totaltransactionrevenue) as city_revenue
-- FROM
-- 	all_sessions
-- GROUP BY city
-- ORDER BY city_revenue DESC;	

-- SELECT
-- 	country,
-- 	city,
-- 	totaltransactionrevenue,
--  	RANK() OVER(PARTITION BY country ORDER BY totaltransactionrevenue DESC) RevenueRank
-- FROM all_sessions
-- ORDER BY country, RevenueRank;

--**Question 2: What is the average number of products ordered from visitors in each city and country
SELECT 
	a.country,
	a.clean_city,
	AVG(p.orderedquantity) as quantity 
FROM all_sessions a 
JOIN products p ON a.productsku = p.sku 
--WHERE a.transactions != 0 AND p.orderedquantity != 0
WHERE p.orderedquantity != 0
GROUP BY a.country, a.clean_city
ORDER BY a.country, a.clean_city;

	
	
--**Question 3: Is there any pattern in the types (product categories) of products ordered from visitors in each city and country?**
SELECT 
	a.country,
	a.clean_city,
	a.v2productcategory
FROM all_sessions a 
JOIN products p ON a.productsku = p.sku
--WHERE a.transactions != 0 AND p.orderedquantity != 0
WHERE p.orderedquantity != 0
GROUP BY a.country, a.clean_city, a.v2productcategory
ORDER BY a.v2productcategory


--*Question 4: What is the top-selling product from each city/country?
--Can we find any pattern worthy of noting in the products sold?**

WITH cte1 AS (
	SELECT 
		a.country,
		a.clean_city,
		p.name,
		a.v2ProductCategory AS productcategory,
 		SUM(p.orderedQuantity) AS total_quantity
 	FROM all_sessions a 
 	JOIN products p ON a.productSKU = p.SKU
 	WHERE p.orderedQuantity != 0
 	GROUP BY a.country, a.clean_city, p.name, a.v2ProductCategory
 	ORDER BY a.country, a.clean_city, p.name, a.v2ProductCategory
), 
cte2 AS (
	SELECT 
		country, 
		clean_city, 
		MAX(total_quantity) AS max_orderquantity 
 	FROM cte1  
 	GROUP BY country, clean_city
 	ORDER BY country, clean_city
)

SELECT 
	cte1.country, 
	cte1.clean_city,
	cte1.name,
	cte1.productcategory, 
    cte2.max_orderquantity
FROM cte1
JOIN cte2 ON cte1.country = cte2.country
	AND cte1.clean_city = cte2.clean_city
    AND cte1.total_quantity = cte2.max_orderquantity
ORDER BY cte1.country, cte1.clean_city;


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

SELECT *
FROM all_sessions;