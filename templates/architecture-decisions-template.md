---
title: 05 — Cross-cutting Architecture Decisions
status: living
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
tags: [project, spec, architecture, decisions]
---

# 05 — Cross-cutting Architecture Decisions

> Decisions that cut across every project / package / phase. Each section captures a question, options, decision, and validation. The decision log at the bottom is the at-a-glance status.

<!--
This is the cross-cutting architecture decisions template from agentic-bootstrap.
It's the home for the *architectural* calls every project must consciously make.
Repo-local *technical* decisions go in docs/adr/ instead (one ADR per decision).

The "Why this doc exists" section below should stay constant — it explains the
purpose to future agents. Decisions 1–N are project-specific; replace with the
calls relevant to your project.
-->

---

## Why this doc exists

Per the *"lead on design, delegate on implementation"* principle: these are decisions a human should make consciously. If we let an agent silently pick them during implementation, the codebase ends up with structural choices nobody can fully reason about — the **Design Delegation** anti-pattern.

Each decision below: **the question, why it matters, options, decision (with date), validation.**

---

## 1. [First major architectural question]

**The question:** ...

**Why it matters:** ...

### Options

| Option | What it is | Pros | Cons |
|---|---|---|---|
| **A.** ... | ... | ... | ... |
| **B.** ... | ... | ... | ... |
| **C.** ... | ... | ... | ... |

### Decision (YYYY-MM-DD)

**Chosen: [option].** [Reasoning.]

### Validation

[How we'll know this was right.]

---

## 2. [Second major architectural question]

[Same structure.]

---

## 3. [Third major architectural question]

[Same structure.]

---

## Decision log

| # | Decision | Status | Decided on | Notes |
|---|---|---|---|---|
| 1 | [Title] | ⏳ Pending / ✅ Decided | YYYY-MM-DD | [One-line summary] |
| 2 | [Title] | ⏳ Pending / ✅ Decided | YYYY-MM-DD | [One-line summary] |
| 3 | [Title] | ⏳ Pending / ✅ Decided | YYYY-MM-DD | [One-line summary] |

Add rows as decisions are made. Keep status accurate.

---

## Common architectural decisions to consider

These come up in most projects. Use as a starting checklist; add or remove per project:

1. **Stack choice** — language, framework, database, deploy target
2. **Identity model** — how humans + agents are authenticated and authorised
3. **Data residency** — where does data live, why, for what regulatory reason
4. **Build sequencing** — foundation-first vs vertical-first vs hybrid
5. **Multi-tenancy** — single-tenant, multi-tenant SaaS, hybrid
6. **Privacy model** — what's encrypted, what's deletable, how
7. **Observability** — logs, traces, metrics, alerting
8. **CI/CD** — build pipeline, deploy strategy, rollback
9. **Versioning** — semver, calendar, breaking-change policy
10. **External integrations** — auth providers, AI providers, third-party APIs

Most projects need decisions on 4–8 of these. Don't decide ones that don't apply.

---

## Cross-links

- Project index: [00 — Project Index](00-project-index.md)
- Repo-local technical decisions: `docs/adr/`
- Phase plans: `docs/specs/06-...md` and onward

---

<!-- Customisation notes:

- This doc is "living" — decisions get added over the project lifetime
- Don't delete superseded decisions; mark them and add the new decision below
- The decision log table is the at-a-glance reference; keep it accurate
- Each decision should be 1–2 pages max; longer = it's actually a spec
-->
