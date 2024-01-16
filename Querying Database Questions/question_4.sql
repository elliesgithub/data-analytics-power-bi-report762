/*Create a view where the rows are the store types and the columns are the total sales, percentage of total sales and the count of orders*/

SELECT
    dim_store.store_type,
    SUM(orders.product_quantity * dim_product.sale_price) AS total_sales,
    100 * SUM(orders.product_quantity * dim_product.sale_price) / SUM(SUM(orders.product_quantity * dim_product.sale_price)) OVER () AS percentage_of_total_sales,
    COUNT(*) AS order_count
FROM
    orders
JOIN
    dim_product ON orders.product_code = dim_product.product_code
JOIN
    dim_store ON orders.store_code = dim_store.store_code
GROUP BY
    dim_store.store_type;

