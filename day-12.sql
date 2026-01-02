-- SQL Advent Calendar - Day 12
-- Title: North Pole Network Most Active Users
-- Difficulty: hard
--
-- Question:
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--
-- The North Pole Network wants to see who's the most active in the holiday chat each day. Write a query to count how many messages each user sent, then find the most active user(s) each day. If multiple users tie for first place, return all of them.
--

-- Table Schema:
-- Table: npn_users
--   user_id: INT
--   user_name: VARCHAR
--
-- Table: npn_messages
--   message_id: INT
--   sender_id: INT
--   sent_at: TIMESTAMP
--

-- My Solution:

WITH counts AS (
    SELECT
        DATE(sent_at) AS message_date,
        sender_id,
        COUNT(*) AS cnt
    FROM npn_messages
    GROUP BY DATE(sent_at), sender_id
)
SELECT
    c.message_date,
    u.user_name,
    c.cnt AS message_count
FROM counts c
JOIN npn_users u
    ON c.sender_id = u.user_id
WHERE c.cnt = (
    SELECT MAX(cnt)
    FROM counts c2
    WHERE c2.message_date = c.message_date
)
ORDER BY c.message_date, u.user_name;
