#Customer Dimension
CREATE TABLE dim_customer (customer_id VARCHAR(20) PRIMARY KEY,customer_name VARCHAR(100),segment VARCHAR(50));

INSERT INTO dim_customer SELECT DISTINCT `Customer ID`,`Customer Name`,Segment FROM superstore_raw;

SELECT COUNT(*) FROM dim_customer;

#Product Dimension
CREATE TABLE dim_product (product_id VARCHAR(20) PRIMARY KEY,product_name VARCHAR(200),category VARCHAR(50),sub_category VARCHAR(50));

INSERT INTO dim_product
SELECT `Product ID` AS product_id,MAX(`Product Name`) AS product_name,MAX(Category) AS category,MAX(`Sub-Category`) AS sub_category
FROM superstore_raw GROUP BY `Product ID`;

#Location Dimension
CREATE TABLE dim_location (location_id INT AUTO_INCREMENT PRIMARY KEY,country VARCHAR(50),state VARCHAR(50),city VARCHAR(50),
postal_code VARCHAR(20),region VARCHAR(20));

INSERT INTO dim_location (country, state, city, postal_code, region)
SELECT DISTINCT Country,State,City,`Postal Code`,Region FROM superstore_raw;

SELECT COUNT(*) FROM dim_location;

#Date dimension
CREATE TABLE dim_date (date_id DATE PRIMARY KEY,year INT,month INT,quarter INT);

INSERT INTO dim_date
SELECT DISTINCT order_date_clean,YEAR(order_date_clean),MONTH(order_date_clean),QUARTER(order_date_clean)
FROM superstore_raw WHERE order_date_clean IS NOT NULL;

SELECT COUNT(*) FROM dim_date;


