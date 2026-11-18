# AI-assisted analyst portfolio

**Dan Tran** · [LinkedIn](https://www.linkedin.com/in/dan-tran-b34bb67/)

I am an analyst with a background in fraud investigation. This
repository shows how I do analyst work with AI agents: the questions I
ask, the instructions I give the agent, the checks I run on its output,
and the findings that come out.

## Projects

| # | Project | Question | Status |
|---|---------|----------|--------|
| 01 | [Fraud patterns](projects/01-fraud-patterns/) | Which transaction patterns separate fraud from normal activity? | In progress: first findings written |

## How I work with AI

The agent does not get a blank chat. It works inside this repository
and follows written instructions that anyone can read:

- [`AGENTS.md`](AGENTS.md): the standing rules every agent follows
  here, such as "every number must trace to a saved query".
- [`skills/`](skills/): reusable step-by-step procedures the agent
  loads when a task calls for one.
- Each project's `process.md`: a log of what I asked, what the agent
  produced, and what I corrected.

The instruction file and the skills use open formats (AGENTS.md and
Agent Skills), so the same setup works across different AI tools.

## Layout

```
AGENTS.md     standing instructions for agents
skills/       reusable agent skills
projects/     one folder per project
notes/        my learning notes
```
