#Purpose: Generate business insights from analytical views

USE olist;

#Total Revenue (Overall)
#Measure overall business performance
SELECT ROUND(SUM(price + freight_value),2) AS total_revenue FROM fact_orders;

#Orders & Revenue Over Time
#Understand growth and seasonality trends
SELECT DATE(order_purchase_timestamp) AS order_date,COUNT(DISTINCT order_id) AS total_orders,SUM(price + freight_value) AS daily_revenue
FROM fact_orders GROUP BY DATE(order_purchase_timestamp) ORDER BY order_date;

#Average Order Value (AOV)
#Track customer spending behavior
SELECT SUM(price + freight_value) / COUNT(DISTINCT order_id) AS avg_order_value FROM fact_orders;

#Top 10 Sellers by Revenue
#Identify high-performing sellers
SELECT seller_id,SUM(price + freight_value) AS seller_revenue FROM fact_orders GROUP BY seller_id ORDER BY seller_revenue DESC LIMIT 10;

#Top Product Categories by Revenue
#Understand which product categories drive sales
SELECT dp.product_category_name,SUM(fo.price + fo.freight_value) AS category_revenue FROM fact_orders fo JOIN dim_products dp
ON fo.product_id = dp.product_id GROUP BY dp.product_category_name ORDER BY category_revenue DESC;

#Customer Order Frequency
#Identify repeat vs one-time customers
SELECT customer_id,COUNT(DISTINCT order_id) AS total_orders FROM fact_orders GROUP BY customer_id;

#Repeat Customer Rate
#Measure customer retention
SELECT COUNT(DISTINCT CASE WHEN order_count > 1 THEN customer_id END) * 1.0/ COUNT(DISTINCT customer_id) AS repeat_customer_rate
FROM (SELECT customer_id,COUNT(DISTINCT order_id) AS order_count FROM fact_orders GROUP BY customer_id) t;

#Average Delivery Time (Days)
#Evaluate logistics performance
SELECT AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) AS avg_delivery_days FROM fact_orders;

#Payment Method Distribution
#Understand customer payment preferences
SELECT payment_type,COUNT(DISTINCT order_id) AS orders_count FROM fact_payments GROUP BY payment_type ORDER BY orders_count DESC;

#Review Score Distribution
#Analyze customer satisfaction (only reviewed orders)
SELECT review_score,COUNT(*) AS review_count FROM fact_reviews GROUP BY review_score ORDER BY review_score;

