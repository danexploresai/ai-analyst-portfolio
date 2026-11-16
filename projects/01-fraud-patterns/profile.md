# Data profile — PaySim transactions

Profiled 2026-11-16 using the `data-profiling` skill. This is a report
of what the data contains. Nothing was fixed, filtered, or dropped, and
no pattern is interpreted here.

Every number below comes from a query in `sql/`, named beside it. All
seven queries were run on the full file. Percentages are worked out
from the counts shown.

## 1. Source and grain

- **Source:** PaySim synthetic mobile-money dataset, Kaggle
  `ealaxi/paysim1`, downloaded 2026-11-16, licence CC BY-SA 4.0
  (recorded in `data/README.md`).
- **File:** `PS_20174392719_1491204439457_log.csv`, 493,534,783 bytes.
- **Shape:** 6,362,620 rows and 11 columns (`sql/01_shape.sql`). The
  file has 6,362,621 lines, so every line after the header was loaded.
- **Grain:** one row is one transaction: one sender (`nameOrig`)
  moving one amount to one receiver (`nameDest`) in one hour (`step`).
  This is supported by there being no exact duplicate rows and by
  each sender and receiver pair appearing only once
  (`sql/05_keys_duplicates.sql`).
- **Synthetic data:** every figure describes the simulation, not real
  customers.

**How it was run.** The CSV in `data/` is over the 400 MB limit for
copying into the agent's workspace, so the profile was run on the CSV
inside the original Kaggle `archive.zip`. It has the same file name and
the same size in bytes as the file in `data/`. The two were not compared
byte for byte.

**Engine.** SQLite 3.53.1, not DuckDB as the project `AGENTS.md` says.
DuckDB was not available in the agent's workspace. The `.sql` files use
SQLite's dialect. `sql/00_load_csv_to_sqlite.py` loads the CSV and
`sql/run_query.py` runs one query file.

## 2. Column table

From `sql/02_column_profile.sql`. No column has any null or empty
value. Every value in a number column was stored as a number, so there
are no stray text values.

| # | Column | Type | Nulls | Distinct | Three examples |
|---|--------|------|-------|----------|----------------|
| 1 | `step` | integer | 0 | 743 | 1, 2, 3 |
| 2 | `type` | text | 0 | 5 | PAYMENT, TRANSFER, CASH_OUT |
| 3 | `amount` | decimal | 0 | 5,316,900 | 9839.64, 1864.28, 181.0 |
| 4 | `nameOrig` | text | 0 | 6,353,307 | C1231006815, C1666544295, C1305486145 |
| 5 | `oldbalanceOrg` | decimal | 0 | 1,845,844 | 170136.0, 21249.0, 181.0 |
| 6 | `newbalanceOrig` | decimal | 0 | 2,682,586 | 160296.36, 19384.72, 0.0 |
| 7 | `nameDest` | text | 0 | 2,722,362 | M1979787155, M2044282225, C553264065 |
| 8 | `oldbalanceDest` | decimal | 0 | 3,614,697 | 0.0, 21182.0, 41898.0 |
| 9 | `newbalanceDest` | decimal | 0 | 3,555,499 | 0.0, 40348.79, 157982.12 |
| 10 | `isFraud` | integer | 0 | 2 | 0, 1 |
| 11 | `isFlaggedFraud` | integer | 0 | 2 | 0, 1 |

Examples are the first three distinct values found, not a random
sample.

### Transaction types

From `sql/07_type_values.sql`. This query was added to the plan because
the column table only shows three examples.

| `type` | Rows | Share of all rows |
|--------|------|-------------------|
| CASH_OUT | 2,237,500 | 35.17% |
| PAYMENT | 2,151,495 | 33.81% |
| CASH_IN | 1,399,284 | 21.99% |
| TRANSFER | 532,909 | 8.38% |
| DEBIT | 41,432 | 0.65% |

### Numeric columns

From `sql/03_numeric_summary.sql`. Each column has 6,362,620 values and
no negatives. The minimum of every column is 0. The 99th percentile is
the value that 99% of rows are at or below.

| Column | Max | Mean | Median | 99th percentile | Zeros | Above 10 million |
|--------|-----|------|--------|-----------------|-------|------------------|
| `amount` | 92,445,516.64 | 179,861.90 | 74,871.94 | 1,615,983.34 | 16 | 2,443 |
| `oldbalanceOrg` | 59,585,040.37 | 833,883.10 | 14,208.00 | 16,027,262.74 | 2,102,449 | 140,828 |
| `newbalanceOrig` | 49,585,040.37 | 855,113.67 | 0.00 | 16,176,164.13 | 3,609,566 | 145,092 |
| `oldbalanceDest` | 356,015,889.35 | 1,100,701.67 | 132,705.66 | 12,371,824.68 | 2,704,388 | 106,730 |
| `newbalanceDest` | 356,179,278.92 | 1,224,996.40 | 214,661.44 | 13,137,915.03 | 2,439,433 | 118,935 |

"Above 10 million" is only a reporting line to show the length of the
tail. It is not a rule.

### Time coverage

There are no date columns. `step` counts hours. From
`sql/04_step_coverage.sql`:

