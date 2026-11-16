# Process log — 01 Fraud patterns

A record of how this project was done with an AI agent. One entry per
working session, newest at the bottom.

## 2026-11-16 — Workspace and project setup

- **Asked:** design a future-proof workspace for portfolio projects and
  generate the starting files.
- **Skill used:** none.
- **Produced:** workspace `AGENTS.md`, three skills, this project
  folder, and the project template.
- **Checked:** _[fill in after you review `SETUP-STEPS.md`]_
- **Corrected:** _[anything you changed after reviewing]_
- **Changed in instructions:** first version.

## 2026-11-16 — Data profiling

- **Asked:** run the data-profiling skill on the PaySim CSV, plan
  first, then wait for a go-ahead.
- **Skill used:** `skills/data-profiling/SKILL.md`.
- **Produced:** `profile.md`, seven query files `sql/01` to `sql/07`,
  the loader `sql/00_load_csv_to_sqlite.py`, and the runner
  `sql/run_query.py`.
- **Checked:** rows loaded (6,362,620) equal the file's line count
  minus the header. Row count, fraud count, flagged count, zero
  amounts, largest amount, latest step, distinct steps, type counts,
  zero `oldbalanceOrg` count, and rows in steps 1 to 372 were recounted
  straight from the CSV without SQLite, and all matched the queries.
- **Corrected:** the agreed plan had six queries. A seventh
  (`07_type_values.sql`) was added to list every transaction type.
- **Departures from instructions:** SQLite was used instead of DuckDB
  (analyst's choice, because DuckDB was not available to the agent).
  The CSV in `data/` was too large to copy, so the same-named,
  same-sized CSV inside the Kaggle `archive.zip` was profiled instead.
- **Changed in instructions:** nothing. Proposed corrections to the
  project `AGENTS.md` are listed at the end of `profile.md` and wait
  for approval.

## 2026-11-16 — Fraud by time period and by transaction type

- **Asked:** count fraud rows in each half of the data, check whether
  the 16 zero-amount rows are the 16 flagged rows, and answer which
  transaction types the fraud rows fall in, with the sql-review skill
  run on each query first. Also apply approved corrections to the
  project `AGENTS.md`.
- **Skill used:** `skills/sql-review/SKILL.md`.
- **Produced:** `sql/08_fraud_by_half.sql`,
  `sql/09_zero_amount_vs_flagged.sql`, `sql/10_fraud_by_type.sql`,
  `sql/11_fraud_by_type_by_half.sql`, and `sql_review.md`.
- **Checked:** all four queries passed review (safe to use). Each
  query's rows add to 6,362,620 and its fraud rows to 8,213. Query 11
  agrees with queries 08 and 10 when summed. All totals were recounted
  from the CSV without SQLite and matched.
- **Corrected:** nothing.
- **Changed in instructions:** project `AGENTS.md` now says 743 steps,
  underscore type spellings, and SQLite. Added a Decisions section
  (time periods, no balance columns, keep zero-amount rows) and
  updated Current status. All approved by the analyst.
