---
title: Multi-Agent Patterns
type: principle
last_updated: 2026-04-29
tags: [principles, multi-agent, workflows, adw]
---

# Multi-Agent Patterns

> Concrete designs for the #1 ADWs leverage point — how work flows between agents. These are the patterns that make multi-agent systems produce more value than the sum of their parts.

Without designed patterns, multi-agent work degenerates into [Tool Proliferation](anti-patterns.md#tool-proliferation-corrupts-9-tools): parallel chaos that looks productive but doesn't integrate.

---

## Pattern 1 — Plan-Build-Review

The default pattern for any non-trivial task.

```
┌─────────────┐     ┌─────────────┐     ┌─────────────┐
│   Plan      │────▶│   Build     │────▶│   Review    │
│  (Opus)     │     │  (Sonnet)   │     │  (Sonnet)   │
└─────────────┘     └─────────────┘     └─────────────┘
   produces            executes            verifies
   plan.md             code + tests        against spec
```

### Roles

- **Plan (Opus)** reads the relevant spec, produces a numbered implementation plan, surfaces ambiguities back to the human as Open Questions
- **Build (Sonnet)** executes the plan; tests + lint + typecheck must pass
- **Review (Sonnet, read-only)** verifies the implementation against the original spec; flags deviations

### When to use

- Any task that touches multiple files
- Any task with non-trivial design decisions
- Any task where the spec is the source of truth

### When to skip

- One-line bug fix where Plan would just say "fix the typo"
- Exploration where you don't yet know what you're doing (use Scout instead)

---

## Pattern 2 — Orchestrator + Scouts

For information-gathering phases.

```
                ┌─────────────┐
                │ Orchestrator│
                │   (Opus)    │
                └──────┬──────┘
                       │ dispatches in one message
       ┌───────────────┼───────────────┐
       ▼               ▼               ▼
┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│ Scout 1     │ │ Scout 2     │ │ Scout N     │
│  (Haiku)    │ │  (Haiku)    │ │  (Haiku)    │
└─────────────┘ └─────────────┘ └─────────────┘
   read-only       read-only       read-only
   reports back    reports back    reports back
                       │
                       ▼
                ┌─────────────┐
                │Orchestrator │
                │ synthesises │
                └─────────────┘
```

### Why scouts work in parallel

- Read-only operations (Read, Glob, Grep) are independent
- Each Scout returns a structured report; orchestrator synthesises
- Prevents orchestrator's context from filling with raw search results
- Haiku is cheap; spawn 5–10 simultaneously

### When to use

- "Where is X defined across the codebase?"
- "Find all callers of function Y"
- "Survey the tests across these 5 packages"
- Any time you'd want to grep + read 20 files

### Anti-pattern: scouts that aren't scouts

Don't dispatch Scouts to *modify* code. They are read-only. Modification is Builder work.

---

## Pattern 3 — Phase Gating

Don't let phases bleed into each other.

```
Scout phase:    [scout 1] [scout 2] [scout 3]
                        ↓ all complete
Plan phase:     [planning agent reads scout reports]
                        ↓ plan exists in plan.md
Build phase:    [builders work against plan]
                        ↓ all builders complete + tests pass
Review phase:   [reviewer agent verifies]
                        ↓ approved
Merge phase:    [merger agent integrates]
```

### Mandatory gates

- Scout → Plan: scout reports must be synthesised before planning
- Plan → Build: `plan.md` must exist before any builder dispatches
- Build → Review: all builders must report success before review starts
- Review → Merge: review must approve before merge

### Why gating matters

- Without gates, builders work against a half-formed plan
- Reviews of in-progress code produce noise
- Merges of unreviewed code skip the safety net

### Implementation

In Claude Code: orchestrator agent is the gate-keeper. It blocks moving to the next phase until the prior phase's outputs exist.

In overstory (os-eco): phase gates are part of the agent manifest configuration.

---

## Pattern 4 — Single-Message Parallelism

When dispatching multiple agents, **all `Task` calls must go in one message** for true parallelism.

### Anatomy

```python
# CORRECT: parallel
[
  Task(subagent_type="Explore", prompt="search for X"),
  Task(subagent_type="Explore", prompt="search for Y"),
  Task(subagent_type="Explore", prompt="search for Z"),
]
# All three execute simultaneously. Total time = max(X, Y, Z).
```

```python
# WRONG: serial despite "looks parallel"
Task(subagent_type="Explore", prompt="search for X")
# wait for response
Task(subagent_type="Explore", prompt="search for Y")
# wait for response
# Total time = X + Y + Z. The "parallelism" was a lie.
```

### Why this matters

10 agents in 1 message complete in roughly the time of 1 agent. Spread across 10 messages, they take 10× longer. The runtime is the parallelism mechanism — sequential messages serialise the work regardless of intent.

### Practical rule

When the orchestrator decides "I need information from 5 different parts of the codebase," all 5 Task calls go in **one** tool block in **one** message.

---

## Pattern 5 — Spec as Shared Artifact

Don't pass massive context between agents. Pass spec file paths.

```
┌────────────────────────────────────────┐
│  Spec: docs/specs/feature.md            │
│  (single artifact, source of truth)     │
└──┬──────────────────────────────────┬───┘
   │                                  │
   ▼                                  ▼
┌──────────┐      ┌──────────┐    ┌──────────┐
│ Scout    │      │ Builder  │    │ Reviewer │
│ reads    │      │ reads    │    │ reads    │
│ spec     │      │ spec     │    │ spec     │
└──────────┘      └──────────┘    └──────────┘
```

### Why this is cheaper than passing context

- Each agent reads the spec fresh, in its own context window
- Spec is one canonical source — no copies to drift
- Updates to the spec propagate to all agents that re-read it
- Specs are versioned (git) — agent runs are reproducible

### Why this is more accurate

- Spec stays in *the human's* head as authority
- Agents don't summarise the spec to each other (information loss)
- Reviewer reads the same spec the Builder did — comparing implementation to authority, not to Builder's summary

### Implementation

- Specs live in `docs/specs/` in the repo
- Every agent prompt starts with: "Read `docs/specs/<feature>.md` in full"
- Multi-agent dispatch passes the spec path, not the spec content

---

## Pattern 6 — Self-Improving Expert Commands

Slash commands that capture repeatable workflows and evolve as failures emerge.

```
.claude/commands/
├── new-event-type.md         # adds a new event to the audit ledger
├── run-smoke-test.md         # runs the foundation E2E smoke test
├── verify-event.md           # verifies a single event's chain
├── spec-check.md             # checks current PR against relevant spec
└── review-pr.md              # multi-aspect PR review
```

Each is a markdown file with the canonical prompt template structure. When a workflow fails or produces wrong output, fix the slash command — the fix propagates to every future use.

### Lifecycle

1. Notice you're prompting the same workflow twice
2. Capture as a slash command
3. Use it; observe failures
4. Update the slash command
5. Each iteration improves the next run

### Anti-pattern

Don't commit slash commands until they've been used at least 3 times. Premature crystallisation = code museum.

---

## When NOT to use multi-agent

Multi-agent has overhead. Single-agent is cheaper and simpler when:

- The task fits in one context window
- The task has no clean parallelisable sub-tasks
- The task is exploratory (you don't know yet what to delegate)

Multi-agent overhead is real: dispatch cost, integration cost, debugging cost. Use it when the parallelism actually pays.

---

## Quick reference

| Pattern | Use when | Skip when |
|---|---|---|
| Plan-Build-Review | Non-trivial change touching multiple files | One-line bug fix |
| Orchestrator + Scouts | Information gathering across codebase | One file's contents needed |
| Phase Gating | Multi-phase work with dependencies | Single-phase task |
| Single-Message Parallelism | Multiple independent sub-tasks | Sequential sub-tasks |
| Spec as Shared Artifact | Multiple agents working on same feature | Single agent on single feature |
| Self-Improving Slash Commands | Workflow used 3+ times | One-off task |

---

## See also

- [Leverage points](leverage-points.md) — #1 ADWs is what these patterns implement
- [Anti-patterns](anti-patterns.md) — what these patterns prevent
- [Prompt template](prompt-template.md) — structure of individual agent prompts
