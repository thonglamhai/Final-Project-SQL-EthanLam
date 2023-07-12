--# Part 4: Starting with Data
-- Consider the data you have available to you.  You can use the data to:
--     - find all duplicate records
--     - find the total number of unique visitors (`fullVisitorID`)
--     - find the total number of unique visitors by referring sites
--     - find each unique product viewed by each visitor
--     - compute the percentage of visitors to the site that actually makes a purchase


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
	COUNT(*) > 1

--2.find the total number of unique visitors (`fullVisitorID`)

SELECT 
	COUNT(DISTINCT(fullvisitorid)) AS total_unique_visitors
FROM all_sessions


--3. find the total number of unique visitors by referring channel
-- Solution 01 - Understanding that referring sites are channels
SELECT 
	channelgrouping AS referring_sites,
	COUNT(DISTINCT(fullvisitorid)) AS total_unique_visitors
FROM analytics
GROUP BY (channelgrouping);

-- Solution 02 - Understanding that referring sites are sites

WITH refering_sites AS (
	SELECT DISTINCT
		pagetitle,
		pagepathlevel1,
		COUNT(fullvisitorid) OVER (PARTITION BY pagetitle, pagepathlevel1) AS visitors
	FROM all_sessions
)
SELECT
	pagetitle,
	pagepathlevel1,
	visitors
FROM refering_sites;
--4. find each unique product viewed by each visitor

SELECT 
	DISTINCT(fullvisitorid),
	productsku
FROM
	all_sessions
WHERE pageviews != 0
GROUP BY productsku, fullvisitorid
ORDER BY productsku, fullvisitorid;

SELECT * FROM analytics LIMIT 10;
-- - compute the percentage of visitors to the site that actually makes a purchase


SELECT 
	COUNT(DISTINCT(fullvisitorID)) 
FROM all_sessions
WHERE
	transactions > 0

SELECT 
	COUNT(DISTINCT(fullvisitorID)) 
FROM all_sessions



