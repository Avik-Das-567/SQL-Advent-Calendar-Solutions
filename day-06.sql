-- SQL Advent Calendar - Day 6
-- Title: Ski Resort Snowfall Rankings
-- Difficulty: hard
--
-- Question:
-- Buddy is planning a winter getaway and wants to rank ski resorts by annual snowfall. Can you help him bucket these ski resorts into quartiles?
--
-- Buddy is planning a winter getaway and wants to rank ski resorts by annual snowfall. Can you help him bucket these ski resorts into quartiles?
--

-- Table Schema:
-- Table: resort_monthly_snowfall
--   resort_id: INT
--   resort_name: VARCHAR
--   snow_month: INT
--   snowfall_inches: DECIMAL
--

-- My Solution:

WITH yearly AS (
    SELECT
        resort_id,
        resort_name,
        SUM(snowfall_inches) AS total_snow
    FROM resort_monthly_snowfall
    GROUP BY resort_id, resort_name
),
ranked AS (
    SELECT
        resort_id,
        resort_name,
        total_snow,
        ROW_NUMBER() OVER (ORDER BY total_snow) AS rn,
        COUNT(*) OVER () AS total_resorts
    FROM yearly
)
SELECT
    resort_name,
    total_snow,
    CASE
        WHEN rn <= total_resorts * 0.25 THEN 1
        WHEN rn <= total_resorts * 0.50 THEN 2
        WHEN rn <= total_resorts * 0.75 THEN 3
        ELSE 4
    END AS snowfall_quartile
FROM ranked
ORDER BY snowfall_quartile, total_snow;
