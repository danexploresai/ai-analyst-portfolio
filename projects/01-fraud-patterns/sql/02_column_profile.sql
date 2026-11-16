-- 02_column_profile.sql
-- Question: for each column, what is its stored data type, how many
-- values are null or empty, how many distinct values are there, and
-- what do three example values look like?
-- Engine: SQLite. The same block is repeated once per column.
-- Examples are the first three distinct values SQLite finds; they are
-- illustrations, not a random sample.
SELECT
    1 AS position,
    'step' AS column_name,
    (SELECT GROUP_CONCAT(t, ', ') FROM (SELECT DISTINCT TYPEOF(step) AS t FROM transactions)) AS stored_type,
    (SELECT COUNT(*) FROM transactions WHERE step IS NULL) AS null_count,
    (SELECT COUNT(*) FROM transactions WHERE step = '') AS empty_text_count,
    (SELECT COUNT(DISTINCT step) FROM transactions) AS distinct_count,
    (SELECT GROUP_CONCAT(v, ' | ') FROM (SELECT DISTINCT step AS v FROM transactions LIMIT 3)) AS three_examples
UNION ALL
SELECT
    2 AS position,
    'type' AS column_name,
    (SELECT GROUP_CONCAT(t, ', ') FROM (SELECT DISTINCT TYPEOF(type) AS t FROM transactions)) AS stored_type,
    (SELECT COUNT(*) FROM transactions WHERE type IS NULL) AS null_count,
    (SELECT COUNT(*) FROM transactions WHERE type = '') AS empty_text_count,
    (SELECT COUNT(DISTINCT type) FROM transactions) AS distinct_count,
    (SELECT GROUP_CONCAT(v, ' | ') FROM (SELECT DISTINCT type AS v FROM transactions LIMIT 3)) AS three_examples
UNION ALL
SELECT
    3 AS position,
    'amount' AS column_name,
    (SELECT GROUP_CONCAT(t, ', ') FROM (SELECT DISTINCT TYPEOF(amount) AS t FROM transactions)) AS stored_type,
    (SELECT COUNT(*) FROM transactions WHERE amount IS NULL) AS null_count,
    (SELECT COUNT(*) FROM transactions WHERE amount = '') AS empty_text_count,
    (SELECT COUNT(DISTINCT amount) FROM transactions) AS distinct_count,
    (SELECT GROUP_CONCAT(v, ' | ') FROM (SELECT DISTINCT amount AS v FROM transactions LIMIT 3)) AS three_examples
UNION ALL
SELECT
    4 AS position,
    'nameOrig' AS column_name,
    (SELECT GROUP_CONCAT(t, ', ') FROM (SELECT DISTINCT TYPEOF(nameOrig) AS t FROM transactions)) AS stored_type,
    (SELECT COUNT(*) FROM transactions WHERE nameOrig IS NULL) AS null_count,
    (SELECT COUNT(*) FROM transactions WHERE nameOrig = '') AS empty_text_count,
    (SELECT COUNT(DISTINCT nameOrig) FROM transactions) AS distinct_count,
    (SELECT GROUP_CONCAT(v, ' | ') FROM (SELECT DISTINCT nameOrig AS v FROM transactions LIMIT 3)) AS three_examples
UNION ALL
SELECT
    5 AS position,
    'oldbalanceOrg' AS column_name,
    (SELECT GROUP_CONCAT(t, ', ') FROM (SELECT DISTINCT TYPEOF(oldbalanceOrg) AS t FROM transactions)) AS stored_type,
    (SELECT COUNT(*) FROM transactions WHERE oldbalanceOrg IS NULL) AS null_count,
    (SELECT COUNT(*) FROM transactions WHERE oldbalanceOrg = '') AS empty_text_count,
    (SELECT COUNT(DISTINCT oldbalanceOrg) FROM transactions) AS distinct_count,
    (SELECT GROUP_CONCAT(v, ' | ') FROM (SELECT DISTINCT oldbalanceOrg AS v FROM transactions LIMIT 3)) AS three_examples
