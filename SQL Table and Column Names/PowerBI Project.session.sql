SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' AND table_type = 'BASE TABLE';

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'orders' AND table_schema = 'public';

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'test_store_overviews' AND table_schema = 'public';

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'dim_customer' AND table_schema = 'public';

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'country_region' AND table_schema = 'public';

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'my_store_overviews' AND table_schema = 'public';

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'dim_date' AND table_schema = 'public';

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'dim_product' AND table_schema = 'public';

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'foreview' AND table_schema = 'public';

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'new_store_overview' AND table_schema = 'public';

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'test_store_overviews_2' AND table_schema = 'public';

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'dim_store' AND table_schema = 'public';

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'my_store_overviewsnews' AND table_schema = 'public';

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'my_store_overviews_2' AND table_schema = 'public';

SELECT column_name 
FROM information_schema.columns 
WHERE table_name = 'forquerying2' AND table_schema = 'public';

