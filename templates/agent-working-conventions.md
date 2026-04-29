---
title: Agent Working Conventions
status: living
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
tags: [conventions, agents, agentic-engineering]
---

# Agent Working Conventions

> How any AI agent (Claude, Sapling, or otherwise) should work on this codebase. Distilled from the agentic engineering body of knowledge.

<!--
Generic agent working conventions from agentic-bootstrap.
This template stays mostly constant across projects. Project-specific overrides
go in {{PROJECT_NAME}}'s root CLAUDE.md or relevant package CLAUDE.md, not here.
-->

---

## The leverage hierarchy that governs this work

From highest to lowest leverage. Only invest in lower points if the higher ones are sound.

| # | Point | What to actually do |
|---|---|---|
| 1 | **ADWs (workflows)** | Design how multiple agents compose. Don't just spawn parallel agents — design integration. |
| 2 | **Templates** | Every spec follows the same shape; every agent's report follows the same shape. |
| 3 | **Plans** | Every task issued to an agent runs end-to-end without further input. |
| 4 | **Architecture** | Agentically-intuitive choices over clever ones. |
| 5 | **Tests** | Real assertions, not mocks pretending to validate. |
| 6 | **Documentation** | `CLAUDE.md` per package; specs in `docs/specs/` are source of truth. |
| 7 | **Types** | Strict typing; agents fix what the compiler tells them. |
| 8 | **Stdout** | Self-documenting logs; one event = one structured line. |
| 9 | **Tools** | Internal SDKs > MCP > CLI wrappers, in that order of reliability. |
| 10 | **Prompt** | Concrete + testable + clear success criteria. |
| 11 | **Model** | Match tier to task (see below). |
| 12 | **Context** | Load only what's relevant; boot fresh agents at >80% utilisation. |

---

## Agent role catalogue

| Role | Model | Tools | When to use |
|---|---|---|---|
| **Scout** | Haiku | Read, Glob, Grep, Bash | Information gathering, pattern finding, "where is X?" — spawn 5–10 in parallel |
| **Builder** | Sonnet | Read/Write/Edit/Glob/Grep/Bash | Well-defined implementation, refactoring, integration — 2–4 in parallel |
| **Lead** | Opus | All + Task (can spawn) | Architecture decisions, ambiguous problems, security review — 1–2 serial |
| **Reviewer** | Sonnet (read-only) | Read, Grep, Bash | PR review, validation, regression checks |
| **Merger** | Sonnet | Edit, Bash | Conflict resolution, branch integration |

**Rule of thumb:** Default to Sonnet. Use Opus only when ambiguity is real. Use Haiku only for parallel scouts. Don't over-spend; don't under-spend.

---

## Prompt template

Canonical 7-section structure (see also `agentic-bootstrap/docs/principles/prompt-template.md`):

```markdown
---
name: [agent-task-name]
description: [Action-oriented trigger — when should this be used?]
model: haiku | sonnet | opus
tools: [Tool1, Tool2, ...]
---

## Purpose
## Variables
## Instructions
## Workflow
## Report
```

---

## Forbidden patterns

When prompting agents:

- **No "Based on the changes..."** — meta-commentary is banned. Get to the result.
- **No "Here is the..."** — same.
- **No "Let me..." / "I will..."** — same.
- **No fragment context.** Every agent task references the relevant spec doc.
- **No silent design decisions.** If an agent encounters an architectural choice not in [`../specs/05-cross-cutting-architecture-decisions.md`](../specs/05-cross-cutting-architecture-decisions.md), it surfaces back to the human.

---

## Multi-agent patterns to use

- **Plan-Build-Review.** Every non-trivial task: Lead/Opus plans → Builder/Sonnet implements → Reviewer/Sonnet validates.
- **Orchestrator + Scouts.** Information-gathering uses parallel Haiku scouts; orchestrator synthesises.
- **Spec as shared artifact.** Specs in `docs/specs/` are canonical; agents read and write *against* them. Pass spec file paths, not summaries.
- **Phase gating.** `scout ✓ → plan ✓ → build ✓ → review`; don't shortcut.
- **Single-message parallelism.** All `Task` calls in one message block. Sequential messages serialise execution.

---

## Anti-patterns to actively prevent

- **Isolated Prompting** — never start a task without loading the relevant spec.
- **Tool Proliferation** — never spawn parallel agents without an integration plan.
- **Design Delegation** — humans lead on design; agents implement.
- **Testing Theatre** — tests must hit real code paths.
- **Post-Hoc Learning** — when a session uncovers a learning, record it in the relevant `CLAUDE.md` before closing.

---

## Context-budget discipline

- **<30% utilised** — healthy, continue.
- **30–60%** — natural compaction point at end of phase.
- **60–80%** — wrap up gracefully; don't accept new work.
- **>80%** — boot a fresh agent. Compaction at this point degrades quality.

For big reads (e.g. reading a regulatory document corpus), dispatch a fresh Explore agent rather than reading into the orchestrator's context.

---

## Definition of done — per task

A task is complete when:

1. The change passes tests + lint + typecheck.
2. The relevant spec in `docs/specs/` is updated if the change altered any decision in it.
3. Any new convention or learning is recorded.

---

## Learnings (append-only, project-specific)

*Insights worth keeping that aren't yet in a spec or a `CLAUDE.md`.*

- *(none yet)*

---

## Cross-links

- Project index: [`../specs/00-project-index.md`](../specs/00-project-index.md)
- Architecture decisions: [`../specs/05-cross-cutting-architecture-decisions.md`](../specs/05-cross-cutting-architecture-decisions.md)
- Source patterns: agentic-bootstrap repo (the canonical source for these conventions)
