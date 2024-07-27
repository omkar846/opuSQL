-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT category, SUM(quantity) AS total_sales
FROM pizzas
JOIN pizza_types
	ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details
	ON pizzas.pizza_id = order_details.pizza_id
GROUP BY category;

-- Determine the distribution of orders by hour of the day.
SELECT HOUR(order_time) AS hour, COUNT(order_id) AS order_count
FROM orders
GROUP BY hour
ORDER BY order_count DESC;

-- Join relevant tables to find the category-wise distribution of pizzas.
SELECT category, COUNT(name)
FROM pizza_types
GROUP BY category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT ROUND(AVG(quantity), 1)
FROM (SELECT order_date, SUM(quantity) AS quantity
FROM orders
JOIN order_details
	ON order_details.order_id = orders.order_id
GROUP BY order_date) AS daily_orders;

-- Determine the top 3 most ordered pizza types based on revenue.
SELECT name, SUM(price*quantity) AS revenue
FROM pizzas
JOIN pizza_types
	ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details
	ON pizzas.pizza_id = order_details.pizza_id
GROUP BY name
ORDER BY revenue DESC
LIMIT 3;