What issues will you address by cleaning the data?


The SKU values are not consistent 

# Step 1: Remove irrelevant data
# Step 2: Remove duplicates
# Step 3: Fix structural errors
# Step 4: Convert types
    analytics: visitstarttime -> change to timestamp format
    ratio: the inconsistency of the data -> change to numeric format
    analytics: unitprice = 0 -> null
    all_sessions: time -> timestamp
    all_sessions: city -> country if not specified
    all_sessions: productprice 0 --> null
    all_sessions: productvariant: not set -> null
    all_sessions: currencycode -> usd
# Step 5: Handle missing data
    Removing data
    Replacing data
# Step 6: Deal with Outliers
# Step 7: Standardize/Normalize data
# Step 8: Validate data


# Heading One
Queries:
Below, provide the SQL queries you used to clean your data.
