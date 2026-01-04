-- =====================================================
-- Exploratory Data Analysis & Validation
-- =====================================================
-- This script contains the exploratory queries,
-- validation checks, and analytical steps used
-- to understand data quality and answer the
-- project’s analytical questions.
--
-- Note:
-- This file is NOT intended to be a linear pipeline.
-- Queries were executed iteratively during analysis
-- and are preserved here to document analytical
-- reasoning and data validation.
-- =====================================================

-- ====================================
-- Q1. Total cheese production over time
-- ====================================

SELECT 
	year,
	SUM(production_volume) AS total_production
FROM cheese_analysis_clean
WHERE 
	(year < 1990 AND period = 'YEAR')
	OR
	(year >= 1990 AND period <> 'YEAR')
GROUP BY year
ORDER BY year;

SELECT 
	SUM(production_volume) AS total_production
FROM cheese_analysis_clean
WHERE 
	(year < 1990 AND period = 'YEAR')
	OR
	(year >= 1990 AND period <> 'YEAR')

-- Years with zero production (sanity check)

SELECT
    year,
    SUM(production_volume) AS total_production
FROM cheese_analysis_clean
WHERE 
	(year < 1990 AND period = 'YEAR')
	OR
	(year >= 1990 AND period <> 'YEAR')
GROUP BY year
HAVING SUM(production_volume) = 0
ORDER BY year;

-- YoY growth (corrected)

SELECT
    year,
    SUM(production_volume) AS total_production,
    LAG(SUM(production_volume)) OVER (ORDER BY year) AS prev_year_production,
    ROUND(
        (
            SUM(production_volume)
            - LAG(SUM(production_volume)) OVER (ORDER BY year)
        ) * 100.0
        / LAG(SUM(production_volume)) OVER (ORDER BY year),
        2
    ) AS yoy_growth_pct
FROM cheese_analysis_clean
WHERE 
	(year < 1990 AND period = 'YEAR')
	OR
	(year >= 1990 AND period <> 'YEAR')
GROUP BY year
ORDER BY year;


-- ====================================
-- Q2. Top cheese producing states
-- ====================================

SELECT 

    COALESCE(s.State, 'Unknown States') AS state_name,
    SUM(c.production_volume) AS state_production
FROM cheese_analysis_clean c
LEFT JOIN state_lookup s 
    ON c.state_ansi = s.State_ANSI
WHERE 
    (c.year < 1990 AND c.period = 'YEAR')
    OR
    (c.year >= 1990 AND c.period <> 'YEAR')
GROUP BY COALESCE(s.State, 'Other/Unknown States')
ORDER BY state_production DESC
LIMIT 10;

SELECT
    c.state_ansi
FROM cheese_analysis_clean c
LEFT JOIN state_lookup s
    ON c.state_ansi = s.State_ANSI
WHERE s.State_ANSI IS NULL;

-- ====================================
-- Q3. Total production from top states
-- ====================================

--Total cheese production (all states)

SELECT 
	SUM(production_volume) AS total_production
FROM cheese_analysis_clean
WHERE 
	(year < 1990 AND period = 'YEAR')
	OR
	(year >= 1990 AND period <> 'YEAR');

-- Total production by state

SELECT
 
  -- If the state is NULL in the lookup table, it is assigned as 'Other/Unknown States'.
    COALESCE(s.State, 'Other/Unknown States') AS state_name,
    SUM(c.production_volume) AS state_production
FROM cheese_analysis_clean c
LEFT JOIN state_lookup s
    ON c.state_ansi = s.State_ANSI
WHERE 
    (c.year < 1990 AND c.period = 'YEAR')
    OR
    (c.year >= 1990 AND c.period <> 'YEAR')
GROUP BY COALESCE(s.State, 'Other/Unknown States')
ORDER BY state_production DESC;

--% of production

WITH state_totals AS (
    SELECT 
        COALESCE(s.State, 'Other/Unknown States') AS state_name,
        SUM(c.production_volume) AS state_production
    FROM cheese_analysis_clean c
    LEFT JOIN state_lookup s
        ON c.state_ansi = s.State_ANSI
    WHERE 
        (c.year < 1990 AND c.period = 'YEAR')
        OR
        (c.year >= 1990 AND c.period <> 'YEAR')
    GROUP BY COALESCE(s.State, 'Other/Unknown States')
),
total_production_consolidated AS (
    SELECT
        SUM(state_production) AS total_production
    FROM state_totals
)
SELECT 
    st.state_name,
    st.state_production,
    ROUND(
        st.state_production * 100.0 / tp.total_production, 2
    ) AS pct_of_total
FROM state_totals st
CROSS JOIN total_production_consolidated tp
ORDER BY st.state_production DESC
LIMIT 5;

---Before Q4

SELECT DISTINCT period
FROM cheese_analysis_clean
ORDER BY period;

-- ====================================
-- Q4. Average cheese production by month (seasonality)
-- ====================================

-- seasonality only valid post-1990 (monthly data)

SELECT
    period,
    CASE period
        WHEN 'JAN' THEN 1
        WHEN 'FEB' THEN 2
        WHEN 'MAR' THEN 3
        WHEN 'APR' THEN 4
        WHEN 'MAY' THEN 5
        WHEN 'JUN' THEN 6
        WHEN 'JUL' THEN 7
        WHEN 'AUG' THEN 8
        WHEN 'SEP' THEN 9
        WHEN 'OCT' THEN 10
        WHEN 'NOV' THEN 11
        WHEN 'DEC' THEN 12
    END AS month_number,
ROUND(AVG(production_volume), 2) AS avg_monthly_production
FROM cheese_analysis_clean
WHERE 
    year >= 1990
    AND period <> 'YEAR'
GROUP BY period, month_number
ORDER BY month_number;

-- Monthly production by year (monthly only)

SELECT
    year,
    period,
    SUM(production_volume) AS monthly_production
FROM cheese_analysis_clean
WHERE 
	year >= 1990
	AND period <> 'YEAR'
GROUP BY year, period
ORDER BY year, period;

-- ====================================
-- Data ready for visualization
-- ====================================
