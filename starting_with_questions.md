Answer the following questions and provide the SQL queries used to find the answer.

    
**Question 1: Which cities and countries have the highest level of transaction revenues on the site?**


SQL Queries:
```
SELECT
	country,
	clean_city,
	RANK() OVER (
		ORDER BY SUM(totaltransactionrevenue) DESC
	) revenue_rank
FROM
	all_sessions
GROUP BY country, clean_city
```

Answer: United States/San Francisco




**Question 2: What is the average number of products ordered from visitors in each city and country?**


SQL Queries:
```
SELECT 
	a.country,
	a.clean_city,
	AVG(p.orderedquantity) as quantity 
FROM all_sessions a 
JOIN products p ON a.productsku = p.sku 
WHERE a.transactions != 0 AND p.orderedquantity != 0
GROUP BY a.country, a.clean_city
ORDER BY a.country, a.clean_city;
```


Answer:
Australia	    Sydney	    2139.0000000000000000
United States	Atlanta	    1.00000000000000000000
United States	Austin	    52.5000000000000000
United States	Chicago	    1482.3333333333333333
United States	Columbus	5.0000000000000000
United States	Houston	    845.0000000000000000
United States	Los Angeles	1370.0000000000000000
United States	Mountain View	370.0000000000000000
United States	Nashville	1886.0000000000000000
United States	New York	917.4285714285714286
United States	Palo Alto	1818.0000000000000000
United States	San Bruno	137.0000000000000000
United States	San Francisco	642.8000000000000000
United States	San Jose	1404.5000000000000000
United States	Seattle	2139.0000000000000000
United States	Sunnyvale	1947.3333333333333333
United States	United States	814.2857142857142857




**Question 3: Is there any pattern in the types (product categories) of products ordered from visitors in each city and country?**


SQL Queries:
```
SELECT 
	a.country,
	a.clean_city,
	a.v2productcategory
FROM all_sessions a 
JOIN products p ON a.productsku = p.sku
WHERE a.transactions != 0 AND p.orderedquantity != 0
GROUP BY a.country, a.clean_city, a.v2productcategory
ORDER BY a.v2productcategory
```

Answer: 
country	        clean_city	v2productcategory
United States	Austin	        Apparel
United States	Mountain View	Apparel
United States	San Jose	    Apparel
United States	United States	Apparel
United States	United States	Electronics
United States	San Francisco	Home/Accessories/Drinkware/
United States	San Francisco	Home/Accessories/Fun/
United States	United States	Home/Accessories/Pet/
United States	United States	Home/Apparel/
United States	Mountain View	Home/Apparel/Kid's/Kid's-Infant/
United States	New York	    Home/Apparel/Kid's/Kid's-Infant/
United States	United States	Home/Apparel/Kid's/Kid's-Infant/
United States	San Bruno	    Home/Apparel/Men's/
United States	New York	    Home/Apparel/Men's/Men's-Outerwear/
United States	San Francisco	Home/Apparel/Men's/Men's-Outerwear/
United States	New York	    Home/Apparel/Men's/Men's-Performance Wear/
United States	Atlanta	        Home/Apparel/Men's/Men's-T-Shirts/
United States	New York	    Home/Apparel/Men's/Men's-T-Shirts/
United States	Sunnyvale	    Home/Apparel/Men's/Men's-T-Shirts/
United States	United States	Home/Apparel/Men's/Men's-T-Shirts/
United States	Los Angeles	    Home/Apparel/Women's/
United States	Mountain View	Home/Apparel/Women's/Women's-Outerwear/
United States	San Francisco	Home/Apparel/Women's/Women's-T-Shirts/
United States	United States	Home/Apparel/Women's/Women's-T-Shirts/
United States	San Francisco	Home/Bags/
United States	United States	Home/Bags/
United States	Houston	        Home/Drinkware/
United States	United States	Home/Drinkware/
United States	San Francisco	Home/Drinkware/Water Bottles and Tumblers/
United States	Los Angeles	    Home/Nest/Nest-USA/
United States	New York	    Home/Nest/Nest-USA/
United States	Palo Alto	    Home/Nest/Nest-USA/
United States	San Francisco	Home/Nest/Nest-USA/
United States	San Jose	    Home/Nest/Nest-USA/
United States	Seattle	        Home/Nest/Nest-USA/
United States	United States	Home/Nest/Nest-USA/
United States	United States	Home/Office/Notebooks & Journals/
United States	Chicago	        Home/Office/Writing Instruments/
United States	New York	    Home/Shop by Brand/
United States	San Francisco	Home/Shop by Brand/Android/
United States	Austin	        Home/Shop by Brand/Google/
United States	United States	Home/Shop by Brand/Google/
United States	Sunnyvale	    Housewares
United States	Chicago	        Lifestyle
United States	United States	Lifestyle
United States	Columbus	    N/A
United States	New York	    N/A
United States	San Francisco	N/A
Australia	    Sydney	        Nest-USA
United States	Chicago	        Nest-USA
United States	Mountain View	Nest-USA
United States	Nashville	    Nest-USA
United States	Palo Alto	    Nest-USA
United States	San Francisco	Nest-USA
United States	Sunnyvale	    Nest-USA
United States	United States	Nest-USA
United States	Mountain View	Waze
United States	United States	Waze





