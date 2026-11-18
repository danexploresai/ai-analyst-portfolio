# 01 — Fraud patterns

**Status:** In progress (first findings written: fraud by transaction
type; more patterns to test)

## The question

Which transaction patterns separate fraudulent activity from normal
activity, and which of them could an analyst use as a review rule?

Fraud teams review a small share of transactions by hand. Knowing
which simple patterns carry the most fraud helps decide where that
review time goes.

## The answer

_Partial answer so far. Full detail in `findings.md`._

- **Transaction type is the first filter.** All 8,213 fraud
  transactions are TRANSFER or CASH_OUT, in both time periods. The
  other three types have none (`sql/10_fraud_by_type.sql`,
  `sql/11_fraud_by_type_by_half.sql`).
- **It is not yet a review rule.** Reviewing only those two types
  covers 100% of fraud but still means 43.54% of all transactions
  (2,770,409 of 6,362,620) (`sql/12_review_rule_transfer_cashout.sql`).
- **TRANSFER is the better place to start.** Its fraud rate is 0.77%
  (4,097 of 532,909), against 0.18% for CASH_OUT (4,116 of 2,237,500).
- **Next:** test amount, time of day and transfer-then-cash-out
  sequences inside these two types.

### Progress so far

- The data is profiled: 6,362,620 transactions, of which 8,213
  (0.1291%) are labelled as fraud. See `profile.md`.
- The dataset's own built-in flag marks 16 of those 8,213 fraud
  transactions (`sql/06_label_balance.sql`).
- The data is split into two time periods for testing. Each has about
  4,100 fraud transactions, so a pattern can be checked in both
  (`sql/08_fraud_by_half.sql`).

## How it was done

- **Data:** PaySim, a public synthetic dataset of mobile-money
  transactions with a fraud label. Findings describe the simulation,
  not real customers.
- **Tools:** SQLite for SQL, Python for loading the data and for
  charts, an AI agent working under written instructions
- **AI's role:** the agent profiles the data, drafts queries, and
  drafts the write-up. I set the question, review every query with the
  `sql-review` skill, and verify every number before it is published.

## What's in this folder

| File | What it is |
|------|------------|
| `findings.md` | The results, written for a non-technical reader |
| `profile.md` | First look at the data and its quality issues |
| `sql_review.md` | The checks run on each query before its result was used |
| `process.md` | Log of how I worked with the agent |
| `sql/` | Every query behind every number |
| `notebooks/` | Charts and anything SQL could not do |
| `AGENTS.md` | The instructions the agent followed for this project |
