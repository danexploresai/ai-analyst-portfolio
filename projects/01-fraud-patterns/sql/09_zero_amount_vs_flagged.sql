-- 09_zero_amount_vs_flagged.sql
-- Question: are the 16 rows with an amount of zero the same rows as
-- the 16 rows with isFlaggedFraud = 1?
-- Only rows that are zero-amount, flagged, or both are kept, and they
-- are counted by combination. If the two sets were the same rows,
-- there would be one line with amount_is_zero = 1 and
-- isFlaggedFraud = 1.
-- Engine: SQLite.
SELECT
    (amount = 0)    AS amount_is_zero,
    isFlaggedFraud,
    isFraud,
    COUNT(*)        AS row_count
FROM transactions
WHERE amount = 0
   OR isFlaggedFraud = 1
GROUP BY amount_is_zero, isFlaggedFraud, isFraud
ORDER BY amount_is_zero DESC, isFlaggedFraud DESC, isFraud DESC;