**Question 4: What is the top-selling product from each city/country? Can we find any pattern worthy of noting in the products sold?**


SQL Queries:
```
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
```


Answer:
country	clean_city	name	top_selling
Australia	    Sydney	    Cam Indoor Security Camera - USA	2139
United States	Atlanta	    Men's Short Sleeve Hero Tee Heather	1
United States	Austin	    Men's 100% Cotton Short Sleeve Hero Tee Black	90
United States	Austin	    Men's 100% Cotton Short Sleeve Hero Tee Navy	15
United States	Chicago	    Learning Thermostat 3rd Gen-USA - Stainless Steel	1886
United States	Chicago	    Sunglasses	1046
United States	Chicago	    Rubber Grip Ballpoint Pen 4 Pack	1515
United States	Columbus	Men's Short Sleeve Badge Tee Charcoal	5
United States	Houston	    26 oz Double Wall Insulated Bottle	845
United States	Los Angeles	 Cam Outdoor Security Camera - USA	2719
United States	Los Angeles	 Women's Short Sleeve Hero Tee White	21
United States	Mountain View	 Learning Thermostat 3rd Gen-USA - Stainless Steel	1886
United States	Mountain View	 Men's Bike Short Sleeve Tee Charcoal	41
United States	Mountain View	 Men's Vintage Badge Tee Sage	193
United States	Mountain View	 Mobile Phone Vent Mount	68
United States	Mountain View	Android Infant Short Sleeve Tee Pewter	16
United States	Mountain View	Android Women's Fleece Hoodie	16
United States	Nashville	 Learning Thermostat 3rd Gen-USA - Stainless Steel	1886
United States	New York	 Cam Outdoor Security Camera - USA	2719
United States	New York	 Laptop and Cell Phone Stickers	1033
United States	New York	 Learning Thermostat 3rd Gen-USA - Stainless Steel	1886
United States	New York	 Men's  Zip Hoodie	178
United States	New York	 Men's 100% Cotton Short Sleeve Hero Tee White	528
United States	New York	 Men's Short Sleeve Performance Badge Tee Pewter	27
United States	New York	 Onesie Red/Graphite	51
United States	Palo Alto	 Cam Outdoor Security Camera - USA	2719
United States	Palo Alto	 Learning Thermostat 3rd Gen-USA - Stainless Steel	1886
United States	Palo Alto	 Learning Thermostat 3rd Gen-USA - White	849
United States	San Bruno	 Men's Vintage Badge Tee White	137
United States	San Francisco	 Cam Outdoor Security Camera - USA	2719
United States	San Francisco	 Protect Smoke + CO White Battery Alarm-USA	999
United States	San Francisco	 Tri-blend Hoodie Grey	59
United States	San Francisco	 Women's 3/4 Sleeve Baseball Raglan Heather/Black	19
United States	San Francisco	 Women's Scoop Neck Tee White	51
United States	San Francisco	20 oz Stainless Steel Insulated Tumbler	499
United States	San Francisco	Android 17oz Stainless Steel Sport Bottle	210
United States	San Francisco	Android Rise 14 oz Mug	306
United States	San Francisco	Waterproof Backpack	215
United States	San Francisco	Windup Android	1351
United States	San Jose	 Cam Outdoor Security Camera - USA	2719
United States	San Jose	 Men's  Zip Hoodie	90
United States	Seattle	 Cam Indoor Security Camera - USA	2139
United States	Sunnyvale	 Cam Indoor Security Camera - USA	2139
United States	Sunnyvale	Android Men's Vintage Henley	21
United States	Sunnyvale	SPF-15 Slim & Slender Lip Balm	3682
United States	United States	 Bongo Cupholder Bluetooth Speaker	85
United States	United States	 Cam Indoor Security Camera - USA	2139
United States	United States	 Dress Socks	15
United States	United States	 Infant Zip Hood Pink	18
United States	United States	 Learning Thermostat 3rd Gen-USA - Stainless Steel	3772
United States	United States	 Learning Thermostat 3rd Gen-USA - White	849
United States	United States	 Men's 100% Cotton Short Sleeve Hero Tee Black	62
United States	United States	 Men's 100% Cotton Short Sleeve Hero Tee Navy	15
United States	United States	 Men's Short Sleeve Hero Tee Charcoal	17
United States	United States	 Mood Original Window Decal	63
United States	United States	 Protect Smoke + CO White Battery Alarm-USA	999
United States	United States	 Protect Smoke + CO White Wired Alarm-USA	2488
United States	United States	 Sunglasses	1573
United States	United States	 Women's Short Sleeve Hero Tee Heather	1
United States	United States	 Zipper-front Sports Bag	162
United States	United States	22 oz  Bottle Infuser	1465
United States	United States	Android Men's Long Sleeve Badge Crew Tee Heather	44
United States	United States	Crunch Noise Dog Toy	262
United States	United States	Leatherette Journal	3071





**Question 5: Can we summarize the impact of revenue generated from each city/country?**

SQL Queries:
```
SELECT 
	a.country,
	a.clean_city,
	p.clean_restockingleadtime
FROM all_sessions a 
JOIN products p ON a.productsku = p.sku 
WHERE a.transactions != 0 AND p.orderedquantity != 0
GROUP BY a.country, a.clean_city, p.clean_restockingleadtime
ORDER BY a.country, a.clean_city;

```


Answer: N/A







