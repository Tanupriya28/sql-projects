#Purpose: Create clean, analysis-ready views while preserving raw data
USE olist;

#Clean Orders View
#Keep only successfully delivered orders for reliable delivery and revenue analysis
CREATE OR REPLACE VIEW clean_orders AS
SELECT *
FROM olist_orders_dataset
WHERE order_status = 'delivered';

#Clean Order Items View
#Include order items only for valid delivered orders to avoid revenue from canceled or incomplete orders
CREATE OR REPLACE VIEW clean_order_items AS
SELECT oi.* FROM olist_order_items_dataset oi JOIN clean_orders co ON oi.order_id = co.order_id;

#Clean Customers View
#Retain only customers who have at least one delivered order for customer-level analytics
CREATE OR REPLACE VIEW clean_customers AS
SELECT DISTINCT c.* FROM olist_customers_dataset c JOIN clean_orders co ON c.customer_id = co.customer_id;

#Clean Reviews View
#Link reviews only to valid delivered orders to prevent misleading review analysis
CREATE OR REPLACE VIEW clean_reviews AS
SELECT r.* FROM olist_order_reviews_dataset r JOIN clean_orders co ON r.order_id = co.order_id;

#Clean Payments View
#Include payments associated only with delivered orders to ensure accurate revenue calculations
CREATE OR REPLACE VIEW clean_payments AS
SELECT p.* FROM olist_order_payments_dataset p JOIN clean_orders co ON p.order_id = co.order_id;

