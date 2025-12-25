DROP TABLE IF EXISTS retail_sales;
CREATE TABLE retail_sales(
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id	INT,
	gender VARCHAR(20),
	age INT,
	category VARCHAR(20),
	quantity INT,
	price_per_unit INT,
	cogs FLOAT,
	total_sale INT
);

--=======================================================
--				VIEWS FOR POWER BI
--=======================================================
-- Q9.
-- Create age buckets:
-- 18–25
-- 26–35
-- 36–45
-- 46–60
-- 60+
-- Then analyze:
-- Revenue
-- Profit per age group
CREATE VIEW vw_age_bucket_analysis AS
SELECT
	CASE
	WHEN age BETWEEN 18 AND 25 THEN '18-25'
	WHEN age BETWEEN 26 AND 35 THEN '26-35'
	WHEN age BETWEEN 36 AND 45 THEN '36-45'
	WHEN age BETWEEN 46 AND 60 THEN '46-60'
	ELSE '60+' END AS age_bucket,
	COUNT(DISTINCT transactions_id) AS total_transactions,
    SUM(quantity) AS total_units,
	SUM(total_sale) AS total_revenue,
	ROUND(
	SUM(total_sale - cogs)::numeric,2) AS total_profit
	FROM retail_sales
	GROUP BY age_bucket
	ORDER BY age_bucket
	;

-- ⿨ Gender & Category Analysis
-- Q8.
-- Revenue by gender for each category
-- Which gender prefers which category?
CREATE VIEW vw_gender_category_sales AS
SELECT 
	category,
	COUNT(DISTINCT transactions_id) AS total_transactions,
    SUM(quantity) AS total_units,
	gender,
	SUM(total_sale) AS total_revenue
	FROM retail_Sales
	GROUP BY category,gender
	ORDER BY category,total_revenue DESC;


-- ⿧ Peak Sales Time Analysis
-- Q7.
-- Which hour of the day generates the highest revenue?
-- Are there any hours with low or negative profit?
CREATE VIEW vw_hourly_sales AS
SELECT
	EXTRACT(HOUR FROM sale_time) AS sale_hours,
 	COUNT(DISTINCT transactions_id) AS total_transactions,
    SUM(quantity) AS total_units,
		SUM(total_sale) AS total_revenue,
		ROUND(
		SUM(total_sale - cogs)::numeric,2) AS total_profit,
	 CASE
        WHEN SUM(total_sale - cogs) <= 0 THEN 'Loss Hour'
        ELSE 'Profit Hour'
    END AS hour_type
	FROM retail_sales
	GROUP BY sale_hours
	ORDER BY total_revenue DESC;


-- Time-Based Sales Analysis
-- Q6.
-- Month-wise revenue and profit trend
-- Identify the best month and worst month
CREATE VIEW vw_monthly_sales AS
SELECT 
	month,
	COUNT(DISTINCT transactions_id) AS total_transactions,
    SUM(quantity) AS total_units,
	SUM(total_sale) AS total_revenue,
	ROUND(
	SUM(total_sale - cogs)::numeric,2) AS total_profit
FROM(
	SELECT 
	transactions_id,
	quantity,
	DATE_TRUNC('month',sale_date) AS month,
	total_sale,
	cogs
	FROM retail_sales
) t
GROUP BY month
ORDER BY month;

--2️⃣ Category Performance
-- Q2. For each product category, calculate:
-- Total Revenue
-- Total Profit
-- Profit Margin (%)
CREATE VIEW vw_category_performance AS
SELECT 
	category,
	 COUNT(DISTINCT transactions_id) AS total_transactions,
    SUM(quantity) AS total_units,
	SUM(total_sale) AS total_revenue,
	ROUND(
	(SUM(total_sale) - SUM(cogs))::numeric,2) AS total_profit,
    ROUND(
	CASE WHEN SUM(total_Sale)= 0 THEN 0
	ELSE
         ((SUM(total_sale) - SUM(cogs)) / SUM(total_sale))::numeric * 100 END,
            2
        )
     profit_margin_percent
FROM retail_sales
GROUP BY category
;

--=======================================================
--			ADHOC / KPI QUERIES (NO VIEW)
--=======================================================
-- DATA ALREADY CLEAND THROUGH PYTHON.
SELECT * FROM retail_sales;

