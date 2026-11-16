# Setup steps — what was built, why, and what you do next

_Generated 2026-11-16. Review this top to bottom, then work through
Part 4._

---

## Part 1 — Decisions made

| Decision | Choice | Who decided |
|----------|--------|-------------|
| What the setup is for | Portfolio projects first, daily-life setup later | You |
| Target role | Analyst who works with AI | You |
| Where it lives | Local folder, published to GitHub | You |
| Instruction format | `AGENTS.md` (open standard) | Me |
| Skill format | Agent Skills, `SKILL.md` (open standard) | Me |
| Where skills live | Visible `skills/` folder, listed in `AGENTS.md` | Me |
| SQL engine for project 01 | DuckDB | Me |
| Dataset for project 01 | PaySim | You |

Anything marked "Me" is a proposal. Tell me to change it.

### Approaches considered

1. **Local folder published to GitHub (chosen).** Work is visible to
   employers from day one, and the history shows how you worked. Cost:
   you learn basic Git.
2. **Local folder, no GitHub yet.** Nothing new to learn now, but
   nothing visible until later.
3. **Everything inside one chat app's project feature (rejected).**
   Easiest start, but your instructions would live inside one
   company's product, which is the opposite of future-proof.

---

## Part 2 — What was built, step by step

### Step 1. The base instructions file: `AGENTS.md`

The file every agent reads first. It contains:

- who the agent is working with (analyst, strong SQL, learning Python)
- the fact that everything here is public
- seven working rules, e.g. "plan first" and "every number is
  traceable to a saved query"
- an index of the skills and when to use each
- a short "do not" list

**Why:** this is the context you would otherwise retype every session.
It is deliberately short. A long instruction file gets followed less
reliably than a short one.

### Step 2. The Claude bridge file: `CLAUDE.md`

One line: `@AGENTS.md`. It tells Claude Code to load `AGENTS.md`.

**Why:** Claude Code started reading `AGENTS.md` on its own in
September 2026, but only when no `CLAUDE.md` exists and only in some
setups. The one-line import works in every version, so it is the safe
choice. You never edit this file. All real instructions stay in
`AGENTS.md`.

### Step 3. Three starter skills in `skills/`

| Skill | What it makes the agent do |
|-------|----------------------------|
| `data-profiling` | Describe a new dataset and list its quality problems before any analysis |
| `sql-review` | Run an eight-point check for queries that run fine but give wrong numbers |
| `findings-writeup` | Write results for a non-technical reader, with every number citing its query |

Each skill is a folder with one `SKILL.md`. The top of the file has a
`name` and a `description`. The description is what an agent uses to
decide whether the skill applies, so it says both what the skill does
and when to use it.

**Why these three:** they are the start, middle, and end of any
analysis, and they are the points where an agent most often goes wrong
without anyone noticing.

**One limitation to know:** tools differ on which folder they scan for
skills automatically. Some scan `.agents/skills/`, Claude Code scans
`.claude/skills/`. To stay independent of that, `AGENTS.md` lists each
skill and tells the agent to read it, which works in any tool. If you
later want a tool's own skill menu to show them, copy the skill
folders into that tool's folder.

### Step 4. The project template: `projects/_template/`

A blank project. Copy the folder and rename it to start a new one.

| File | Purpose |
|------|---------|
| `README.md` | What an employer reads first |
| `AGENTS.md` | Project-specific instructions: question, data, definitions, status |
| `CLAUDE.md` | Same one-line bridge as Step 2 |
| `findings.md` | The results |
| `process.md` | Log of how you worked with the agent |
| `data/README.md` | Where the data came from. The data itself is not published |
| `sql/`, `notebooks/` | Queries and charts |

**Why `process.md` matters:** most portfolios show results. This one
also shows what you asked, what the agent got wrong, and how you
caught it. For the role you chose, that is the evidence.

### Step 5. The first project: `projects/01-fraud-patterns/`

The template, filled in with:

- the question: which transaction patterns separate fraud from normal
  activity, and which could serve as a review rule
- three guardrails: no machine-learning model, flag any pattern with
  fewer than 30 fraud cases, a pattern must hold in two time periods
- the dataset (PaySim) and its known limits, in `data/README.md`

Nothing has been analysed. Every results section says so.

### Step 6. Supporting files

- `README.md`: the portfolio's front page on GitHub.
- `.gitignore`: keeps raw data, secrets, and system files out of
  GitHub.
- `notes/lesson-01-workspace-foundations.md`: the concepts behind this
  setup, in your notes folder.

---

## Part 3 — Review checklist

Read these four files. They matter most.

- [ ] `AGENTS.md`: is anything in "Who you are working with" wrong?
      Is there a rule you disagree with?
- [ ] `README.md`: replace `[Your name]` and `[LinkedIn or email]`.
      Does the introduction describe you the way you want?
- [ ] `projects/01-fraud-patterns/AGENTS.md`: is this the question you
      want to answer? Are the guardrails sensible given your fraud
      experience?
- [ ] `skills/sql-review/SKILL.md`: you know SQL well. Is there a
      check you would add from your own experience?

That last one is worth real time. A skill written from your own
expertise is better than any I can write for you.

---

## Part 4 — What you do next

### 4.1 Test that the instructions load (5 minutes)

1. Open the `ai-workspace` folder in your AI tool.
2. Ask: _"What instructions are you following in this folder? List the
   skills you know about."_
3. It should describe the working rules and name all three skills. If
   it does not, tell me which tool you used.

### 4.2 Install Git and create a GitHub account (15 minutes)

1. Download Git from https://git-scm.com and install with the default
   options.
2. Create an account at https://github.com. Choose a professional
   username, since employers will see it.

### 4.3 Publish the workspace (10 minutes)

Open a terminal in the `ai-workspace` folder and run these one at a
time:

```
git init
git branch -M main
git add .
git commit -m "Set up AI-assisted analyst workspace"
```

Then on GitHub, create a new **empty** repository named
`ai-analyst-portfolio` (no README, no licence), and run:

```
git remote add origin https://github.com/YOUR-USERNAME/ai-analyst-portfolio.git
git push -u origin main
```

Before the push, check that no data files are listed by running
`git status`.

### 4.4 Download the dataset

You chose PaySim. Follow the three steps under "To reproduce" in
`projects/01-fraud-patterns/data/README.md`, then fill in the file
name, date, and licence in the table there.

---

## Part 5 — Lesson roadmap

| Lesson | Topic | You will have |
|--------|-------|---------------|
| 1 (done) | Workspace foundations | This folder |
| 2 | Git and GitHub basics | A public repository |
| 3 | Running your first skill: data profiling | `profile.md` for project 01 |
| 4 | Directing an agent through an analysis | Queries and reviewed results |
| 5 | Editing a skill after it fails | Your first self-written skill change |
| 6 | Write-up and publishing | A finished project 01 |
| Later | The private daily-life workspace | A second, separate folder |