- Earliest step 1, latest step 743, with 743 distinct steps. Step 744
  is not in the file. No step between 1 and 743 is missing.
- Rows per step range from 2 to 51,352.
- 341 of the 743 steps (45.9%) have fewer than 100 rows.
- Steps 1 to 372 hold 5,285,888 rows (83.08% of 6,362,620). Steps 373
  to 743 hold 1,076,732 rows (16.92%).

### Keys and duplicates

From `sql/05_keys_duplicates.sql`:

- Exact duplicate rows: 0 (6,362,620 distinct rows of 6,362,620).
- There is no transaction ID column.
- `nameOrig` alone is not unique: 6,353,307 distinct values, so 9,313
  rows share a sender with an earlier row.
- `step` with `nameOrig` is not unique either: 6,362,573 distinct
  pairs, 47 short of the row count.
- `nameOrig` with `nameDest` is unique: 6,362,620 distinct pairs. This
  is the smallest set of columns found that identifies a row.

### Label balance

From `sql/06_label_balance.sql`:

| Label | Value | Rows | Share of all rows |
|-------|-------|------|-------------------|
| `isFraud` | 0 | 6,354,407 | 99.8709% |
| `isFraud` | 1 | 8,213 | 0.1291% |
| `isFlaggedFraud` | 0 | 6,362,604 | 99.9997% |
| `isFlaggedFraud` | 1 | 16 | 0.0003% |

All 16 rows with `isFlaggedFraud` = 1 also have `isFraud` = 1. The
other 8,197 fraud rows are not flagged.

## 3. Data quality issues, most serious first

1. **Rows are spread very unevenly over time.** 83.08% of rows
   (5,285,888 of 6,362,620) fall in steps 1 to 372, and 341 of 743
   steps have fewer than 100 rows (`sql/04_step_coverage.sql`). The
   project rule that a pattern must hold in two time periods would
   compare a large first half with a much smaller second half.
2. **The balance columns are zero in a large share of rows.**
   `oldbalanceOrg` is zero in 33.04% of rows (2,102,449),
   `newbalanceOrig` in 56.73% (3,609,566), `oldbalanceDest` in 42.50%
   (2,704,388), and `newbalanceDest` in 38.34% (2,439,433), each out of
   6,362,620 (`sql/03_numeric_summary.sql`). The project file already
   warns that balances are unreliable for fraud rows.
3. **Fraud is rare.** 8,213 of 6,362,620 rows (0.1291%) are fraud
   (`sql/06_label_balance.sql`). Any breakdown into small groups will
   reach the project's 30-case minimum quickly.
4. **Step 744 is missing.** The documentation and the project file say
   744 steps. The file has 743 (`sql/04_step_coverage.sql`).
5. **Amounts and balances have a very long tail.** The largest amount
   is 92,445,516.64 against a median of 74,871.94, and 2,443 amounts
   are above 10 million. Destination balances reach about 356 million
   (`sql/03_numeric_summary.sql`). Means are far above medians in every
   column.
6. **16 transactions have an amount of zero**
   (`sql/03_numeric_summary.sql`).
7. **There is no transaction ID.** Rows can be identified by `nameOrig`
   with `nameDest`, but that is a property of this file, not a designed
   key (`sql/05_keys_duplicates.sql`).
8. **`isFlaggedFraud` is almost empty.** Only 16 rows are flagged
   (`sql/06_label_balance.sql`).
9. **Names do not match the project file.** Types are spelled with an
   underscore in the data (`CASH_OUT`, `CASH_IN`), while the project
   `AGENTS.md` writes `CASH-OUT` and `CASH-IN`
   (`sql/07_type_values.sql`). The column `oldbalanceOrg` is spelled
   differently from `newbalanceOrig` (`sql/02_column_profile.sql`).

Housekeeping, not about the data itself:

- `data/README.md` gives the download date as `11/16/2026` (workspace
  convention is `2026-11-16`) and the file name without `.csv`. Not
  changed, because agents may not edit `data/`.
- The profile ran on SQLite and on the zip copy of the file, as
  described in section 1.

## 4. Open questions for the analyst

Not checked in this profile:

- Do receiver names starting with `M` always have zero balances, as the
  documentation says?
- How do the balance columns behave on fraud rows compared with other
  rows?
- Which rows are the 16 zero-amount transactions? There are also
  exactly 16 flagged rows. Whether these are the same rows was not
  checked.
- Which types do the fraud rows fall in?
- Why do so many steps have so few rows, and is there an hour-of-day
  cycle in `step`?

## Decisions needed before analysis starts

1. **Time split.** Keep steps 1 to 372 and 373 to 743 as the two
   periods despite the 83% and 17% imbalance, or choose a different
   split (issue 1).
2. **Zero balances.** Decide how balance columns may be used, if at
   all, before any query depends on them (issue 2).
3. **Zero amounts.** Keep the 16 zero-amount rows in rate calculations
   or set them aside (issue 6).
4. **SQL engine.** Stay on SQLite or move to DuckDB. This decides the
   dialect of every later query file.
5. **Project file corrections.** Update `AGENTS.md` to say 743 steps,
   use the underscore spellings, and name the engine in use. These
   changes need your approval first (issues 4 and 9).
