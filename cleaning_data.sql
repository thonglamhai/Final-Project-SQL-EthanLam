-- Cleaning data for all_lessions table
-- Convert fullVisitorId to TEXT and ADD '0' character to unify the value as 19 character length
-- SELECT 
-- 	fullVisitorId,
-- 	channelgrouping,
-- 	to_timestamp(time) as time,
-- 	country,
-- 	CASE
-- 		WHEN city = '(not set)' OR city = 'not available in demo dataset' THEN country
-- 		ELSE city
-- 	END AS city,
-- 	COALESCE(totalTransactionRevenue, 0) AS totalTransactionRevenue,
-- 	COALESCE(transactions, 0) AS transactions ,
-- 	to_timestamp(timeOnsite) AS timeOnsite,
-- 	pageViews,
-- 	CAST(COALESCE(sessionQualityDim, '0') AS INT) AS sessionQualityDim,
-- 	date,
-- 	visitId,
-- 	type,
-- 	COALESCE(productRefundAmount,0) AS productRefundAmount,
-- 	COALESCE(productQuantity,0) AS productQuantity,
-- 	CAST(productPrice AS FLOAT) / 1000000 AS productPrice ,
-- 	productRevenue,
-- 	productSKU,
-- 	v2productName,
-- 	productVariant,
-- 	COALESCE(currencyCode, 'USD') AS currencyCode,
-- 	itemQuantity,
-- 	itemRevenue,
-- 	transactionRevenue,
-- 	transactionId,
-- 	pageTitle,
-- 	searchKeyword,
-- 	pagepathlevel1,
-- 	ecommerceaction_type,
-- 	ecommerceaction_step,
-- 	ecommerceaction_option
-- FROM
-- 	all_sessions
-- WHERE 
-- 	productSKU LIKE 'G%' AND country != '(not set)';

-- -- remove productsku not consistent
-- DELETE
-- 	FROM all_sessions
-- WHERE 
-- 	productsku NOT LIKE 'G%';

-- remove row where country and city is not set
DELETE 
	FROM all_sessions
WHERE
	country = '(not set)' AND (city = '(not set)' OR city = 'not available in demo dataset');
	
-- update city 
ALTER TABLE all_sessions
ADD clean_city VARCHAR;

UPDATE all_sessions
SET clean_city = (
CASE
	WHEN city = '(not set)' OR city = 'not available in demo dataset' THEN country
	ELSE city
END
);

UPDATE all_sessions
SET country = 'United States'
WHERE city = 'New York';
	
-- update total transaction revenue to 0 (replace NULL value)
ALTER TABLE all_sessions
ALTER COLUMN totaltransactionrevenue TYPE FLOAT

UPDATE all_sessions
	SET totaltransactionrevenue = COALESCE(totaltransactionrevenue, 0);

UPDATE all_sessions
	SET	totaltransactionrevenue = totaltransactionrevenue / 1000000;

	
UPDATE all_sessions
	SET transactions = COALESCE(transactions, 0);
	
	
UPDATE all_sessions
	SET timeonsite = COALESCE(timeonsite, 0);

-- upate data types of session quality dim
ALTER TABLE all_sessions
ALTER COLUMN sessionqualitydim TYPE INTEGER
USING sessionqualitydim::INTEGER;

-- update null values to 0
UPDATE all_sessions
	SET sessionqualitydim = COALESCE(sessionqualitydim, 0);
	
UPDATE all_sessions
	SET productrefundamount = COALESCE(productrefundamount, 0);

-- update product price
ALTER TABLE all_sessions
ALTER COLUMN productprice TYPE FLOAT

UPDATE all_sessions
	SET productprice = productprice / 1000000;

-- update product revenue
ALTER TABLE all_sessions
ALTER COLUMN productrevenue TYPE FLOAT;

UPDATE all_sessions
SET productrevenue = (
	CASE 
		WHEN productrevenue IS NULL THEN productquantity * productprice
		ELSE productrevenue = productrevenue / 1000000
	END
);

UPDATE all_sessions
SET v2productcategory = (
	CASE 
		WHEN v2productcategory = '(not set)' OR v2productcategory = '${escCatTitle}'  THEN 'N/A'
		ELSE v2productcategory
	END
);

UPDATE all_sessions
SET productvariant = (
	CASE 
		WHEN productvariant = '(not set)' THEN 'N/A'
		ELSE productvariant
	END
);

UPDATE all_sessions
	SET currencycode = COALESCE(currencycode, 'USD');

