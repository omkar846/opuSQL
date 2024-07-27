-- Retrieve the total number of orders placed.
SELECT COUNT(*) AS total_orders
FROM pizzabox.orders;

-- Calculate the total revenue generated from pizza sales.
SELECT ROUND(SUM(quantity*price),2) AS total_revenue
FROM pizzas
JOIN order_details
	ON pizzas.pizza_id = order_details.pizza_id;

-- Identify the highest-priced pizza.
SELECT name, price
FROM pizzabox.pizzas
JOIN pizza_types
	ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
SELECT size, COUNT(size) AS No_of_orders
FROM pizzas
JOIN order_details
	ON pizzas.pizza_id = order_details.pizza_id
GROUP BY size
ORDER BY No_of_orders DESC
LIMIT 1;

-- List the top 5 most ordered pizza types along with their quantities.
 SELECT name, SUM(quantity) AS total_sales
 FROM pizzas
 JOIN order_details
	ON pizzas.pizza_id = order_details.pizza_id
 JOIN pizza_types
	ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY name
ORDER BY total_sales DESC
LIMIT 5; 
