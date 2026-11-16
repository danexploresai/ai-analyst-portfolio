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

- `step` is a unit of time: 1 step is 1 hour, 744 steps in total
  (a 30-day simulation). There are no calendar dates.
- `type` is one of CASH-IN, CASH-OUT, DEBIT, PAYMENT, TRANSFER.
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

- SQL engine: DuckDB. It runs SQL directly on CSV files with no
  server to set up.
- Python: only for charts and for loading files into DuckDB.

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
  steps 373 to 744).

## Current status

- 2026-11-16: project folder created. Dataset chosen: PaySim. Nothing
  analysed yet.
- Next: download the data, then run the data-profiling skill.
