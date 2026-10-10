-- CREATE DATABASE pizza_sales;
USE pizza_sales;
-- SELECT * FROM orders;
-- SELECT * FROM pizzas;
select pizza_id, pizza_type_id,size, cast(price as signed) as price from pizzas;
-- select * from pizza_types;
-- select * from order_details;
SELECT COUNT(DISTINCT order_id) AS total_orders FROM orders;
SELECT SUM(od.quantity * p.price) AS total_revenue
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id;
SELECT pt.name, p.size, p.price
FROM pizzas p
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;
SELECT p.size, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_quantity DESC
LIMIT 1;
SELECT pt.name, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id 
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;