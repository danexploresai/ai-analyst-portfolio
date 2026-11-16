# 01 — Fraud patterns

**Status:** In progress (setup complete, analysis not started)

## The question

Which transaction patterns separate fraudulent activity from normal
activity, and which of them could an analyst use as a review rule?

Fraud teams review a small share of transactions by hand. Knowing
which simple patterns carry the most fraud helps decide where that
review time goes.

## The answer

_To be written when the analysis is complete. See `findings.md`._

## How it was done

- **Data:** PaySim, a public synthetic dataset of mobile-money
  transactions with a fraud label
- **Tools:** DuckDB for SQL, Python for charts, an AI agent working
  under written instructions
- **AI's role:** the agent profiles the data, drafts queries, and
  drafts the write-up. I set the question, review every query with the
  `sql-review` skill, and verify every number before it is published.

## What's in this folder

| File | What it is |
|------|------------|
| `findings.md` | The results, written for a non-technical reader |
| `profile.md` | First look at the data and its quality issues (not created yet) |
| `process.md` | Log of how I worked with the agent |
| `sql/` | Every query behind every number |
| `notebooks/` | Charts and anything SQL could not do |
| `AGENTS.md` | The instructions the agent followed for this project |
