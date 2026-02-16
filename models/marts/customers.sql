{{ config(materialized='table') }}

WITH customers AS (
    SELECT * FROM {{ ref('stg_customers') }}
),

orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

payments AS (
    SELECT * FROM {{ ref('stg_payments') }}
),

customer_orders AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        MIN(o.order_date) AS first_order,
        MAX(o.order_date) AS most_recent_order,
        COUNT(DISTINCT o.order_id) AS number_of_orders,
        COALESCE(SUM(p.amount), 0) AS customer_lifetime_value
    FROM customers c
    LEFT JOIN orders o
        ON c.customer_id = o.customer_id
    LEFT JOIN payments p
        ON o.order_id = p.order_id
    GROUP BY
        c.customer_id,
        c.first_name,
        c.last_name
)

SELECT * FROM customer_orders
