-- 06_label_balance.sql
-- Question: how many rows, and what percentage of all rows, have each
-- value of isFraud and of isFlaggedFraud, and how do the two flags
-- combine?
-- Engine: SQLite. Percentages are of all rows in the table.
SELECT
    'isFraud' AS label,
    CAST(isFraud AS TEXT) AS value,
    COUNT(*) AS row_count,
    (SELECT COUNT(*) FROM transactions) AS total_rows,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM transactions), 4) AS pct_of_rows
FROM transactions
GROUP BY isFraud

UNION ALL

SELECT
    'isFlaggedFraud',
    CAST(isFlaggedFraud AS TEXT),
    COUNT(*),
    (SELECT COUNT(*) FROM transactions),
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM transactions), 4)
FROM transactions
GROUP BY isFlaggedFraud

UNION ALL

SELECT
    'isFraud / isFlaggedFraud together',
    isFraud || ' / ' || isFlaggedFraud,
    COUNT(*),
    (SELECT COUNT(*) FROM transactions),
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM transactions), 4)
FROM transactions
GROUP BY isFraud, isFlaggedFraud;
