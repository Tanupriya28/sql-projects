# Retail Superstore – SQL Data Modeling & Analytics Engineering

##  Project Overview

This project demonstrates end-to-end SQL Data Engineering using the Retail Superstore dataset.  
The objective was to transform raw transactional retail data into an analytics-ready dimensional data warehouse using MySQL.

The project simulates a real-world ETL pipeline including:

- Data cleaning and preprocessing
- Dimensional modeling (Star Schema)
- Fact table creation
- Referential integrity enforcement
- Performance optimization using indexing
- Business analytics view creation
- Data validation checks

---

## Dataset Information

- **Source:** Kaggle – Superstore Sales Dataset  
- **Format:** CSV  
- **Records:** ~9,600 rows  
- **Domain:** Retail Sales Transactions  

---

## Data Warehouse Architecture

A **Star Schema** was designed to support scalable analytics and reporting.

###  Fact Table

**fact_sales**
- Stores order-line level transactional sales data
- Contains revenue, quantity, discount, and profit metrics
- Connected to all dimension tables via foreign keys

### Dimension Tables

- **dim_customer** – Customer details and segmentation
- **dim_product** – Product hierarchy (Category, Sub-Category)
- **dim_location** – Geographic attributes (Country, State, City, Region)
- **dim_date** – Calendar attributes (Year, Month, Quarter)

---

##  ETL & Data Cleaning

- Converted raw `Order Date` and `Ship Date` fields from TEXT to SQL `DATE`
- Created cleaned date columns for accurate time-based analysis
- Removed potential formatting inconsistencies
- Inserted distinct dimension values to prevent duplication
- Generated surrogate key for location dimension

---

##  Data Integrity & Constraints

To simulate production-level warehouse design:

- Added **Foreign Key constraints** between fact and dimension tables
- Ensured referential integrity across the schema

---

##  Performance Optimization

Implemented indexing on frequently joined and filtered columns:

- `order_date`
- `customer_id`
- `product_id`
- `location_id`

This improves query execution performance for large datasets.

---

##  Data Validation Checks

Implemented business-rule validation queries:

- Ensured no negative sales values
- Verified quantity values are positive
- Confirmed discount values fall between 0 and 1
- Matched row counts between raw dataset and fact table

---

##  Analytics Views Created

### 1️. monthly_sales_summary
Aggregates total sales and profit by year and month.

### 2️. sales_by_region
Analyzes revenue performance by geographic region.

### 3. top_products_profit
Identifies most profitable products.

### 4️. customer_ltv
Calculates customer lifetime value based on total sales.

---

##  Execution Order

Run SQL scripts in the following order:

1. `database_setup.sql`
2. `data_cleaning.sql`
3. `dimensions.sql`
4. `fact_sales.sql`
5. `constraints_indexes.sql`
6. `analytics_views.sql`
7. `validation.sql`

This ensures proper schema creation, data loading, and analytics setup.

---

## Key Business Insights

- Monthly sales and profit trends can be easily tracked using the star schema.
- Some high-sales months show lower profit due to discount impact.
- Customer lifetime value analysis enables segmentation strategies.
- The dimensional model supports scalable dashboard integration.

---

## Tools & Technologies

- MySQL
- SQL
- Kaggle Dataset
- Dimensional Modeling (Star Schema)
- Indexing & Performance Optimization

---

##  Skills Demonstrated

- Data Cleaning & Transformation
- Dimensional Data Modeling
- Fact-Dimension Design
- Referential Integrity Enforcement
- Query Optimization
- Business Analytics Engineering

---

##  Author

Designed and implemented as a SQL Data Warehouse Engineering project for analytics and reporting use cases.
