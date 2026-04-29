---
title: NN — Phase X Action Plan
status: active | upcoming | done
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
tags: [project, plan, phase-X]
---

# NN — Phase X: Action Plan Title

> One-sentence goal of this phase. What ships at the end? When does it ship?

<!--
Phase plan template from agentic-bootstrap.
A phase plan is a time-boxed, scope-fixed action plan for a slice of project work.
It sits between specs (which are timeless) and tasks (which are atomic).

Use a phase plan when:
- A spec is large enough that "build it" isn't actionable
- Multiple weeks of work need sequencing
- Concrete deliverables and exit criteria need to be agreed up front
-->

---

## Goal

What does success look like? One paragraph.

**Exit criteria:** the *one* thing that, if true, means this phase is done. (Often: a smoke test passing, a customer using a feature, a deployment going live.)

---

## Scope (in)

| Component | Description |
|---|---|
| ... | ... |

Be specific. Each row is something tangible that will exist at the end of the phase.

---

## Scope (out — deferred to later)

- What's *explicitly* not in this phase
- What's *deliberately* not in this phase

Naming the out-of-scope is what makes the in-scope defensible. If anything in this list creeps in mid-phase, it's scope drift — kill it or formally re-plan.

---

## Week-by-week (rough)

| Week | Focus | Deliverable |
|---|---|---|
| 1 | ... | ... |
| 2 | ... | ... |
| ... | ... | ... |

Timing is approximate. Note which weeks are critical path.

---

## Concurrency opportunities (multi-agent)

Tasks that can parallelise via multi-agent dispatch:

- **Weeks X–Y:** [task A] (agent 1) + [task B] (agent 2) — independent code paths
- **Continuously:** [task C], [task D]

Don't dispatch parallel agents before the foundation work is single-agent-stable. Multi-agent overhead is real.

---

## Definition of done

- [ ] Concrete, testable criterion
- [ ] ...
- [ ] Phase retrospective recorded — what to change for next phase

---

## Risks

| Risk | Mitigation |
|---|---|
| Scope creep into next phase | This doc is the gate. New items require explicit decision. |
| ... | ... |

---

## Concrete day-1 tasks

In rough order:

1. ...
2. ...
3. ...

The first week should ship with a deliberately-failing test that the second week's work makes pass — the carrot for week 2.

---

## Cross-links

- Implements parts of: [spec link]
- Decisions baked in: [architecture decisions link]
- Sets up next phase: [next phase link]

---

<!-- Customisation notes:

- Phase numbering: 00 = phase 0 (foundation), 01 = phase 1 (vertical), etc.
- Status: active means currently being worked on; only one phase active at a time
- Update last_updated when scope changes
- Phase plans archive after completion; don't delete
-->
