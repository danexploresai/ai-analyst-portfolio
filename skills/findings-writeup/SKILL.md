---
name: findings-writeup
description: Writes analysis results as a findings document for a non-technical reader. Use when asked to write up, summarize, or report the results of an analysis, or to draft or update findings.md.
---

# Findings write-up

Goal: a reader with five minutes understands what was found, how sure
we are, and what to do about it.

## Structure

1. **Summary.** Three to five sentences. The answer to the project
   question comes first.
2. **Findings.** One section per finding, strongest first. Each has:
   - a heading that states the finding as a full sentence
   - the number or numbers that support it
   - the query file each number came from, e.g. `sql/04_night_rate.sql`
   - one sentence on what it means in practice
3. **Limits.** What the data cannot tell us, and what could make a
   finding wrong.
4. **Recommended next steps.** What an analyst or team should do with
   this.
5. **Method.** Data source, date range, row counts, tools used.

## Rules

- Every number must cite its query file. If a number has no saved
  query, leave it out and list it as an open item.
- Write a rate with its counts: "2.1% (431 of 20,512)".
- Correlation is not cause. Say "is associated with" unless the data
  supports more.
- Plain language. Define a term the first time it appears.
- No finding is included because it sounds interesting. It needs to
  bear on the project question.

## Before finishing

- Re-run each cited query and confirm the numbers still match.
- Read the summary on its own. It must make sense without the rest.
