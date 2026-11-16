-- 04_step_coverage.sql
-- Question: PaySim has no calendar dates, only "step" (1 step = 1 hour).
-- What are the earliest and latest steps, are any of the 744 documented
-- steps missing, and how uneven is the number of rows per step?
-- Engine: SQLite.
WITH RECURSIVE expected(step) AS (
    -- The 744 steps the PaySim documentation says should exist.
    SELECT 1
    UNION ALL
    SELECT step + 1 FROM expected WHERE step < 744
),
per_step AS (
    -- Rows actually present for each step.
    SELECT step, COUNT(*) AS row_count
    FROM transactions
    GROUP BY step
)
SELECT
    (SELECT MIN(step) FROM per_step)                             AS earliest_step,
    (SELECT MAX(step) FROM per_step)                             AS latest_step,
    (SELECT COUNT(*) FROM per_step)                              AS distinct_steps,
    (SELECT COUNT(*) FROM per_step WHERE step < 1 OR step > 744) AS steps_outside_1_to_744,
    (SELECT COUNT(*) FROM expected e
       LEFT JOIN per_step p ON p.step = e.step
      WHERE p.step IS NULL)                                      AS missing_steps,
    (SELECT GROUP_CONCAT(e.step, ', ') FROM expected e
       LEFT JOIN per_step p ON p.step = e.step
      WHERE p.step IS NULL)                                      AS missing_step_list,
    (SELECT MIN(row_count) FROM per_step)                        AS fewest_rows_in_a_step,
    (SELECT MAX(row_count) FROM per_step)                        AS most_rows_in_a_step,
    (SELECT COUNT(*) FROM per_step WHERE row_count < 100)        AS steps_with_under_100_rows,
    (SELECT SUM(row_count) FROM per_step WHERE step <= 372)      AS rows_in_steps_1_to_372,
    (SELECT SUM(row_count) FROM per_step WHERE step >= 373)      AS rows_in_steps_373_to_744;
