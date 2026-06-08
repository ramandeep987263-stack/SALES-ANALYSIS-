

SELECT COUNT(*) AS total_orders
FROM orders;


-- 2. Total Order Lines

SELECT COUNT(*) AS total_order_lines
FROM order_details;


-- 3. Total Pizzas Sold

SELECT SUM(quantity) AS total_pizzas_sold
FROM order_details;



-- 4. Total Revenue

SELECT
    ROUND(SUM(od.quantity * p.price),2) AS total_revenue
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id;


-- 5. Average Order Value

SELECT
    ROUND(
        SUM(od.quantity * p.price) /
        COUNT(DISTINCT od.order_id),
        2
    ) AS avg_order_value
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id;



-- 6. Orders By Hour

SELECT
    HOUR(order_time) AS order_hour,
    COUNT(*) AS total_orders
FROM orders
GROUP BY order_hour
ORDER BY total_orders DESC;



-- 7. Top 10 Best Selling Pizzas

SELECT
    pt.name AS pizza_name,
    SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
JOIN pizza_types_fixedd pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity_sold DESC
LIMIT 10;



-- 8. Top 10 Revenue Generating Pizzas

SELECT
    pt.name AS pizza_name,
    ROUND(SUM(od.quantity * p.price),2) AS revenue
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
JOIN pizza_types_fixedd pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC
LIMIT 10;



-- 9. Revenue By Category

SELECT
    pt.category,
    ROUND(SUM(od.quantity * p.price),2) AS revenue
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
JOIN pizza_types_fixedd pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY revenue DESC;


-- 10. Revenue Percentage By Category

SELECT
    pt.category,
    ROUND(
        SUM(od.quantity * p.price) * 100 /
        SUM(SUM(od.quantity * p.price)) OVER (),
        2
    ) AS revenue_percentage
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
JOIN pizza_types_fixedd pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY revenue_percentage DESC;


-- 11. Orders By Day Of Week

SELECT
    DAYNAME(order_date) AS day_name,
    COUNT(order_id) AS total_orders
FROM orders
GROUP BY day_name
ORDER BY total_orders DESC;


-- 12. Revenue By Pizza Size

SELECT
    p.size,
    ROUND(SUM(od.quantity * p.price),2) AS revenue
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY revenue DESC;



-- 13. Quantity Sold By Pizza Size

SELECT
    p.size,
    SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_quantity_sold DESC;



-- 14. Top 5 Least Selling Pizzas

SELECT
    pt.name AS pizza_name,
    SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
JOIN pizza_types_fixedd pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity_sold ASC
LIMIT 5;


-- 15. Average Pizzas Sold Per Day

SELECT
    ROUND(
        SUM(quantity) /
        COUNT(DISTINCT o.order_date),
        2
    ) AS avg_pizzas_per_day
FROM order_details od
JOIN orders o
ON od.order_id = o.order_id;



-- 16. Daily Revenue Trend

SELECT
    o.order_date,
    ROUND(SUM(od.quantity * p.price),2) AS daily_revenue
FROM orders o
JOIN order_details od
ON o.order_id = od.order_id
JOIN pizzas p
ON od.pizza_id = p.pizza_id
GROUP BY o.order_date
ORDER BY o.order_date;



-- 17. Monthly Revenue Trend

SELECT
    MONTHNAME(o.order_date) AS month_name,
    ROUND(SUM(od.quantity * p.price),2) AS monthly_revenue
FROM orders o
JOIN order_details od
ON o.order_id = od.order_id
JOIN pizzas p
ON od.pizza_id = p.pizza_id
GROUP BY MONTHNAME(o.order_date)
ORDER BY monthly_revenue DESC;



-- 18. Category Wise Quantity Sold

SELECT
    pt.category,
    SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
JOIN pizza_types_fixedd pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_quantity_sold DESC;



-- 19. Top Pizzas By Category

SELECT
    pt.category,
    pt.name,
    SUM(od.quantity) AS total_quantity_sold
FROM order_details od
JOIN pizzas p
ON od.pizza_id = p.pizza_id
JOIN pizza_types_fixedd pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category, pt.name
ORDER BY pt.category, total_quantity_sold DESC;



-- 20. Highest Priced Pizza

SELECT
    pt.name,
    p.price
FROM pizzas p
JOIN pizza_types_fixedd pt
ON p.pizza_type_id = pt.pizza_type_id
ORDER BY p.price DESC
LIMIT 1;













