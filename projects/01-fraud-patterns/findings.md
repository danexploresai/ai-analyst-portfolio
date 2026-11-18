# Findings — 01 Fraud patterns

_Last updated: 2026-11-18. Partial results: transaction type is the
first pattern tested. More patterns will follow._

## Summary

In this simulated mobile-money data, transaction type is the clearest
fraud pattern found so far. Every one of the 8,213 fraud transactions
is a TRANSFER or a CASH_OUT, and the other three types have no fraud
at all. That holds in both halves of the data. Reviewing only those
two types would cover all fraud while skipping 56% of transactions,
but it still leaves 2.8 million transactions, far too many to review
by hand. Type is therefore a first filter, not a review rule by
itself. The next step is to find patterns inside TRANSFER and
CASH_OUT, where TRANSFER has the higher fraud rate.

All results describe the PaySim simulation, not real customers.

## Findings

### 1. All fraud is in TRANSFER and CASH_OUT transactions

- CASH_OUT: 4,116 fraud transactions, 50.12% of all fraud.
- TRANSFER: 4,097 fraud transactions, 49.88% of all fraud.
- PAYMENT (0 of 2,151,495), CASH_IN (0 of 1,399,284) and DEBIT
  (0 of 41,432) have no fraud.
- Source: `sql/10_fraud_by_type.sql`.

It holds in both time periods: all 4,153 fraud transactions in
steps 1 to 372 and all 4,060 in steps 373 to 743 are TRANSFER or
CASH_OUT (`sql/11_fraud_by_type_by_half.sql`).

**In practice:** in this data, a PAYMENT, CASH_IN or DEBIT transaction
never needs fraud review.

### 2. Reviewing only TRANSFER and CASH_OUT covers all fraud with 44% of transactions

| Period | Transactions reviewed | Fraud covered |
|--------|-----------------------|---------------|
| All steps | 43.54% (2,770,409 of 6,362,620) | 100% (8,213 of 8,213) |
| Steps 1 to 372 | 43.67% (2,308,220 of 5,285,888) | 100% (4,153 of 4,153) |
| Steps 373 to 743 | 42.93% (462,189 of 1,076,732) | 100% (4,060 of 4,060) |

Source: `sql/12_review_rule_transfer_cashout.sql`.

**In practice:** the rule "review only TRANSFER and CASH_OUT" more than
halves the review load without missing any fraud. At 2.8 million
transactions, it is still too broad for manual review, so it needs to
be combined with a second condition.

### 3. TRANSFER transactions have a higher fraud rate than CASH_OUT

A fraud rate is the number of fraud transactions divided by all
transactions of that type.

| Period | TRANSFER | CASH_OUT |
|--------|----------|----------|
| All steps | 0.77% (4,097 of 532,909) | 0.18% (4,116 of 2,237,500) |
| Steps 1 to 372 | 0.47% (2,067 of 439,106) | 0.11% (2,086 of 1,869,114) |
| Steps 373 to 743 | 2.16% (2,030 of 93,803) | 0.55% (2,030 of 368,386) |

Sources: `sql/10_fraud_by_type.sql` (all steps) and
`sql/11_fraud_by_type_by_half.sql` (each period).

**In practice:** the two types carry about the same amount of fraud,
but TRANSFER has far fewer transactions, so each TRANSFER reviewed is
more likely to be fraud. If review time is limited, TRANSFER is the
better place to start.

## Limits

- **Synthetic data.** PaySim is a simulation. These patterns show how
  the simulator generates fraud, and may not match real fraud.
- **Association, not cause.** Transaction type is associated with fraud
  here. It does not show why the fraud happens.
- **Fraud rates are not comparable across the two periods.** The
  second period has far fewer transactions (1,076,732 against
  5,285,888) but about the same number of fraud transactions (4,060
  against 4,153), so every rate is higher there
  (`sql/08_fraud_by_half.sql`). Each finding compares types within
  the same period.
- **Balance columns were not used.** Fraudulent transactions were
  cancelled in the simulation, so balances are unreliable for fraud
  rows. A balance-based pattern could exist that this analysis does
  not test.
- **The simulation's own flag is too small to judge.** The built-in
  `isFlaggedFraud` flag marks 16 of the 8,213 fraud transactions
  (`sql/06_label_balance.sql`). The 16 zero-amount transactions are
  also all fraud, and they are different rows from the 16 flagged ones
  (`sql/09_zero_amount_vs_flagged.sql`). Both groups have fewer than
  30 fraud cases, so neither is reported as a finding.

## Recommended next steps

1. Within TRANSFER and CASH_OUT, test whether transaction amount
   separates fraud from normal activity, for example by amount band,
   and check it in both periods.
2. Test time of day. Each step is one hour, so the hour is
   `step % 24`. Check whether fraud clusters at certain hours.
3. Check whether fraud follows a TRANSFER-then-CASH_OUT sequence,
   where money is moved to another account and then withdrawn.
4. Combine the strongest conditions into one review rule and report
   how many transactions it flags and what share of fraud it covers.

## Method

- **Data:** PaySim, a synthetic mobile-money dataset published on
  Kaggle (`ealaxi/paysim1`). 6,362,620 transactions, of which 8,213
  (0.1291%) are labelled as fraud (`sql/06_label_balance.sql`).
- **Time range:** steps 1 to 743. One step is one hour of simulated
  time; there are no calendar dates. The two test periods are steps 1
  to 372 and steps 373 to 743.
- **Tools:** SQLite. The CSV is loaded with
  `sql/00_load_csv_to_sqlite.py`, and each query is run with
  `sql/run_query.py`.
- **Checks:** every query cited here passed the `sql-review` skill
  before its numbers were used (`sql_review.md`). All cited queries
  were re-run on 2026-11-18 and their numbers matched.
- **AI's role:** an AI agent drafted the queries and this write-up
  under the rules in `AGENTS.md`. The analyst set the question and
  the decisions, and reviews every query and number.
