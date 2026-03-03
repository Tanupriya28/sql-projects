#date dimension

#creating table
CREATE TABLE dim_date (date_id DATE PRIMARY KEY,year INT,month INT,quarter INT);

#inserting into table
INSERT INTO dim_date SELECT DISTINCT order_date_clean,YEAR(order_date_clean),MONTH(order_date_clean),QUARTER(order_date_clean)
FROM superstore_raw WHERE order_date_clean IS NOT NULL;

SELECT COUNT(*) FROM dim_date;

#dim customer
CREATE TABLE dim_customer (customer_id VARCHAR(20) PRIMARY KEY,customer_name VARCHAR(100),segment VARCHAR(50));

#insert
INSERT INTO dim_customer SELECT DISTINCT `Customer ID`, `Customer Name`, Segment FROM superstore_raw;

SELECT COUNT(*) FROM dim_customer;

#dim product
CREATE TABLE dim_product (product_id VARCHAR(20) PRIMARY KEY,product_name VARCHAR(200),category VARCHAR(50),sub_category VARCHAR(50));

INSERT INTO dim_product SELECT `Product ID`,MAX(`Product Name`),MAX(Category),MAX(`Sub-Category`)FROM superstore_raw GROUP BY `Product ID`;

#dim location
CREATE TABLE dim_location (location_id INT AUTO_INCREMENT PRIMARY KEY,country VARCHAR(50),state VARCHAR(50),city VARCHAR(50),postal_code VARCHAR(20),
region VARCHAR(50));

#insert into table
INSERT INTO dim_location (country, state, city, postal_code, region) SELECT DISTINCT Country, State, City, `Postal Code`, Region FROM superstore_raw;

# creating fact_sales table
CREATE TABLE fact_sales (order_id VARCHAR(20),order_date DATE,ship_date DATE,ship_mode VARCHAR(30),customer_id VARCHAR(20),product_id VARCHAR(20),
location_id INT,sales DECIMAL(10,2),quantity INT,discount DECIMAL(4,2),profit DECIMAL(10,2));

#insert itno table
INSERT INTO fact_sales SELECT r.`Order ID`,r.order_date_clean,r.ship_date_clean,r.`Ship Mode`,r.`Customer ID`,r.`Product ID`,l.location_id,r.Sales,
r.Quantity,r.Discount,r.Profit FROM superstore_raw r JOIN dim_location l ON r.Country = l.country AND r.State = l.state
AND r.City = l.city AND r.`Postal Code` = l.postal_code AND r.Region = l.region;

SELECT COUNT(*) FROM fact_sales;
