-- =====================================================
-- Cheese Production Analysis
-- Data Cleaning & Preparation Script
-- =====================================================
-- This script prepares raw cheese production data
-- for analysis and visualization in Tableau.
--
-- Note:
-- Exploratory data analysis and intermediate validation
-- were performed prior to building this pipeline.
-- The validation queries included below are intended
-- to verify the integrity of the final dataset.
-- =====================================================


-- ====================================
-- 1. Create cleaned base table
-- ====================================

CREATE TABLE IF NOT EXISTS cheese_clean AS
SELECT
    year,
    period,
    geo_level,
    state_ansi,
    commodity_id,
    domain,
    CAST(REPLACE(value, ',', '') AS BIGINT) AS production_volume
FROM Cheese_production;


-- ====================================
-- 2. Create final analysis table
-- ====================================

DROP TABLE IF EXISTS cheese_analysis_clean;

CREATE TABLE cheese_analysis_clean AS
SELECT 
    c.year,
    c.period,
    c.geo_level,
    c.state_ansi,
    COALESCE(s.State, 'Other/Unknown States') AS state_name,
    c.commodity_id,
    c.domain,
    c.production_volume
FROM cheese_clean c
LEFT JOIN state_lookup s 
    ON c.state_ansi = s.State_ANSI
WHERE
    c.geo_level = 'STATE'
    AND c.domain = 'TOTAL'
    -- Exclude duplicate yearly records after 1990
    AND NOT (
        c.year >= 1990
        AND c.period = 'YEAR'
    );


-- ====================================
-- 3. Data validation checks
-- ====================================

-- Row count
SELECT COUNT(*) FROM cheese_analysis_clean;

-- Check dimensions
SELECT DISTINCT geo_level, domain
FROM cheese_analysis_clean;

-- Duplicate check (year, period, state)
SELECT 
    year, 
    period, 
    state_name, 
    COUNT(*) AS record_count
FROM cheese_analysis_clean
GROUP BY year, period, state_name
HAVING COUNT(*) > 1;

