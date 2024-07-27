-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT category, 
concat(ROUND((SUM(quantity*price) / (SELECT ROUND(SUM(quantity*price),2) AS total_revenue
FROM pizzas
JOIN order_details
	ON pizzas.pizza_id = order_details.pizza_id))*100, 2),"%")  as Percent 
FROM pizzas
JOIN pizza_types
	ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details
	ON pizzas.pizza_id = order_details.pizza_id
GROUP BY category;

-- Analyze the cumulative revenue generated over time.
SELECT order_date, 
SUM(revenue) OVER(ORDER BY order_date) AS cum_revenue
FROM (SELECT order_date, ROUND(SUM(quantity*price),2) AS revenue
FROM order_details
JOIN orders
	ON orders.order_id = order_details.order_id
JOIN pizzas
	ON pizzas.pizza_id = order_details.pizza_id
GROUP BY order_date
ORDER BY order_date) as revenue_per_day;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
SELECT category, name, revenue, rn
FROM (SELECT category, name, revenue,
RANK() OVER(PARTITION BY category ORDER BY revenue DESC) AS rn
FROM (SELECT category, name, SUM(quantity*price) as revenue 
FROM pizzas
JOIN pizza_types
	ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details
	ON pizzas.pizza_id = order_details.pizza_id
GROUP BY category,name) as a) as b
WHERE rn <=3;


-- Represent this SQL code using template PPTs from Canva
-- With Project Name + Description slide, About Me slide and slides with code and results
-- Download the file as .pdf on your desktop
-- Post this pdf on linkedIn and tag Ayushi Singh for review (optional)

-- On github
-- New repository -> Mention questions -> upload pdf and code files
