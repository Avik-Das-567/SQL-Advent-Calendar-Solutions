-- SQL Advent Calendar - Day 15
-- Title: The Grinch's Mischief Tracker
-- Difficulty: hard
--
-- Question:
-- The Grinch is tracking his daily mischief scores to see how his behavior changes over time. Can you find how many points his score increased or decreased each day compared to the previous day?
--
-- The Grinch is tracking his daily mischief scores to see how his behavior changes over time. Can you find how many points his score increased or decreased each day compared to the previous day?
--

-- Table Schema:
-- Table: grinch_mischief_log
--   log_date: DATE
--   mischief_score: INTEGER
--

-- My Solution:

SELECT
    curr.log_date,
    curr.mischief_score,
    curr.mischief_score - prev.mischief_score AS daily_change
FROM grinch_mischief_log AS curr
LEFT JOIN grinch_mischief_log AS prev
    ON prev.log_date = date(curr.log_date, '-1 day')
ORDER BY curr.log_date;
