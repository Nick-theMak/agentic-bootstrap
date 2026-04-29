---
title: The 12 Leverage Points of Agentic Engineering
type: principle
last_updated: 2026-04-29
tags: [principles, leverage-points, framework]
---

# The 12 Leverage Points of Agentic Engineering

> A framework for understanding *where* to intervene in an agentic system. Lower numbers = higher leverage. Changes at the top cascade through the entire system; changes at the bottom produce local fixes.

Adapted from Donella Meadows' "Places to Intervene in a System" (1999), applied to AI-assisted software engineering.

**Guiding philosophy: "One agent, one purpose, one prompt."**

---

## The hierarchy

| # | Leverage point | Core question | Where you spend effort |
|---|---|---|---|
| 12 | **Context** | What does the agent actually know? | What's in the context window — and is it all necessary? |
| 11 | **Model** | What tradeoffs exist: cost, speed, intelligence? | Match model tier to task; don't over-spend on Opus for grep |
| 10 | **Prompt** | Are instructions concrete and followable? | Concrete + testable + clear success criteria |
| 9 | **Tools** | What actions can agents take, and in what form? | Internal SDKs > MCP > CLI wrappers (in reliability order) |
| 8 | **Standard out** | Can agents and operators see what's happening? | Self-documenting structured logs, one event = one line |
| 7 | **Types** | Is typing consistent and enforced? | Strict TypeScript, no `any`, agents fix what compiler tells them |
| 6 | **Documentation** | Can agents navigate and trust the docs? | Living, agent-navigable, kept in sync (CLAUDE.md is the canonical example) |
| 5 | **Tests** | Are tests helping agents or just theatre? | Real assertions on real code paths, not mocked-into-passing |
| 4 | **Architecture** | Is the codebase agentically intuitive? | Patterns well-represented in training data over clever ones |
| 3 | **Plans** | Can agents complete tasks without further input? | "Plans are MASSIVE prompts that run end-to-end" |
| 2 | **Templates** | Do agents know what good output looks like? | Reusable scaffolds — same shape every time |
| 1 | **ADWs (workflows)** | How does work flow between agents? | Designed multi-agent workflows, not parallel chaos |

---

## How to use this hierarchy

**Diagnose top-down.** When an agent underperforms, ask in order:

1. Are the workflows broken? (#1)
2. Are the templates inconsistent? (#2)
3. Are the plans incomplete? (#3)
4. Is the architecture wrong? (#4)
5. Are tests theatre? (#5)
6. Are docs stale or unfindable? (#6)
7. Is typing weak? (#7)
8. Are logs unreadable? (#8)
9. Are tools wrong? (#9)
10. Is the prompt vague? (#10)
11. Is the model wrong tier? (#11)
12. Is context bloated/missing? (#12)

Most practitioners go in reverse — they tweak prompts and models first. That's local optimization on the lowest-leverage points. The book argues this is backwards: **work top-down**.

**Invest in proportion to leverage.** Spend most effort on points #1–#4. The bottom of the hierarchy gets attention only if the top is sound.

---

## Examples per level

### #1 — ADWs (workflows)

- Bad: 15 agents in 15 terminal windows, no integration plan ("Tool Proliferation" anti-pattern)
- Good: Orchestrator dispatches Scout → Builder → Reviewer with phase gates

### #2 — Templates

- Bad: every spec is a different shape; agents waste tokens guessing structure
- Good: every spec follows the same 10-section template; agents fill it predictably

### #3 — Plans

- Bad: "Make this code better"
- Good: "Refactor `auth.ts` to use dependency injection. Extract `validateToken` into its own class. Maintain the existing tests in `auth.test.ts`."

### #4 — Architecture

- Bad: bespoke microservices framework nobody (including agents) recognises
- Good: standard Next.js + Prisma + Postgres — well-trodden in training data

### #5 — Tests

- Bad: tests that mock the database and "pass" but don't reflect production
- Good: integration tests that hit a real Postgres test instance

### #6 — Documentation

- Bad: docs in a wiki the agent can't access; out of date by 6 months
- Good: docs in the repo at `docs/`, updated in the same PR as code

### #7 — Types

- Bad: `any` everywhere, runtime errors are the validation
- Good: TypeScript strict, `noUncheckedIndexedAccess`; type errors block the PR

### #8 — Standard out

- Bad: `console.log("yo")` and `[object Object]` in stderr
- Good: structured JSON logs with consistent fields; greppable

### #9 — Tools

- Bad: a custom MCP server that breaks weekly
- Good: a typed TypeScript SDK with Zod validation that the agent can use reliably

### #10 — Prompt

- Bad: "fix the build"
- Good: "the build fails with `TS2304: Cannot find name 'foo'` in `src/auth.ts:42`. Fix it without disabling the type check."

### #11 — Model

- Bad: Opus for filename matching
- Good: Haiku for parallel scouts; Sonnet for builds; Opus for ambiguous architecture

### #12 — Context

- Bad: 150K tokens of irrelevant project history loaded for every task
- Good: 15K tokens of just the relevant module + spec; agent operates with headroom

---

## Connections

- **Lower → upper amplification.** A good prompt (#10) can't rescue a bad workflow (#1).
- **Upper → lower constraint.** Good architecture (#4) makes tests (#5), docs (#6), and types (#7) cheaper.
- **Templates are the multiplier.** Templates (#2) at quality level X means everything below benefits at level X.

---

## Source

This framework draws from:

- Donella Meadows, "Leverage Points: Places to Intervene in a System" (1999)
- The agentic engineering book (compendium of practitioner experience)
- Direct application across multiple production agentic projects

---

## See also

- [Anti-patterns](anti-patterns.md) — what corrupts each leverage point
- [Prompt template](prompt-template.md) — canonical structure for #10 prompts
- [Multi-agent patterns](multi-agent-patterns.md) — concrete designs for #1 ADWs
