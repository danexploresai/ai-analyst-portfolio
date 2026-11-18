-- 12_review_rule_transfer_cashout.sql
-- Question: if analysts reviewed only TRANSFER and CASH_OUT
-- transactions, what share of all transactions would they review, and
-- what share of all fraud would that review cover? Shown for all steps
-- and for each time period (steps 1 to 372 and steps 373 to 743).
-- Share of rows  = rows in the group / all rows in the same period.
-- Share of fraud = fraud rows in the group / all fraud rows in the same period.
-- Engine: SQLite.
WITH labelled AS (
    SELECT
        CASE WHEN type IN ('TRANSFER', 'CASH_OUT') THEN 'TRANSFER or CASH_OUT'
             ELSE 'all other types' END            AS rule_group,
        CASE WHEN step <= 372 THEN 'steps 1 to 372'
             ELSE 'steps 373 to 743' END           AS period,
        isFraud
    FROM transactions
),
both_levels AS (
    SELECT rule_group, 'all steps' AS period, isFraud FROM labelled
    UNION ALL
    SELECT rule_group, period, isFraud FROM labelled
)
SELECT
    period,
    rule_group,
    COUNT(*)                                                  AS all_rows,
    SUM(isFraud)                                              AS fraud_rows,
    ROUND(100.0 * COUNT(*)
          / SUM(COUNT(*)) OVER (PARTITION BY period), 2)      AS share_of_rows_pct,
    ROUND(100.0 * SUM(isFraud)
          / SUM(SUM(isFraud)) OVER (PARTITION BY period), 2)  AS share_of_fraud_pct
FROM both_levels
GROUP BY period, rule_group
ORDER BY period, rule_group = 'all other types';