-- 1️⃣ Overall Business Performance
-- Q1. What are the:
-- Total Revenue
-- Total COGS
-- Total Profit
-- Profit Margin (%)



SELECT 
    SUM(total_sale) AS total_revenue,
    ROUND(
	SUM(cogs) ::numeric,2) AS total_cogs,
	ROUND(
    (SUM(total_sale) - SUM(cogs))::numeric,2) AS total_profit,
    ROUND(
            ((SUM(total_sale) - SUM(cogs)) / SUM(total_sale))::numeric * 100,
            2
        )
     profit_margin_percent
FROM retail_sales;


-- 3️⃣ Best & Worst Categories
-- Q3.
-- Top 3 categories by total profit
-- Bottom 3 categories by total profit

WITH category_profit AS(
SELECT 
	category,
	ROUND(
	(SUM(total_sale)-SUM(cogs))::numeric,2) AS total_profit
FROM retail_Sales
GROUP BY category
)

--- TOP 3 CATEGORIES BY PROFIT
SELECT *
FROM category_profit
ORDER BY total_profit DESC
LIMIT 3;

-- BOTTOM 3 CATEGORIES BY PROFIT
WITH category_profit AS(
SELECT 
	category,
	ROUND(
	(SUM(total_sale)-SUM(cogs))::numeric,2) AS total_profit
FROM retail_Sales
GROUP BY category
)

SELECT *
FROM category_profit
ORDER BY total_profit ASC 
LIMIT 3;


-- 4️⃣ Customer Behavior (Retention)
-- Q4. What percentage of customers are repeat customers?
-- (Hint: same customer_id appearing multiple times)

WITH customer_orders AS(
SELECT
	customer_id,
	COUNT(*) AS total_orders
	FROM retail_sales
	GROUP BY customer_id
)

SELECT 
	COUNT(CASE WHEN total_orders>1 THEN 1 END) AS repeat_customers,
	COUNT(*) AS total_customers,
	
	ROUND(
	COUNT(CASE WHEN total_orders>1 THEN 1 END ) *100.0/COUNT(*),2 
	) AS repeat_customer_percentage
FROM customer_orders;


-- 5️⃣ High-Value Customers
-- Q5. Identify the Top 10 customers based on:
-- Total Revenue
-- Total Profit

SELECT
	customer_id,
	SUM(total_sale) As total_revenue,
	(SUM(total_sale)-SUM(cogs)) AS total_profit
	FROM retail_sales
	GROUP BY customer_id
	ORDER BY total_profit DESC
	LIMIT 10;

SELECT
	customer_id,
	SUM(total_sale) As total_revenue,
	(SUM(total_sale)-SUM(cogs)) AS total_profit
	FROM retail_sales
	GROUP BY customer_id
	ORDER BY total_revenue DESC
	LIMIT 10;


-- BEST AND WORST MONTH
--- BEST MONTH
SELECT 
	month,
	SUM(total_sale) AS total_revenue,
	SUM(total_sale - cogs) AS total_profit
FROM(
	SELECT 
	DATE_TRUNC('month',sale_date) AS month,
	total_sale,
	cogs
FROM retail_sales
) t
GROUP BY month
ORDER BY total_revenue DESC 
LIMIT 1
;
-- WORST MONTH
SELECT 
	month,
	SUM(total_sale) AS total_revenue,
	SUM(total_sale - cogs) AS total_profit
FROM(
	SELECT 
	DATE_TRUNC('month',sale_date) AS month,
	total_sale,
	cogs
FROM retail_sales
) t
GROUP BY month
ORDER BY total_revenue ASC 
LIMIT 1
;




-- Which gender prefers which category?
WITH gender_category_sales AS(
	SELECT 
	gender,
	category,
	SUM(total_sale) AS total_revenue
	FROM retail_sales
	GROUP BY gender,category

),
ranked_categories AS(
SELECT
	gender,
	category,
	total_revenue,
	RANK() OVER(PARTITION BY gender ORDER BY total_revenue DESC) AS rnk
	FROM gender_category_sales
) 
SELECT 
	gender,
	category,
	category AS preferred_category,
	total_revenue
	FROM ranked_categories
	WHERE rnk=1;

