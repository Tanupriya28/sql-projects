#Purpose: Validate data quality before cleaning or modeling
 USE olist;
 
 #Null Check – Critical Columns
SELECT COUNT(*) AS total_orders,SUM(order_purchase_timestamp IS NULL) AS null_purchase_ts,SUM(order_approved_at IS NULL) AS null_approved_ts,
SUM(order_delivered_customer_date IS NULL) AS null_delivered_ts FROM olist_orders_dataset;

#Order Status Validation
SELECT order_status,COUNT(*) AS count_orders FROM olist_orders_dataset GROUP BY order_status;

#Delivery Date Logic Check
SELECT COUNT(*) AS invalid_delivery_orders FROM olist_orders_dataset WHERE order_delivered_customer_date < order_purchase_timestamp;

SELECT order_id,order_purchase_timestamp,order_delivered_customer_date,order_status FROM olist_orders_dataset
WHERE order_delivered_customer_date < order_purchase_timestamp LIMIT 10;
#Based on above query we see orders with delivery timestamps despite being in non-delivered statuses such as shipped or unavailable.We need to fix it later in cleaning stage.

#Order Items – Price & Freight Validation
SELECT COUNT(*) AS total_items,SUM(price <= 0) AS invalid_price_count,SUM(freight_value < 0) AS invalid_freight_count FROM olist_order_items_dataset;

#Duplicate Check – Order Items
SELECT order_id,product_id,COUNT(*) AS duplicate_count FROM olist_order_items_dataset GROUP BY order_id, product_id HAVING COUNT(*) > 1;
#Multiple rows per (order_id, product_id) represent item quantity and are not true duplicates.

#Reviews Coverage Check
SELECT COUNT(DISTINCT order_id) AS reviewed_orders FROM olist_order_reviews_dataset;

#Customers Without Orders
SELECT COUNT(*) AS customers_without_orders FROM olist_customers_dataset c LEFT JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;

