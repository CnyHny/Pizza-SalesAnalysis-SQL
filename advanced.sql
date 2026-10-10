USE pizza_sales;
SELECT 
    pt.name,
    SUM(od.quantity * p.price) AS revenue,
    ROUND(
        SUM(od.quantity * p.price) * 100 /
        (SELECT SUM(od2.quantity * p2.price)
         FROM order_details od2
         JOIN pizzas p2
         ON od2.pizza_id = p2.pizza_id),
        2
    ) AS revenue_percentage
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
JOIN pizza_types pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue_percentage DESC;

SELECT 
    date,
    daily_revenue,
    SUM(daily_revenue) OVER (
        ORDER BY date
    ) AS cumulative_revenue
FROM (
    SELECT 
        o.date,
        SUM(od.quantity * p.price) AS daily_revenue
    FROM orders o
    JOIN order_details od
    ON o.order_id = od.order_id
    JOIN pizzas p
    ON od.pizza_id = p.pizza_id
    GROUP BY o.date
) AS daily_sales
ORDER BY date;

WITH pizza_revenue AS (
    SELECT 
        pt.category,
        pt.name,
        SUM(od.quantity * p.price) AS revenue
    FROM order_details od
    JOIN pizzas p
    ON od.pizza_id = p.pizza_id
    JOIN pizza_types pt
    ON p.pizza_type_id = pt.pizza_type_id
    GROUP BY pt.category, pt.name
),
ranked_pizzas AS (
    SELECT *,
           RANK() OVER (
               PARTITION BY category
               ORDER BY revenue DESC
           ) AS ranking
    FROM pizza_revenue
)
SELECT category, name, revenue
FROM ranked_pizzas
WHERE ranking <= 3
ORDER BY category, revenue DESC;
