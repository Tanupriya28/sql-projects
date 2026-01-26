USE olist;

#CTE: Customer Order Summary
#Break complex logic into readable steps
WITH customer_orders AS (
SELECT customer_id,COUNT(DISTINCT order_id) AS total_orders,SUM(price + freight_value) AS total_spent FROM fact_orders GROUP BY customer_id)
SELECT * FROM customer_orders;

#Window Function: Rank Customers by Spend
SELECT customer_id,SUM(price + freight_value) AS total_spent,RANK() OVER (ORDER BY SUM(price + freight_value) DESC) AS spend_rank
FROM fact_orders GROUP BY customer_id;

#Window Function: Top Seller per State
WITH seller_revenue AS (
SELECT s.seller_state,fo.seller_id,SUM(fo.price + fo.freight_value) AS revenue FROM fact_orders fo JOIN dim_sellers s ON fo.seller_id = s.seller_id
GROUP BY s.seller_state, fo.seller_id)
SELECT * FROM ( 
SELECT seller_state,seller_id,revenue,ROW_NUMBER() OVER (PARTITION BY seller_state ORDER BY revenue DESC) AS rn FROM seller_revenue) t WHERE rn = 1;

#Running Total: Revenue Over Time
SELECT order_date,daily_revenue,SUM(daily_revenue) OVER (ORDER BY order_date) AS running_revenue
FROM (
SELECT DATE(order_purchase_timestamp) AS order_date,SUM(price + freight_value) AS daily_revenue FROM fact_orders GROUP BY DATE(order_purchase_timestamp)) t;

#Window Function: Customer Lifetime Value
SELECT customer_id,SUM(price + freight_value) AS lifetime_value,COUNT(DISTINCT order_id) AS total_orders,AVG(price + freight_value) AS avg_order_value
FROM fact_orders GROUP BY customer_id;

#Percentage Contribution: Seller Revenue Share
SELECT seller_id,SUM(price + freight_value) AS seller_revenue,ROUND(SUM(price + freight_value) * 100.0 /SUM(SUM(price + freight_value)) OVER (),2) AS 
revenue_percentage FROM fact_orders GROUP BY seller_id ORDER BY seller_revenue DESC;

#CTE + Window: Repeat vs One-Time Customers
WITH customer_order_counts AS (
SELECT customer_id,COUNT(DISTINCT order_id) AS order_count FROM fact_orders GROUP BY customer_id)
SELECT CASE WHEN order_count = 1 THEN 'One-Time' ELSE 'Repeat' END AS customer_type, COUNT(*) AS customer_count FROM customer_order_counts
GROUP BY customer_type;