ALTER TABLE all_sessions
ALTER COLUMN transactionrevenue TYPE FLOAT;
UPDATE all_sessions
	SET transactionrevenue = transactionrevenue / 1000000;
	
SELECT *
FROM all_sessions
WHERE productquantity IS NULL
ORDER BY fullvisitorid
LIMIT 100;

-- Cleaning data for analytic table
--1. visitstartime data type - convert
--2. userid missing -> remove
--3. units_sold -> convert NULL to '0'
--4. bounces -> convert NULL to '0'
--5. revenue --> convert NULL to '0', divide to 1000000 for not null values
--6. unit_price --> convert to Float and divide to 1000000
--7. column names -> change unit_price to unitPrice and units_sold to unitsSold
-- SELECT 
-- 	visitnumber,
-- 	visitid,
-- 	to_timestamp(visitstarttime) as visitstarttime,
-- 	date,
-- 	fullvisitorid,
-- 	channelgrouping,
-- 	socialengagementtype,
-- 	COALESCE(units_sold, 0) AS unitsSold,
-- 	pageViews,
-- 	to_timestamp(timeOnsite) AS timeOnsite,
-- 	bounces,
-- 	CAST(COALESCE(renenue, 0) AS FLOAT) /1000000 AS revenue,
-- 	CAST(unit_price AS FLOAT) / 1000000 AS unitPrice
-- FROM
-- 	analytics
-- WHERE renenue IS NOT NULL ;

-- update 

ALTER TABLE analytics
	ADD clean_visitStartTime timestamp;
UPDATE analytics
	SET clean_visitStartTime = to_timestamp(visitStartTime);

ALTER TABLE analytics
	ADD clean_units_sold INTEGER;
UPDATE analytics
	SET clean_units_sold = COALESCE(units_sold, 0);
	
ALTER TABLE analytics
	ADD clean_revenue FLOAT;
UPDATE analytics
	SET clean_revenue = CAST(COALESCE(revenue, 0) AS FLOAT) /1000000;
	
ALTER TABLE analytics
	ADD clean_unit_price FLOAT;
UPDATE analytics
	SET clean_unit_price = CAST(unit_price AS FLOAT) / 1000000;
	
ALTER TABLE analytics
DROP COLUMN userid;


-- SELECT
--     *
-- FROM
--     analytics
-- LIMIT
--     100;


-- Cleaning data products
--1. make interval for restocking lead time
--2. replace NULL to 0 for sentimentscore and sentimentmagnitude
-- SELECT
-- 	sku,
-- 	name,
-- 	orderedquantity,
-- 	stocklevel,
-- 	make_interval(days => restockingleadtime) as restockingleadtime,
-- 	COALESCE(sentimentscore, 0) AS sentimentscore,
-- 	COALESCE(sentimentmagnitude, 0) AS sentimentmagnitude
-- FROM products
-- WHERE sku LIKE 'G%';

-- remove incorrect format of productsku
DELETE
	FROM products
WHERE
	sku NOT LIKE 'G%';

-- change type of restocking lead time to day
ALTER TABLE products
	ADD COLUMN clean_restockingleadtime INTERVAL;
	
UPDATE products
SET clean_restockingleadtime = make_interval(days => restockingleadtime);

-- update null to 0 for sentimentscore and sentimentmagnitude
UPDATE products
	SET sentimentscore = COALESCE(sentimentscore, 0), sentimentmagnitude = COALESCE(sentimentmagnitude, 0);
	

-- SELECT *
-- FROM products;

-- Cleaning data sales_by_sku
--1. remove unrecognized sku
--2. remove total_orderded = 0

DELETE
	FROM sales_by_sku
WHERE
	productsku NOT LIKE 'G%';

-- SELECT *
-- FROM sales_by_sku;


-- Cleaning data sales_report
-- SELECT *
-- FROM sales_report;

DELETE
	FROM sales_report
WHERE
	productsku NOT LIKE 'G%';

ALTER TABLE sales_report
	ADD COLUMN clean_restockingleadtime INTERVAL;
UPDATE sales_report
SET clean_restockingleadtime = make_interval(days => restockingleadtime);

UPDATE sales_report
SET ratio = COALESCE(CAST(ratio AS NUMERIC(10,1)), 0);

-- SELECT 
-- 	productSKU,
-- 	total_ordered AS totalOrdered,
-- 	name,
-- 	stocklevel,
-- 	make_interval(days => restockingleadtime) as restockingLeadTime,
-- 	sentimentscore,
-- 	sentimentmagnitude,
-- 	ratio
-- FROM sales_report
-- WHERE productsku LIKE 'GG%';
