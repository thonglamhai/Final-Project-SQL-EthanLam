What issues will you address by cleaning the data?
- irrelevant data
  - the userid in the analytics
- The missing data such as
  - the country and city is "(not set)" or "not available in the demo dataset"
  - 
- Inappropriate data types
- 



# Step 1: Remove irrelevant data

# Step 2: Remove duplicates
# Step 3: Fix structural errors
# Step 4: Convert types
There are some inappropriate data types
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
 # Step 5: Handle missing data
    Removing data
        - Removing data if there are missing country and city in all_sessions
```all_sessions```
    Replacing data

# Step 6: Deal with Outliers
# Step 7: Standardize/Normalize data
# Step 8: Validate data


# Heading One
Queries:
Below, provide the SQL queries you used to clean your data.
