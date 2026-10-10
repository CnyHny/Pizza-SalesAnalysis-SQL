USE pizza_sales;
SELECT pt.category, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_quantity DESC;
SELECT HOUR(time) AS order_hour,
       COUNT(DISTINCT order_id) AS total_orders
FROM orders
GROUP BY HOUR(time)
ORDER BY order_hour;
SELECT pt.category, COUNT(DISTINCT pt.pizza_type_id) AS pizza_types
FROM pizza_types pt
GROUP BY pt.category
ORDER BY pizza_types DESC;
SELECT ROUND(AVG(daily_quantity), 2) AS avg_pizzas_per_day
FROM (
    SELECT o.date, SUM(od.quantity) AS daily_quantity
    FROM orders o
    JOIN order_details od
    ON o.order_id = od.order_id
    GROUP BY o.date
) AS daily_sales;
SELECT pt.name,
       SUM(od.quantity * p.price) AS revenue
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 3;
