Question 1: 

SQL Queries:
```
--1.find all duplicate records
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

SELECT
	sku,
	COUNT(*)
FROM
	products
GROUP BY
	sku
HAVING
	COUNT(*) > 1
	

SELECT
	productsku,
	COUNT(*)
FROM
	sales_by_sku
GROUP BY
	productsku
HAVING
	COUNT(*) > 1


SELECT
	productsku,
	COUNT(*)
FROM
	sales_report
GROUP BY
	productsku
HAVING
	COUNT(*) > 1```
Answer: No duplicated recorded in products, sales_by_sku and sales_report, all_session
There are duplicated records in analytics.



Question 2: 

SQL Queries:
```
SELECT 
	COUNT(DISTINCT(fullvisitorid)) AS total_unique_visitors
FROM all_sessions

```
Answer: 13851



Question 3: 

SQL Queries:
```
SELECT 
	channelgrouping AS referring_sites,
	COUNT(DISTINCT(fullvisitorid)) AS total_unique_visitors
FROM analytics
GROUP BY (channelgrouping);
```

Answer:
(Other)	2
Affiliates	1469
Direct	21340
Display	844
Organic Search	66333
Paid Search	3762
Referral	18382
Social	11023
```

Question 4: 

SQL Queries:

Answer:



Question 5: 

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
