# Lesson 01 — Workspace foundations

_2026-11-16_

## The ideas

**1. Context beats clever prompts.**
An agent is only as good as what it can see when it starts work. The
main skill is deciding what the agent reads and when, not finding
magic wording.

**2. Standing instructions live in a file, not in the chat.**
`AGENTS.md` holds what would otherwise be retyped every session. It
belongs to the folder, so every agent working in that folder gets the
same instructions.

**3. Instructions come in layers.**
The workspace file holds what is true everywhere. Each project file
adds what is true only there. The closer file wins.

**4. A skill is a procedure, loaded only when needed.**
A skill is a folder containing a `SKILL.md`. The short description at
the top tells the agent when to use it. The full steps are read only
when the task matches, which keeps the agent's context small.

**5. Plain files in open formats are the future-proofing.**
AGENTS.md and Agent Skills are open standards read by many tools. If
the tools change, the folder moves with me.

**6. Public and private do not mix.**
This workspace is public on GitHub. Nothing personal goes in it. The
daily-life setup will be a separate, private folder.

## How to tell whether instructions are working

- The agent states a plan before acting, because `AGENTS.md` says to.
- Numbers in findings cite a query file.
- When the agent does something unwanted twice, that is a missing
  instruction. Add one line to `AGENTS.md` or the skill, and log the
  change in `process.md`.

## Questions I still have

-
