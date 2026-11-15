SELECT 
        transaction_date,
        YEAR(transaction_date) AS year,
        MONTHNAME(transaction_date) AS month_name, 
        MONTH(transaction_date) AS month_number, 
        DATE_FORMAT(transaction_date, 'yyyy-MMM') AS month_id,
        DAYNAME(transaction_date) AS day_name, 
        DAYOFWEEK(transaction_date) AS day_number,
        product_category,
        product_type,
        product_detail,
        store_location,
        CASE 
            WHEN transaction_time BETWEEN '06:00:00' AND '08:59:59' THEN 'Early Morning'
            WHEN transaction_time BETWEEN '09:00:00' AND '11:59:59' THEN 'Late Morning'
            WHEN transaction_time BETWEEN '12:00:00' AND '14:59:59' THEN 'Early Afternoon'
            WHEN transaction_time BETWEEN '15:00:00' AND '17:59:59' THEN 'Late Afternoon'
            ELSE 'Evening'
        END AS time_bucket,
        SUM(transaction_qty * CAST(REPLACE(unit_price, ',','.') AS DECIMAL(10,2))) AS total_revenue,
        SUM(transaction_qty) AS unit_sold,
        COUNT(transaction_id) AS total_transaction
FROM brightlearn.coffee_shop.coffee_shop_sales
GROUP BY ALL;
