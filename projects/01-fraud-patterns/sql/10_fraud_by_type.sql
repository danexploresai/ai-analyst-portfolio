-- 10_fraud_by_type.sql
-- Question: which transaction types do the fraud rows fall in, and
-- what is the fraud rate for each type?
-- Fraud rate = fraud rows of the type / all rows of the type.
-- Share of all fraud = fraud rows of the type / all fraud rows.
-- Engine: SQLite.
SELECT
    type,
    COUNT(*)                                      AS all_rows,
    SUM(isFraud)                                  AS fraud_rows,
    ROUND(100.0 * SUM(isFraud) / COUNT(*), 4)     AS fraud_rate_pct,
    ROUND(100.0 * SUM(isFraud)
          / (SELECT SUM(isFraud) FROM transactions), 2) AS share_of_all_fraud_pct
FROM transactions
GROUP BY type
ORDER BY fraud_rows DESC, all_rows DESC;
