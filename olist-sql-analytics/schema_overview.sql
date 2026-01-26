#SCHEMA & OVERVIEW
#Purpose: Understand dataset structure before cleaning or analysis

#Creating the database
CREATE DATABASE IF NOT EXISTS olist;

#Using the database created
USE olist;

#List of tables
SHOW tables;

#Row Count Validation
SELECT 'olist_orders_dataset' AS table_name, COUNT(*) AS row_count FROM olist_orders_dataset
UNION ALL
SELECT 'olist_order_items_dataset', COUNT(*) FROM olist_order_items_dataset
UNION ALL
SELECT 'olist_order_payments_dataset', COUNT(*) FROM olist_order_payments_dataset
UNION ALL
SELECT 'olist_order_reviews_dataset', COUNT(*) FROM olist_order_reviews_dataset
UNION ALL
SELECT 'olist_products_dataset', COUNT(*) FROM olist_products_dataset;

#Schema Inspection
DESCRIBE olist_orders_dataset;
DESCRIBE olist_order_items_dataset;
DESCRIBE olist_customers_dataset;

#Checking uniqueness of order_id
SELECT COUNT(*) AS total_rows,COUNT(DISTINCT order_id) AS unique_order_ids FROM olist_orders_dataset;

#Checking uniqueness of customer_id
SELECT COUNT(*) AS total_rows,COUNT(DISTINCT customer_id) AS unique_customer_ids FROM olist_customers_dataset;

#Note: Raw tables are kept unchanged. No joins or cleaning performed in this phase.

