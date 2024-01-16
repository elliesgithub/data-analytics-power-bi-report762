/*Which product category generated the most profit for the "Wiltshire, UK" region in 2021?*/

SELECT 
     dim_product.category,
     SUM((orders.product_quantity * dim_product.sale_price) - dim_product.cost_price) AS profit
FROM orders
JOIN dim_product ON orders.product_code = dim_product.product_code
JOIN dim_store ON orders.store_code = dim_store.store_code
JOIN dim_date ON orders.order_date = dim_date.date
WHERE dim_date.year = 2021
     AND dim_store.full_region = 'Wiltshire, UK' 
GROUP BY dim_product.category
ORDER BY profit DESC
LIMIT 1;

 