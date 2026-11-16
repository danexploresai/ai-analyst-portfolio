-- 05_keys_duplicates.sql
-- Question: is there a column, or a set of columns, that uniquely
-- identifies a row, and how many rows are exact duplicates of another
-- row? A candidate is a key only if its distinct count equals the
-- total row count.
-- Engine: SQLite.
SELECT
    (SELECT COUNT(*) FROM transactions) AS total_rows,
    -- Rows that are identical in all 11 columns collapse to one here.
    (SELECT COUNT(*) FROM (SELECT DISTINCT * FROM transactions)) AS distinct_full_rows,
    (SELECT COUNT(*) FROM transactions)
      - (SELECT COUNT(*) FROM (SELECT DISTINCT * FROM transactions)) AS exact_duplicate_rows,
    -- Candidate keys, from narrowest to widest.
    (SELECT COUNT(DISTINCT nameOrig) FROM transactions) AS distinct_nameOrig,
    (SELECT COUNT(DISTINCT nameDest) FROM transactions) AS distinct_nameDest,
    (SELECT COUNT(*) FROM (SELECT DISTINCT step, nameOrig FROM transactions)) AS distinct_step_nameOrig,
    (SELECT COUNT(*) FROM (SELECT DISTINCT nameOrig, nameDest FROM transactions)) AS distinct_nameOrig_nameDest,
    (SELECT COUNT(*) FROM (SELECT DISTINCT step, nameOrig, nameDest FROM transactions)) AS distinct_step_nameOrig_nameDest,
    (SELECT COUNT(*) FROM (SELECT DISTINCT step, type, amount, nameOrig, nameDest FROM transactions)) AS distinct_step_type_amount_nameOrig_nameDest;
