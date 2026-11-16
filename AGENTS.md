# AGENTS.md — base instructions for this workspace

Any AI agent working anywhere in this folder reads this file first.
Each project folder has its own `AGENTS.md` with additions. When the two
disagree, the project file wins.

## Who you are working with

- An analyst with a fraud-investigation background.
- Strong in SQL. Still learning Python: keep Python simple and explain
  what each block does in a comment.
- New to working with agents. When you make a choice about tools or
  method, say what you chose and why in one line.

## What this workspace is

A portfolio of analyst projects done with AI agents. It is published on
GitHub, so **everything here is public**.

- Never write passwords, keys, personal details, or real customer data
  into any file.
- Raw data files are never committed (see `.gitignore`).

## How to work

1. **Plan first.** Before any analysis, state your plan in a few lines
   and wait for a go-ahead.
2. **SQL first.** Use SQL for anything SQL can do. Use Python only for
   what it cannot (charts, file handling, statistics).
3. **Every number is traceable.** A figure in `findings.md` must come
   from a query saved in that project's `sql/` folder. Name the file.
4. **Never invent results.** If a query was not run, say so. Do not
   fill in expected numbers.
5. **Show your checks.** Report row counts before and after each join
   or filter, and flag anything that looks off.
6. **Save work as files.** Queries, notes, and findings go in the
   project folder, not only in the chat.
7. **Log the process.** After each working session, add an entry to
   the project's `process.md`.

## Skills

Reusable instructions live in `skills/`. When a task matches, read the
skill's `SKILL.md` in full before starting.

| When the task is...                            | Read                               |
|------------------------------------------------|------------------------------------|
| First look at a new dataset                    | `skills/data-profiling/SKILL.md`   |
| Checking a SQL query before trusting its result | `skills/sql-review/SKILL.md`       |
| Writing up results for a reader                | `skills/findings-writeup/SKILL.md` |

## Layout

```
AGENTS.md        this file
skills/          reusable skills, one folder each
projects/        one folder per portfolio project
  _template/     copy this to start a new project
notes/           learning notes, not project work
```

## Conventions

- Dates: `YYYY-MM-DD`.
- SQL files: numbered in run order, e.g. `01_profile_transactions.sql`.
- One query per file, with a comment at the top saying what it answers.

## Do not

- Edit or delete anything in a project's `data/` folder.
- Run `git push` or publish anything without being asked.
- Change this file or any `SKILL.md` without showing the change first.
