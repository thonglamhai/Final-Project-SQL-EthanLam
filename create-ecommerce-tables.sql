DROP TABLE IF EXISTS all_sessions;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS sales_report;
DROP TABLE IF EXISTS sales_by_sku;
DROP TABLE IF EXISTS analytics;

CREATE TABLE all_sessions (
	fullVisitorId NUMERIC(20,0),
	channelGrouping VARCHAR(50),
	"time" INT,
	country VARCHAR(20),
	city VARCHAR(50),
	totalTransactionRevenue BIGINT,
	transactions INT,
	timeOnSite INT,
	pageviews INT,
	sessionQualityDim VARCHAR(20),
	date DATE,
	visitId INT,
	type VARCHAR(20),
	productRefundAmount INT,
	productQuantity INT,
	productPrice INT,
	productRevenue INT,
	productSKU VARCHAR(50),
	v2ProductName VARCHAR(100),
	v2ProductCategory VARCHAR(50),
	productVariant VARCHAR(20),
	currencyCode VARCHAR(10),
	itemQuantity INT,
	itemRevenue BIGINT,
	transactionRevenue BIGINT,
	transactionId VARCHAR(20),
	pageTitle VARCHAR(800),
	searchKeyword VARCHAR(50),
	pagePathLevel1 VARCHAR(50),
	eCommerceAction_type INT,
	eCommerceAction_step INT,
	eCommerceAction_option VARCHAR(20)
);



CREATE TABLE products (
	SKU VARCHAR(20),
	name VARCHAR(100),
	orderedQuantity INT,
	stockLevel INT,
	restockingLeadTime INT,
	sentimentScore FLOAT(1),
	sentimentMagnitude FlOAT(1)
);


CREATE TABLE sales_by_sku (
	productSKU VARCHAR(20),
	total_ordered INT
);


CREATE TABLE sales_report (
	productSKU VARCHAR(20),
	total_ordered INT,
	name VARCHAR(100),
	stockLevel INT,
	restockingLeadTime INT,
	sentimentScore FLOAT(1),
	sentimentMagnitude FlOAT(1),
	ratio FLOAT
);


CREATE TABLE analytics (
	visitNumber INT,
	visitId INT,
	visitStartTime INT,
	date DATE,
	fullVisitorId NUMERIC(20,0),
	userid INT,
	channelGrouping VARCHAR(50),
	socialEngagementType VARCHAR(50),
	units_sold INT,
	pageviews INT,
	timeonsite INT,
	bounces INT,
	revenue BIGINT,
	unit_price INT
);

