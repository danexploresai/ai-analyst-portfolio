-- 11_fraud_by_type_by_half.sql
-- Question: does the fraud-by-type picture hold in both time periods?
-- For each type in each period: all rows, fraud rows, and fraud rate.
-- Fraud rate = fraud rows of the type in the period / all rows of the
-- type in the period.
-- Engine: SQLite.
SELECT
    type,
    CASE WHEN step <= 372 THEN 'steps 1 to 372'
         ELSE 'steps 373 to 743' END              AS period,
    COUNT(*)                                      AS all_rows,
    SUM(isFraud)                                  AS fraud_rows,
    ROUND(100.0 * SUM(isFraud) / COUNT(*), 4)     AS fraud_rate_pct
FROM transactions
GROUP BY type, period
ORDER BY type, period;
