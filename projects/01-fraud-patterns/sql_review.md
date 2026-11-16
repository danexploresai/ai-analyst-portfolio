# SQL review — queries 08 to 11

Reviewed 2026-11-16 using `skills/sql-review/SKILL.md`, before any
number was reported. Engine: SQLite. Table: `transactions`, 6,362,620
rows. Balance columns are not used in any of these queries.

The checks were run against the data, not judged by reading. Each
query's totals were also recounted straight from the CSV without
SQLite, and all matched.

Facts used by several checks, all confirmed by running them:

- `step`, `type`, `amount`, `isFraud`, and `isFlaggedFraud` have 0
  nulls.
- `isFraud` and `isFlaggedFraud` only hold 0 and 1, so `SUM(isFraud)`
  equals the number of fraud rows.
- `step` runs from 1 to 743 with 0 rows outside that range.
- None of the four queries has a join.

## 08_fraud_by_half.sql

**Verdict: safe to use.**

| # | Check | Result | Evidence |
|---|-------|--------|----------|
| 1 | Question match | Pass | Answers: rows, fraud rows, and fraud rate in steps 1 to 372 and in steps 373 to 743. That is the question asked. |
| 2 | Join fan-out | Not applicable | No join. |
| 3 | Dropped rows | Pass | No filter. The two periods add to 6,362,620 rows and 8,213 fraud rows, the table totals. |
| 4 | Nulls | Pass | 0 nulls in `step` and `isFraud`. The `ELSE` branch would also catch a null or out-of-range step, but there are none. |
| 5 | Denominators | Pass | Fraud rows in the period divided by all rows in the period. Neither period is empty. |
| 6 | Double counting | Pass | Each row has one step, so it falls in exactly one period. |
| 7 | Time boundaries | Pass | Step 372 is in the first period and step 373 in the second, as intended. The query prints the first and last step of each period: 1 to 372 and 373 to 743. |
| 8 | Grouping | Pass | The only non-aggregated column is `period`, and it is in `GROUP BY`. |

## 09_zero_amount_vs_flagged.sql

**Verdict: safe to use.**

| # | Check | Result | Evidence |
|---|-------|--------|----------|
| 1 | Question match | Pass | Answers: among rows that are zero-amount or flagged, how many are each combination. A line with both set to 1 would mean overlap. |
| 2 | Join fan-out | Not applicable | No join. |
| 3 | Dropped rows | Pass | The `WHERE` clause keeps 32 rows and removes 6,362,588 on purpose. Counted separately: 16 zero-amount, 16 flagged, 0 both, 32 either. |
| 4 | Nulls | Pass | 0 nulls in `amount` and `isFlaggedFraud`, so no row can slip past the filter as unknown. |
| 5 | Denominators | Not applicable | No rate. |
| 6 | Double counting | Pass | Each kept row falls in one combination. The combinations add to 32. |
| 7 | Time boundaries | Not applicable | No time filter. |
| 8 | Grouping | Pass | All three non-aggregated columns are in `GROUP BY`. |

Extra check on `amount = 0`: every amount is stored as a number, and
the smallest non-zero amount is 0.01, so no "almost zero" value is
missed by an exact comparison.

## 10_fraud_by_type.sql

**Verdict: safe to use.**

| # | Check | Result | Evidence |
|---|-------|--------|----------|
| 1 | Question match | Pass | Answers: for each type, all rows, fraud rows, fraud rate, and share of all fraud. That is the question asked. |
| 2 | Join fan-out | Not applicable | No join. |
| 3 | Dropped rows | Pass | No filter. The five types add to 6,362,620 rows and 8,213 fraud rows. Types with no fraud still appear. |
| 4 | Nulls | Pass | 0 nulls in `type` and `isFraud`. No spelling variants: 5 distinct types before and after trimming and upper-casing. |
| 5 | Denominators | Pass | Fraud rate: fraud rows of the type divided by all rows of the type (smallest type has 41,432 rows). Share: fraud rows of the type divided by all 8,213 fraud rows. The shares add to 100. |
| 6 | Double counting | Pass | Each row has one type. |
| 7 | Time boundaries | Not applicable | No time filter. All 743 steps are included. |
| 8 | Grouping | Pass | `type` is the only non-aggregated column and is in `GROUP BY`. |

Note for reading the result: three types have 0 fraud rows. Under the
project guardrail these are groups with fewer than 30 fraud cases, so
they are flagged. Each is 0 out of a very large number of rows.

## 11_fraud_by_type_by_half.sql

**Verdict: safe to use.**

| # | Check | Result | Evidence |
|---|-------|--------|----------|
| 1 | Question match | Pass | Answers: for each type in each period, all rows, fraud rows, and fraud rate. |
| 2 | Join fan-out | Not applicable | No join. |
| 3 | Dropped rows | Pass | No filter. The ten groups add to 6,362,620 rows and 8,213 fraud rows. |
| 4 | Nulls | Pass | Same as queries 08 and 10. |
| 5 | Denominators | Pass | Fraud rows of the type in the period divided by all rows of the type in the period. The smallest group has 7,500 rows. |
| 6 | Double counting | Pass | Each row has one type and one period. |
| 7 | Time boundaries | Pass | Same split as query 08. |
| 8 | Grouping | Pass | `type` and `period` are both in `GROUP BY`. |

Consistency: summed by type, the groups match query 10 for every type.
Summed by period, they match query 08.

## Checks that could not be run

None.
