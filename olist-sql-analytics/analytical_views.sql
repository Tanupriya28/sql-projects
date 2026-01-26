#Purpose: Build fact and dimension views for business analysis

USE olist;

#Fact Orders View
#Central fact table combining orders, items, customers, and revenue-related fields
CREATE OR REPLACE VIEW fact_orders AS
SELECT co.order_id,co.customer_id,co.order_purchase_timestamp,co.order_delivered_customer_date,oi.product_id,oi.seller_id,oi.price,oi.freight_value
FROM clean_orders co JOIN clean_order_items oi ON co.order_id = oi.order_id;

#Customer Dimension
#Customer attributes used for segmentation and customer-level metrics
CREATE OR REPLACE VIEW dim_customers AS
SELECT DISTINCT customer_id,customer_city,customer_state FROM clean_customers;

#Product Dimension
#Product-level attributes for category and product analysis
CREATE OR REPLACE VIEW dim_products AS
SELECT p.product_id,p.product_category_name,p.product_weight_g,p.product_length_cm,p.product_height_cm,p.product_width_cm FROM olist_products_dataset p;

#Seller Dimension
#Seller-level performance and contribution analysis
CREATE OR REPLACE VIEW dim_sellers AS
SELECT seller_id,seller_city,seller_state FROM olist_sellers_dataset;

#Payment Fact
#Analyze payment methods and installment behavior
CREATE OR REPLACE VIEW fact_payments AS
SELECT p.order_id,p.payment_type,p.payment_installments,p.payment_value FROM clean_payments p;

#Reviews Fact (Optional Analysis Layer)
#Reviews are sparse, so kept separate from main fact table
CREATE OR REPLACE VIEW fact_reviews AS
SELECT r.order_id,r.review_score,r.review_creation_date FROM clean_reviews r;


