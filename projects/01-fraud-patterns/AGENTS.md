# AGENTS.md — 01 Fraud patterns

Additions to the workspace `AGENTS.md`. Where they disagree, this file
wins.

## Project question

Which transaction patterns separate fraudulent activity from normal
activity, and which of them could an analyst use as a review rule?

## Data

- Source: PaySim, a synthetic mobile-money dataset published on Kaggle
  (`ealaxi/paysim1`). See `data/README.md`.
- Grain: expected to be one row per transaction. Confirm during
  profiling.
- Location: `data/` (not committed)

### Known facts about PaySim (from its documentation)

- `step` is a unit of time: 1 step is 1 hour. The documentation says
  744 steps (a 30-day simulation), but this file has 743: steps 1 to
  743, with none missing in between (see `profile.md`). There are no
  calendar dates.
- `type` is one of CASH_IN, CASH_OUT, DEBIT, PAYMENT, TRANSFER,
  spelled with underscores in the data.
- `isFraud` is the fraud label. `isFlaggedFraud` is a separate flag
  set by a rule inside the simulation.
- Destination names starting with `M` are merchants, and they have no
  balance information.
- The balance columns are unreliable for fraud rows, because
  fraudulent transactions were cancelled in the simulation. Do not
  build a finding on balance columns without checking this first.
- The data is synthetic. Every finding describes the simulation, not
  real customers. Say so in the write-up.

## Tools

- SQL engine: SQLite. The CSV is loaded once into a local database
  file with `sql/00_load_csv_to_sqlite.py`, and each query file is
  run with `sql/run_query.py`.
- Python: only for charts and for loading files into SQLite.

## Definitions

- **Fraud rate:** fraudulent transactions divided by all transactions
  in the same group. Always report it with both counts.
- **Review rule:** a condition simple enough for an analyst to apply
  by hand, such as "amount above X between midnight and 5am".

## Guardrails for this project

- This is pattern analysis, not a prediction model. Do not train a
  machine-learning model unless asked.
- Fraud is rare in most datasets. Never report a pattern from a group
  with fewer than 30 fraud cases without flagging the small sample.
- A pattern only counts as a finding if it holds in at least two
  separate time periods of the data (for example, steps 1 to 372 and
  steps 373 to 743).

## Decisions

Made by the analyst. They stand until this section is changed.

- 2026-11-16: the two time periods are steps 1 to 372 and steps 373 to
  743, for now. Fraud rows per period are in `sql/08_fraud_by_half.sql`.
- 2026-11-16: do not use the balance columns in any finding, for now.
- 2026-11-16: keep the 16 zero-amount rows in all counts and rates.

## Current status

- 2026-11-16: project folder created. Dataset chosen: PaySim.
- 2026-11-16: data profiled, see `profile.md`. First analysis queries
  run and reviewed (fraud by time period and by transaction type), see
  `sql/08` to `sql/11` and `sql_review.md`. Nothing written in
  `findings.md` yet.
- Next: analyst to choose the next pattern to test.
