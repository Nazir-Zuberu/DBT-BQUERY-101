with customers as (
    SELECT id,
           first_name,
           last_name
    FROM `dbt-tutorial`.jaffle_shop.customers

),

orders as(
    SELECT id,
           user_id,
           order_date,
           status
    FROM `dbt-tutorial`.jaffle_shop.orders
),

customer_orders as(
    SELECT
            user_id,
            min(order_date) as first_order,
            max(order_date) as most_recent_order,
            count(id) as number_of_orders
    FROM orders
    GROUP BY user_id
),

final as (
    SELECT
            customers.id,
            customers.first_name,
            customers.last_name,
            customer_orders.first_order,
            customer_orders.most_recent_order,
            customer_orders.number_of_orders
    FROM customers
    LEFT JOIN customer_orders
    ON customers.id = customer_orders.user_id
)

SELECT * from final