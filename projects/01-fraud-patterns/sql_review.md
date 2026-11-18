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

# SQL review — query 12

Reviewed 2026-11-18 using `skills/sql-review/SKILL.md`, before any
number was reported. Engine: SQLite. Same table and facts as above:
6,362,620 rows, 0 nulls in `step`, `type` and `isFraud`, `isFraud`
holds only 0 and 1, and `step` runs from 1 to 743.

## 12_review_rule_transfer_cashout.sql

**Verdict: safe to use.**

| # | Check | Result | Evidence |
|---|-------|--------|----------|
| 1 | Question match | Pass | Answers: for all steps and for each period, rows and fraud rows inside and outside the rule "type is TRANSFER or CASH_OUT", with each group's share of rows and of fraud. That is the question asked. |
| 2 | Join fan-out | Not applicable | No join. The `UNION ALL` deliberately repeats every row once as "all steps" and once in its period; the results are partitioned by period, so the two levels are never added together. |
| 3 | Dropped rows | Pass | No filter. "All steps" adds to 6,362,620 rows and 8,213 fraud rows. Steps 1 to 372 add to 5,285,888 and 4,153, and steps 373 to 743 to 1,076,732 and 4,060, matching query 08. |
| 4 | Nulls | Pass | 0 nulls in `type`, so no row can fall outside both groups. The 5 type values are exact, so `IN ('TRANSFER', 'CASH_OUT')` misses no spelling variant. |
| 5 | Denominators | Pass | Share of rows: rows in the group divided by all rows in the same period. Share of fraud: fraud rows in the group divided by all fraud rows in the same period. Every period has fraud rows, so no division by zero. Shares add to 100 within each period. |
| 6 | Double counting | Pass | Within one period, each row falls in exactly one group. |
| 7 | Time boundaries | Pass | Same split as query 08. |
| 8 | Grouping | Pass | `period` and `rule_group` are the only non-aggregated columns and both are in `GROUP BY`. |

Independent check: counted directly with a `WHERE` filter, TRANSFER or
CASH_OUT has 2,770,409 rows and 8,213 fraud rows, and all other types
have 3,592,211 rows and 0 fraud rows. Both match the query.
