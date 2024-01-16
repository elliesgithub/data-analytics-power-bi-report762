/*Which month in 2022 has had the highest revenue?*/

SELECT
    dim_date.month_name,
    SUM(orders.product_quantity * dim_product.sale_price) AS total_revenue
FROM orders
JOIN dim_product ON orders.product_code = dim_product.product_code
JOIN dim_date ON orders.order_date = dim_date.date
WHERE dim_date.year = 2022
GROUP BY dim_date.month_name
ORDER BY total_revenue DESC
LIMIT 1;