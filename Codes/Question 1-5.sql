-- Retrieve the total number of orders placed.
Select count(*) from orders;

-- Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM((order_details.quantity * pizzas.price)),
            2) AS revenue
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;



-- Identify the highest-priced pizza with name. 
select pizzas.price from pizzas order by price desc limit 1; 	-- without name

SELECT 														-- With name 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Identify the most common pizza size ordered.
select quantity, count(order_details_id) from order_details group by quantity;

select pizzas.size, count(order_details.order_id) as order_count
from order_details join pizzas
on order_details.pizza_id = pizzas.pizza_id
group by size order by order_count desc;         		-- Large pizza is the most order pizza quantity

-- List the top 5 most ordered pizza types along with their quantities.
select pizza_types.name, sum(order_details.quantity) as qt
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.name order by qt desc limit 5;