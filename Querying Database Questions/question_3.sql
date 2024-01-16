/* Which German store type had the highest revenue for 2022?*/

SELECT
    dim_store.store_type,
    SUM(orders.product_quantity * dim_product.sale_price) AS total_revenue
FROM orders
JOIN dim_product ON orders.product_code = dim_product.product_code
JOIN dim_store ON orders.store_code = dim_store.store_code
JOIN dim_date ON orders.order_date = dim_date.date
WHERE dim_date.year = 2022
    AND dim_store.country = 'Germany'
GROUP BY dim_store.store_type
ORDER BY total_revenue DESC

