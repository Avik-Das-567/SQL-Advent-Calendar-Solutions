-- SQL Advent Calendar - Day 18
-- Title: 12 Days of Data - Progress Tracking
-- Difficulty: hard
--
-- Question:
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--
-- Over the 12 days of her data challenge, Data Dawn tracked her daily quiz scores across different subjects. Can you find each subject's first and last recorded score to see how much she improved?
--

-- Table Schema:
-- Table: daily_quiz_scores
--   subject: VARCHAR
--   quiz_date: DATE
--   score: INTEGER
--

-- My Solution:

SELECT
    subject,
    MIN(score) FILTER (WHERE quiz_date = first_date) AS first_score,
    MIN(score) FILTER (WHERE quiz_date = last_date) AS last_score
FROM (
    SELECT
        subject,
        quiz_date,
        score,
        MIN(quiz_date) OVER (PARTITION BY subject) AS first_date,
        MAX(quiz_date) OVER (PARTITION BY subject) AS last_date
    FROM daily_quiz_scores
)
GROUP BY subject;
