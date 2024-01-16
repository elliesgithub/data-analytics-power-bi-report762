/*How many staff are there in all of the UK stores?*/

SELECT COUNT(*) AS total_staff_uk
FROM dim_store
WHERE country = 'UK';