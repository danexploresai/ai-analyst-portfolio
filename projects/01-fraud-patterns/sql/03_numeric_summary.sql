-- 03_numeric_summary.sql
-- Question: for the amount column and the four balance columns, what
-- are the min, max, mean, median and 99th percentile, and how many
-- values are negative, zero, or above 10 million?
-- Engine: SQLite (it has no MEDIAN function, so the median is found by
-- numbering the sorted values and taking the middle one or two).
-- Note: "above 10 million" is only a reporting line to show how long
-- the tail is. It is not a rule and nothing is filtered.
WITH long_format AS (
    -- Stack the five columns into one (column_name, val) list.
    SELECT 'amount' AS column_name, amount AS val FROM transactions
    UNION ALL SELECT 'oldbalanceOrg',  oldbalanceOrg  FROM transactions
    UNION ALL SELECT 'newbalanceOrig', newbalanceOrig FROM transactions
    UNION ALL SELECT 'oldbalanceDest', oldbalanceDest FROM transactions
    UNION ALL SELECT 'newbalanceDest', newbalanceDest FROM transactions
),
ranked AS (
    -- Number the values of each column from smallest to largest.
    SELECT
        column_name,
        val,
        ROW_NUMBER() OVER (PARTITION BY column_name ORDER BY val) AS rn,
        COUNT(*)     OVER (PARTITION BY column_name)              AS n
    FROM long_format
)
SELECT
    column_name,
    COUNT(*)                                                   AS value_count,
    MIN(val)                                                   AS min_value,
    MAX(val)                                                   AS max_value,
    ROUND(AVG(val), 2)                                         AS mean_value,
    -- Median: the middle value, or the average of the two middle values.
    ROUND(AVG(val) FILTER (WHERE rn IN ((n + 1) / 2, (n + 2) / 2)), 2) AS median_value,
    -- 99th percentile: the smallest value that 99% of rows are at or below.
    MIN(val) FILTER (WHERE rn * 100 >= n * 99)                 AS p99_value,
    SUM(val < 0)                                               AS negative_count,
    SUM(val = 0)                                               AS zero_count,
    SUM(val > 10000000)                                        AS above_10m_count
FROM ranked
GROUP BY column_name
ORDER BY CASE column_name
    WHEN 'amount' THEN 1 WHEN 'oldbalanceOrg' THEN 2 WHEN 'newbalanceOrig' THEN 3
    WHEN 'oldbalanceDest' THEN 4 ELSE 5 END;
