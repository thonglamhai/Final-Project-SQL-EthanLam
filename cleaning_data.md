# What issues will you address by cleaning the data?
#### Irrelevant data:
- userid

#### Incorrect data
- productsku
- productprice

#### Inappropriate data types
- all_sessions
    - totaltransactionrevenue: integer to float
-  analytics
    - visitstarttime: integer to timestamp
    - revenue: integer to float
    - unitprice: integer to float
- products
    - restockingleadtime: integer to interval
- sales_report
    - restockingleadtime: integer to interval

##### Missing data
- country
- city
- v2productcategory
- productvariant
- currencycode
- revenue

# Queries:
Below, provide the SQL queries you used to clean your data.


```
DELETE 
	FROM all_sessions
WHERE
	country = '(not set)' AND (city = '(not set)' OR city = 'not available in demo dataset');
```

-- update city 

```
ALTER TABLE all_sessions
ADD clean_city VARCHAR;

UPDATE all_sessions
SET clean_city = (
CASE
	WHEN city = '(not set)' OR city = 'not available in demo dataset' THEN country
	ELSE city
END
);
```

```
UPDATE all_sessions
SET country = 'United States'
WHERE city = 'New York';
```
	
-- update total transaction revenue to 0 (replace NULL value)
```
ALTER TABLE all_sessions
ALTER COLUMN totaltransactionrevenue TYPE FLOAT

UPDATE all_sessions
	SET totaltransactionrevenue = COALESCE(totaltransactionrevenue, 0);
```

Update the value of the `totaltransactionrevenue` by dividing to `1000000`
```
UPDATE all_sessions
	SET	totaltransactionrevenue = totaltransactionrevenue / 1000000;
```

Change the `NULL` value to `0`
```	
UPDATE all_sessions
	SET transactions = COALESCE(transactions, 0);
```	

Change the `NULL` value to `0`
```
UPDATE all_sessions
	SET timeonsite = COALESCE(timeonsite, 0);
```


Change data types of session quality dim
```
ALTER TABLE all_sessions
ALTER COLUMN sessionqualitydim TYPE INTEGER
USING sessionqualitydim::INTEGER;
```

Change the `NULL` value to `0`
```
UPDATE all_sessions
	SET sessionqualitydim = COALESCE(sessionqualitydim, 0);
	
UPDATE all_sessions
	SET productrefundamount = COALESCE(productrefundamount, 0);
```

Change data type of `productprice`
```
ALTER TABLE all_sessions
ALTER COLUMN productprice TYPE FLOAT
```

Update value of `productprice` by dividing to `1000000`
```
UPDATE all_sessions
	SET productprice = productprice / 1000000;
```
Change data type of `productrevenue`
```
ALTER TABLE all_sessions
ALTER COLUMN productrevenue TYPE FLOAT;
```
```
UPDATE all_sessions
SET productrevenue = (
	CASE 
		WHEN productrevenue IS NULL THEN productquantity * productprice
		ELSE productrevenue = productrevenue / 1000000
	END
);
```
```
UPDATE all_sessions
SET v2productcategory = (
	CASE 
		WHEN v2productcategory = '(not set)' OR v2productcategory = '${escCatTitle}'  THEN 'N/A'
		ELSE v2productcategory
	END
);
```
```
UPDATE all_sessions
SET productvariant = (
	CASE 
		WHEN productvariant = '(not set)' THEN 'N/A'
		ELSE productvariant
	END
);
```
```
UPDATE all_sessions
	SET currencycode = COALESCE(currencycode, 'USD');
```

```
ALTER TABLE all_sessions
ALTER COLUMN transactionrevenue TYPE FLOAT;
```

```
UPDATE all_sessions
	SET transactionrevenue = transactionrevenue / 1000000;
```


```
ALTER TABLE analytics
	ADD clean_visitStartTime timestamp;
UPDATE analytics
	SET clean_visitStartTime = to_timestamp(visitStartTime);
```    

```
ALTER TABLE analytics
	ADD clean_units_sold INTEGER;
UPDATE analytics
	SET clean_units_sold = COALESCE(units_sold, 0);
```
```
ALTER TABLE analytics
	ADD clean_revenue FLOAT;
UPDATE analytics
	SET clean_revenue = CAST(COALESCE(revenue, 0) AS FLOAT) /1000000;
```
```
ALTER TABLE analytics
	ADD clean_unit_price FLOAT;
UPDATE analytics
	SET clean_unit_price = CAST(unit_price AS FLOAT) / 1000000;
```
```
ALTER TABLE analytics
DROP COLUMN userid;
```



Delete the incorrect values of productsku
```
DELETE
	FROM products
WHERE
	sku NOT LIKE 'G%';
```

Change data type of restocking lead time to day

```
ALTER TABLE products
	ADD COLUMN clean_restockingleadtime INTERVAL;
	
UPDATE products
SET clean_restockingleadtime = make_interval(days => restockingleadtime);
```

Change `NULL` to `0` for sentimentscore and sentimentmagnitude
```
UPDATE products
	SET sentimentscore = COALESCE(sentimentscore, 0), sentimentmagnitude = COALESCE(sentimentmagnitude, 0);
```

```
DELETE
	FROM sales_by_sku
WHERE
	productsku NOT LIKE 'G%';
```

```
DELETE
	FROM sales_report
WHERE
	productsku NOT LIKE 'G%';
```
```
ALTER TABLE sales_report
	ADD COLUMN clean_restockingleadtime INTERVAL;
UPDATE sales_report
SET clean_restockingleadtime = make_interval(days => restockingleadtime);
```
```
UPDATE sales_report
SET ratio = COALESCE(CAST(ratio AS NUMERIC(10,1)), 0);
```
