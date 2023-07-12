# Final-Project-Transforming-and-Analyzing-Data-with-SQL

## Project/Goals
In this project, we will combine and practice implementing what we have learned throughout this course, including:

Extracting data from a SQL database
Cleaning, transforming and analyzing data
Loading data into a database
Developing and implementing a QA process to validate transformed data against raw data

## Process
### 1. Importing data from CSV files
Below are steps have been taken to import.
- Creating database named `ecommerce` in the database system.
- Create tables in the `ecommerce` database. The tables `all_sessions`, `analytics`, `products`, `sales_by_sku`, and `sales_report`
- Go to pgAdmin and import the csv files
### 2. Cleaning data in database
Looking for Irrelevant data, Incorrect data, Inappropriate data types, and Missing data. For example,

Irrelevant data: 
- userid

Incorrect data:
- productsku
- productprice

Inappropriate data types:~~~~
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

Missing data:
- country
- city
- v2productcategory
- productvariant
- currencycode
- revenue

Prefer to the file `cleaning-data.md` for more information about the actions/queries.
### 3. Working on the assignment questions.
Answer the questions in the assignment using queries. Prefer to the file `starting_with_questions.md`

### 4. QA the data
QA the data to ensure the correctness of the data. Prefer to the file `QA.md`

### 5 Working on some more questions.
I have created some more questions about data and tried to answer them. Prefer to the file `starting_with_data.md`
### 6. Update the primary key and foreign key
After cleaning the data and make sure that the data is good to go. I have altered the primary key and foreign key of the tables to show the relationship between them. Examples: 
```
ALTER TABLE products ADD PRIMARY KEY (sku);
ALTER TABLE sales_report ADD PRIMARY KEY (productsku);
ALTER TABLE sales_report 
    ADD CONSTRAINT fk_sku FOREIGN KEY (productsku) REFERENCES products (sku);
```
I have added this part in the file `create-ecommerce-table`
### 7. Generate the schema
Using pgAdmin to generate the schema
## Results
(fill in what you discovered this data could tell you and how you used the data to answer those questions)
The data is about an ecommerce website's data. the typical scenario is a user comes to the website, searching for the products which they are interested in to review and do buy (transaction).

The site will collect all the data related to analyze the user behaviour and the best product selling for their purpose.

Everytime user go to the website, the website will collect data of that transaction to store into the `all_sessions` table.

The `products` table stores the inventory information of the website. For example, what kind of product that they are selling and how many were sold, how many left in the inventory and time to restocking as well as the unit price of the products.

The `analytics` table stores the analytics information. It seems like an subset of information from the `all_sessions` table

The `sales_by_sku` contains the data of total ordered by product's sku

The `sales_report` also contains the data of total ordered by product's sku but includes some more information such as the name of the product, stock level and restocking time

## Challenges 
(discuss challenges you faced in the project)
The business logic behind the data is not known. Therefore, it is really challenging to figure out the relationship between the tables and the relationships between the data in the table. As a result, doing cleaning data was really hard and time-consuming.
The data looks very similar between tables such as `sales_report` and `sales_by_sku`. The question is why the system does have `sales_by_sku` because all the information are seems just duplicated from `sales_report`
Another challenge is to figure out the relationship between `all_sessions` and `analytics`. There are several fields such as `unit_price` is not understandable.
The analytic measure is `sentiment_score` and `sentiment_magnitude`. However, how it is used in the analysis is not yet known. They needs more time to understand to use effectively.
Because of the unknow relationship so it is really hard to make sure that which field should be used in the queries. What and How to join the two or three tables together to solve the problem.

## Future Goals
(what would you do if you had more time?)
I would spend more time to understand the data better. I think it is the key to solve the problem.
