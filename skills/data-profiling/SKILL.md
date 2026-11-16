---
name: data-profiling
description: Profiles a new dataset before any analysis. Use when a data file or table is seen for the first time, or when asked to explore, describe, or sanity-check data.
---

# Data profiling

Goal: know what the data is and whether it can be trusted, before
drawing any conclusion from it.

## Steps

1. **Identify the source.** Record in `data/README.md` where the file
   came from, when it was downloaded, and its licence.
2. **Shape.** Row count, column count, and what one row represents
   (one transaction? one account? one day?). State the grain in one
   sentence.
3. **Columns.** For each column: data type, count of nulls, count of
   distinct values, and three example values.
4. **Numeric columns.** Min, max, mean, median. Flag negatives, zeros,
   and extreme values.
5. **Date columns.** Earliest and latest value, and any gaps in
   coverage.
6. **Keys and duplicates.** Find the column or columns that uniquely
   identify a row. Count exact duplicate rows.
7. **Label balance.** If there is a target column such as a fraud
   flag, report the count and percentage of each value.

## Rules

- Write each check as its own SQL file in `sql/`, numbered, with a
  comment at the top stating the question it answers.
- Do not fix, filter, or drop anything during profiling. Only report.
- Do not interpret patterns yet. "12% of amounts are zero" is a
  profile fact. Why they are zero is a later question.

## Output

Save `profile.md` in the project folder with these sections:

1. Source and grain
2. Column table (name, type, nulls, distinct, examples)
3. Data quality issues, most serious first
4. Open questions for the analyst

End by listing which issues need a decision before analysis starts.
