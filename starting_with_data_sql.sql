--# Part 4: Starting with Data
-- Consider the data you have available to you.  You can use the data to:
--     - find all duplicate records
--     - find the total number of unique visitors (`fullVisitorID`)
--     - find the total number of unique visitors by referring sites
--     - find each unique product viewed by each visitor
--     - compute the percentage of visitors to the site that actually makes a purchase


--1.find all duplicate records
SELECT fullvisitorID, COUNT(fullvisitorID)
FROM all_sessions
GROUP BY (fullvisitorID)
HAVING COUNT(fullvisitorID) > 1;


SELECT visitid, clean_visitstarttime, fullvisitorid, COUNT(*)
FROM analytics
GROUP BY visitid, clean_visitstarttime, fullvisitorid
HAVING COUNT(*) > 1


--2.find the total number of unique visitors (`fullVisitorID`)
With cte AS (
	SELECT DISTINCT(fullvisitorid)
	FROM all_sessions
)
SELECT
	COUNT (*) AS total_unique_visitors
FROM
	cte;


--3. find the total number of unique visitors by referring sites
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
	a.fullvisitorid
	productsku,
	v2productname,
	pagetitle,
	fullvisitorid
FROM
	all_sessions
WHERE
	pageviews != 0;
	
-- - compute the percentage of visitors to the site that actually makes a purchase


With cte AS (
	SELECT DISTINCT(fullvisitorid)
	FROM all_sessions
)
SELECT
	COUNT (*) AS total_unique_visitors
FROM
	cte;
	
with cte2 AS (
	SELECT DISTINCT(fullvisitorid)
	FROM all_sessions
	WHERE transactions != 0
)
SELECT 
	COUNT (*) AS total_visitor_purchased
FROM cte2

SELECT total_visitor_purchased / total_unique_visitor
FROM cte1, cte2
