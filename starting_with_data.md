#### Question 1: Is it able to find all duplicate records in the tables `all_sessions`, `analytics`, `products`, `sales_report`, and `sales_by_sku`?

SQL Queries: 

`all_sessions`
```
SELECT 
	fullvisitorID,
	visitid,
	productsku,
	date,
	time,
	COUNT(*)
FROM 
	all_sessions
GROUP BY
	fullvisitorID,
	visitid,
	productsku,
	date,
	time
HAVING
	COUNT(*) > 1;
```

`analytics`
```
SELECT
	fullvisitorid,
	visitid,
	visitstarttime,
	date,
	COUNT(*)
FROM
	analytics
GROUP BY
	fullvisitorid,
	visitid,
	visitstarttime,
	date
HAVING
	COUNT(*) > 1
```

`products`
```
SELECT
	sku,
	COUNT(*)
FROM
	products
GROUP BY
	sku
HAVING
	COUNT(*) > 1
```
`sales_by_sku`
```
SELECT
	productsku,
	COUNT(*)
FROM
	sales_by_sku
GROUP BY
	productsku
HAVING
	COUNT(*) > 1
```
`sales_report`
```
SELECT
	productsku,
	COUNT(*)
FROM
	sales_report
GROUP BY
	productsku
HAVING
	COUNT(*) > 1
```
Answer: No duplicated recorded in products, sales_by_sku and sales_report, all_session
There are duplicated records in analytics.

#### Question 2: How many unique visitors (`fullVisitorID`)

SQL Queries:
```
SELECT 
	COUNT(DISTINCT(fullvisitorid)) AS total_unique_visitors
FROM all_sessions

```
Answer: 13851



#### Question 3: What is the most referring channels

SQL Queries:
```
SELECT 
	channelgrouping AS referring_sites,
	COUNT(DISTINCT(fullvisitorid)) AS total_unique_visitors
FROM analytics
GROUP BY (channelgrouping);
```

Answer: the Organic Search is the channel that attracted the most customers to the website.



#### Question 4: What is the percentage of visitors to the site that actually makes a purchase

SQL Queries:
```
SELECT 
	COUNT(DISTINCT(fullvisitorID)) 
FROM all_sessions
WHERE
	transactions > 0

SELECT 
	COUNT(DISTINCT(fullvisitorID)) 
FROM all_sessions
```

Answer: 80/13581

#### Question 5: What are the most favorite pages?

SQL Queries:
```
SELECT
	pagetitle,
	SUM(pageviews) AS total_pageviews
FROM all_sessions
GROUP BY pagetitle
ORDER BY total_pageviews DESC;
```
Answer: The most favorite page is `YouTube | Shop by Brand | Google Merchandise Store` with 5064 views in total.

