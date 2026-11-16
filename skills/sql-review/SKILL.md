---
name: sql-review
description: Reviews a SQL query for errors that produce wrong numbers without failing. Use before any query result is written into findings, or when asked to check, review, or verify a query.
---

# SQL review

Goal: catch queries that run fine and return the wrong answer.

## Checklist

Work through every item and report each as pass, fail, or not
applicable.

1. **Question match.** Restate in one sentence what the query answers.
   Compare it with the question that was asked.
2. **Join fan-out.** For each join, are the join keys unique on at
   least one side? Compare row counts before and after the join.
3. **Dropped rows.** Does an inner join or a `WHERE` clause remove rows
   that should be counted? Report how many rows each step removes.
4. **Nulls.** How do nulls behave in each filter, join key, and
   aggregate? `COUNT(col)` skips nulls. `NOT IN` with a null returns
   nothing.
5. **Denominators.** For every rate or percentage, state exactly what
   is being divided by what. Check for division by zero.
6. **Double counting.** Can one transaction, account, or customer be
   counted more than once?
7. **Time boundaries.** Are date ranges inclusive or exclusive at each
   end, and is that intended?
8. **Grouping.** Does every non-aggregated column appear in
   `GROUP BY`?

## Rules

- Run the checks. Do not judge by reading alone when the data is
  available.
- Do not rewrite the query unless asked. Report the problem and
  propose the fix.
- If a check cannot be run, say which one and why.

## Output

A short review with:

- Verdict: safe to use / fix first
- The checklist results
- For each failure: what goes wrong, how much it changes the number,
  and the proposed fix
