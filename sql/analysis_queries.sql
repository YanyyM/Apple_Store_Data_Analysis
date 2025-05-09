/* Apple Store Data Analysis: Tables customers, orders, products */
SELECT * FROM customers
SELECT * FROM orders
SELECT * FROM products

/* REVENUE AND SALES

QUESTION: 1. What’s the total revenue by product category?
Revenue = price * quantity */

SELECT p.product_name,
	SUM(p.price * o.quantity_ordered) as revenue
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY 1
ORDER BY revenue DESC;

-- QUESTION: 2.	Which customers generate the most revenue?
SELECT c.customer_name, 
	SUM(p.price * o.quantity_ordered) as revenue
FROM products p
LEFT JOIN orders o On p.product_id = o.product_id
LEFT JOIN customers c ON o.customer_id = c.customer_id
GROUP BY 1
ORDER BY revenue DESC;

-- QUESTION: 3. Which products are low stock but high selling?
SELECT p.product_name, p.stock,
	SUM(o.quantity_ordered) as total_items_sold,
	SUM(o.quantity_ordered * p.price) as total_order_amount
FROM products p
INNER JOIN orders o ON p.product_id = o.product_id
GROUP BY 1,2
HAVING p.stock < 15 AND SUM(o.quantity_ordered * p.price) > 10000 
ORDER BY total_order_amount DESC

-- review min and max value
SELECT MIN(stock), MAX(stock), min(price), max(price)
FROM products

-- QUESTION 4: What is the average order value by payment type?
-- order value = price * quantity
SELECT o.payment_type,
	COUNT(*) payment_type,
	ROUND(AVG(p.price * o.quantity_ordered):: numeric,2) as avg_order
FROM orders o
INNER JOIN products p ON o.product_id = p.product_id
GROUP BY 1

-- QUESTION 5: Which product categories have the highest average price?
SELECT product_category,
	COUNT(*) product_category,
	MAX(price), MIN(price),
	ROUND(AVG(price):: numeric,2) as avg_price
FROM products
GROUP BY 1
ORDER BY 2 DESC;