UNION ALL
SELECT
    6 AS position,
    'newbalanceOrig' AS column_name,
    (SELECT GROUP_CONCAT(t, ', ') FROM (SELECT DISTINCT TYPEOF(newbalanceOrig) AS t FROM transactions)) AS stored_type,
    (SELECT COUNT(*) FROM transactions WHERE newbalanceOrig IS NULL) AS null_count,
    (SELECT COUNT(*) FROM transactions WHERE newbalanceOrig = '') AS empty_text_count,
    (SELECT COUNT(DISTINCT newbalanceOrig) FROM transactions) AS distinct_count,
    (SELECT GROUP_CONCAT(v, ' | ') FROM (SELECT DISTINCT newbalanceOrig AS v FROM transactions LIMIT 3)) AS three_examples
UNION ALL
SELECT
    7 AS position,
    'nameDest' AS column_name,
    (SELECT GROUP_CONCAT(t, ', ') FROM (SELECT DISTINCT TYPEOF(nameDest) AS t FROM transactions)) AS stored_type,
    (SELECT COUNT(*) FROM transactions WHERE nameDest IS NULL) AS null_count,
    (SELECT COUNT(*) FROM transactions WHERE nameDest = '') AS empty_text_count,
    (SELECT COUNT(DISTINCT nameDest) FROM transactions) AS distinct_count,
    (SELECT GROUP_CONCAT(v, ' | ') FROM (SELECT DISTINCT nameDest AS v FROM transactions LIMIT 3)) AS three_examples
UNION ALL
SELECT
    8 AS position,
    'oldbalanceDest' AS column_name,
    (SELECT GROUP_CONCAT(t, ', ') FROM (SELECT DISTINCT TYPEOF(oldbalanceDest) AS t FROM transactions)) AS stored_type,
    (SELECT COUNT(*) FROM transactions WHERE oldbalanceDest IS NULL) AS null_count,
    (SELECT COUNT(*) FROM transactions WHERE oldbalanceDest = '') AS empty_text_count,
    (SELECT COUNT(DISTINCT oldbalanceDest) FROM transactions) AS distinct_count,
    (SELECT GROUP_CONCAT(v, ' | ') FROM (SELECT DISTINCT oldbalanceDest AS v FROM transactions LIMIT 3)) AS three_examples
UNION ALL
SELECT
    9 AS position,
    'newbalanceDest' AS column_name,
    (SELECT GROUP_CONCAT(t, ', ') FROM (SELECT DISTINCT TYPEOF(newbalanceDest) AS t FROM transactions)) AS stored_type,
    (SELECT COUNT(*) FROM transactions WHERE newbalanceDest IS NULL) AS null_count,
    (SELECT COUNT(*) FROM transactions WHERE newbalanceDest = '') AS empty_text_count,
    (SELECT COUNT(DISTINCT newbalanceDest) FROM transactions) AS distinct_count,
    (SELECT GROUP_CONCAT(v, ' | ') FROM (SELECT DISTINCT newbalanceDest AS v FROM transactions LIMIT 3)) AS three_examples
UNION ALL
SELECT
    10 AS position,
    'isFraud' AS column_name,
    (SELECT GROUP_CONCAT(t, ', ') FROM (SELECT DISTINCT TYPEOF(isFraud) AS t FROM transactions)) AS stored_type,
    (SELECT COUNT(*) FROM transactions WHERE isFraud IS NULL) AS null_count,
    (SELECT COUNT(*) FROM transactions WHERE isFraud = '') AS empty_text_count,
    (SELECT COUNT(DISTINCT isFraud) FROM transactions) AS distinct_count,
    (SELECT GROUP_CONCAT(v, ' | ') FROM (SELECT DISTINCT isFraud AS v FROM transactions LIMIT 3)) AS three_examples
UNION ALL
SELECT
    11 AS position,
    'isFlaggedFraud' AS column_name,
    (SELECT GROUP_CONCAT(t, ', ') FROM (SELECT DISTINCT TYPEOF(isFlaggedFraud) AS t FROM transactions)) AS stored_type,
    (SELECT COUNT(*) FROM transactions WHERE isFlaggedFraud IS NULL) AS null_count,
    (SELECT COUNT(*) FROM transactions WHERE isFlaggedFraud = '') AS empty_text_count,
    (SELECT COUNT(DISTINCT isFlaggedFraud) FROM transactions) AS distinct_count,
    (SELECT GROUP_CONCAT(v, ' | ') FROM (SELECT DISTINCT isFlaggedFraud AS v FROM transactions LIMIT 3)) AS three_examples
ORDER BY position;
