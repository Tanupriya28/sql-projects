#Retail Superstore – Data Modeling & Analytics Engineering
#Create a Database
DROP DATABASE IF EXISTS superstore_dw;
CREATE DATABASE superstore_dw;
USE superstore_dw;
SHOW TABLES;

SELECT COUNT(*) FROM superstore_raw;

#Checking date format
SELECT `Order Date`,`Ship Date` FROM superstore_raw LIMIT 5;

#Add clean DATE columns
ALTER TABLE superstore_raw ADD COLUMN order_date_clean DATE, ADD COLUMN ship_date_clean DATE;

#Convert text → DATE
UPDATE superstore_raw SET
  order_date_clean = STR_TO_DATE(`Order Date`, '%m/%d/%Y'),
  ship_date_clean  = STR_TO_DATE(`Ship Date`, '%m/%d/%Y');
  
#Verify conversion
SELECT `Order Date`,order_date_clean,`Ship Date`,ship_date_clean FROM superstore_raw LIMIT 5;

