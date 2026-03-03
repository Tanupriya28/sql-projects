# Retail Superstore – SQL Data Warehouse Project

## Project Overview

This project demonstrates end-to-end SQL Data Engineering by transforming raw retail transaction data into an analytics-ready **Star Schema Data Warehouse** using MySQL.

The objective was to simulate a real-world ETL pipeline including bulk data ingestion, cleaning, dimensional modeling, referential integrity enforcement, performance optimization, and business analytics layer creation.

---

## Dataset Information

- **Source:** Kaggle – Superstore Sales Dataset  
- **Format:** CSV  
- **Total Records:** 9,994 transactions  
- **Time Range:** 2014-01-03 to 2017-12-30  
- **Domain:** Retail Sales  

---

## Data Warehouse Architecture

A **Star Schema** was designed to support scalable analytics and reporting.

### Fact Table

**fact_sales**
- Stores order-line level transactional data  
- Contains revenue, quantity, discount, and profit metrics  
- Connected to dimension tables via foreign keys  

### Dimension Tables

- **dim_customer** – Customer information & segmentation  
- **dim_product** – Product hierarchy (Category, Sub-Category)  
- **dim_location** – Geographic attributes (Country, State, City, Region)  
- **dim_date** – Calendar attributes (Year, Month, Quarter)  

---

## ETL & Data Cleaning

- Performed bulk ingestion using `LOAD DATA LOCAL INFILE`
- Resolved encoding inconsistencies using `CHARACTER SET latin1`
- Corrected column misalignment during ingestion
- Converted mixed-format date fields to SQL DATE using conditional `STR_TO_DATE`
- Created cleaned date columns for accurate time-based analysis
- Inserted distinct values into dimension tables to eliminate duplication
- Generated surrogate key for location dimension

---

## Data Integrity & Constraints

- Added Primary Key to fact table
- Implemented Foreign Key constraints between fact and dimension tables
- Enforced NOT NULL constraints on critical business columns
- Ensured 100% row consistency between raw and fact layers

---

## Performance Optimization

Implemented indexing on high-frequency join and filter columns:

- order_date  
- customer_id  
- product_id  
- location_id  

This improves query efficiency and scalability for analytical workloads.

---

## Data Validation Checks

- Verified no negative sales values
- Ensured quantity values are positive
- Confirmed discount values fall between 0 and 1
- Matched row counts between raw dataset and fact table
- Identified 1,871 loss-making transactions for profitability analysis

---

## Analytical Views Created

1. **monthly_sales_summary**  
   Aggregates total sales and profit by year and month.

2. **sales_by_region**  
   Analyzes revenue performance across geographic regions.

3. **top_products_profit**  
   Identifies highest profit-generating products.

4. **customer_ltv**  
   Calculates customer lifetime value based on total sales.

---

## Key Business Metrics

- **Total Revenue:** $2,297,201  
- **Total Profit:** $286,398  
- **Unique Customers:** 793  
- **Unique Products:** 1,862  
- **Loss-Making Orders:** 1,871  

---

## Business Insights

- Revenue exceeded $2.29M over a 4-year period.
- A significant number of transactions (1,871) resulted in negative profit, indicating discount-driven margin erosion.
- Monthly trend analysis reveals periods of high sales but lower profit margins.
- The dimensional model enables scalable BI dashboard integration.

---

## Execution Order

Run SQL scripts in the following order:

1. database_setup.sql  
2. raw_data_ingestion.sql  
3. data_cleaning.sql  
4. dimensions.sql  
5. fact_sales.sql  
6. constraints_indexes.sql  
7. analytics_views.sql  
8. validation.sql  

---

## Tools & Technologies

- MySQL  
- SQL  
- Kaggle Dataset  
- Dimensional Modeling (Star Schema)  
- Indexing & Query Optimization  

---

## Skills Demonstrated

- Data Cleaning & Transformation  
- ETL Debugging & Validation  
- Dimensional Data Modeling  
- Fact-Dimension Design  
- Referential Integrity Enforcement  
- Performance Optimization  
- Business Analytics Engineering  

---

## Author

Designed and implemented as a SQL Data Warehouse Engineering project for analytics and reporting use cases.
