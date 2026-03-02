# PERFORMANCE OPTIMIZATION & SCALABILITY STRATEGY
# Purpose: Improve query performance and prepare for large-scale datasets

use olist;
describe olist_orders_dataset;
#Converting TEXT to VARCHAR
alter table olist_orders_dataset modify customer_id varchar(50);

alter table olist_orders_dataset modify order_id varchar(50);

alter table olist_orders_dataset modify order_status varchar(20);

alter table  olist_order_items_dataset modify order_id varchar(50),modify product_id varchar(50),modify seller_id varchar(50);

alter table olist_order_payments_dataset modify order_id varchar(50);



#Converting empty strings to null
update olist_orders_dataset set order_approved_at = null where order_approved_at = '';

update olist_orders_dataset set order_delivered_customer_date = null where order_delivered_customer_date = '';

update olist_orders_dataset set order_delivered_customer_date = null where order_purchase_timestamp = '';

#Converting text to datetime
alter table olist_orders_dataset modify order_purchase_timestamp datetime;

alter table olist_orders_dataset modify order_approved_at datetime;

alter table olist_orders_dataset modify order_delivered_customer_date datetime;

select count(*)  from olist_orders_dataset where order_purchase_timestamp is null;


# Adding Primary Keys

alter table olist_orders_dataset add primary key (order_id);

alter table olist_order_items_dataset add index idx_order_product (order_id, product_id);

alter table olist_order_payments_dataset add index idx_payment_order (order_id);

# 1. Indexing Strategy

# Orders table indexes (frequent filters and joins)
create index idx_orders_customer_id  on olist_orders_dataset(customer_id);

create index idx_orders_status on olist_orders_dataset(order_status);

create index idx_orders_purchase_ts on olist_orders_dataset(order_purchase_timestamp);

# Order Items table indexes 
create index idx_items_order_product on olist_order_items_dataset(order_id, product_id);

create index idx_items_product_id  on olist_order_items_dataset(product_id);

create index idx_items_seller_id  on olist_order_items_dataset(seller_id);

# Payments table index
create index idx_payments_order_id  on olist_order_payments_dataset(order_id);


# 2. Query Plan Analysis 

# Analyze execution plan for high-cost query

explain select customer_id,SUM(price + freight_value) as total_spent from fact_orders group by customer_id;


# 3. Optimized Revenue Query (Avoid Recalculation)

# Instead of recalculating (price + freight_value) repeatedly,
# we can create a computed revenue column inside fact_orders view.

create or replace view fact_orders_optimized as select co.order_id,co.customer_id,co.order_purchase_timestamp,co.order_delivered_customer_date,oi.product_id,
oi.seller_id,oi.price,oi.freight_value,(oi.price + oi.freight_value) as total_revenue from clean_orders co join clean_order_items oi on co.order_id = oi.order_id;


# Optimized query using precomputed column

select customer_id,SUM(total_revenue) as total_spent from fact_orders_optimized group by customer_id;


# Note:
# MySQL views are not materialized.
# For large-scale production systems, summary tables or materialized views
# should be used for heavy aggregations like revenue per customer.