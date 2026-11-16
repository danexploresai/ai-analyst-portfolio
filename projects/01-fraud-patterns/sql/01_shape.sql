-- 01_shape.sql
-- Question: how many rows and how many columns does the transactions
-- table have?
-- Engine: SQLite.
SELECT
    (SELECT COUNT(*) FROM transactions)                       AS row_count,
    (SELECT COUNT(*) FROM pragma_table_info('transactions'))  AS column_count;
