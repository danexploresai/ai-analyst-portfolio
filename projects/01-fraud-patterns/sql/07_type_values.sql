-- 07_type_values.sql
-- Question: what are all the values of the type column, exactly as
-- spelled in the file, and how many rows does each have?
-- (02_column_profile.sql only shows three examples per column.)
-- Engine: SQLite.
SELECT
    type,
    COUNT(*) AS row_count,
    (SELECT COUNT(*) FROM transactions) AS total_rows,
    ROUND(100.0 * COUNT(*) / (SELECT COUNT(*) FROM transactions), 2) AS pct_of_rows
FROM transactions
GROUP BY type
ORDER BY row_count DESC;
