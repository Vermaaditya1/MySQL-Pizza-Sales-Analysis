-- INTERMEDIATE

-- Join the necessary tables to find the total quantity of each pizza category ordered.

select pizza_types.category, sum(order_details.quantity) as qt
from pizzas join pizza_types 
on pizzas.pizza_type_id = pizza_types.pizza_type_id
join order_details on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.category order by qt desc;

-- Determine the distribution of orders by hour of the day.

select hour(order_time) as hr, count(order_id) as total_orders from orders 
group by hr;

-- Join relevant tables to find the category-wise distribution of pizzas.

select category, count(name) from pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

select round(avg(qt),2) as avg_pizza_per_day from
(select orders.order_date, sum(order_details.quantity) as qt
from orders join order_details 
on orders.order_id = order_details.order_id
group by orders.order_date) as order_qt;

-- Determine the top 3 most ordered pizza types based on revenue.

select pizza_types.name,
sum(order_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name
order by revenue desc limit 3

