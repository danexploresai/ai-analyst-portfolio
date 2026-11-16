-- 08_fraud_by_half.sql
-- Question: how many rows and how many fraud rows fall in each of the
-- two time periods (steps 1 to 372 and steps 373 to 743), and what is
-- the fraud rate in each?
-- Fraud rate = fraud rows in the period / all rows in the period.
-- Engine: SQLite.
SELECT
    CASE WHEN step <= 372 THEN 'steps 1 to 372'
         ELSE 'steps 373 to 743' END              AS period,
    MIN(step)                                     AS first_step_in_period,
    MAX(step)                                     AS last_step_in_period,
    COUNT(*)                                      AS all_rows,
    SUM(isFraud)                                  AS fraud_rows,
    ROUND(100.0 * SUM(isFraud) / COUNT(*), 4)     AS fraud_rate_pct
FROM transactions
GROUP BY period
ORDER BY first_step_in_period;
