---
title: Named Anti-Patterns
type: principle
last_updated: 2026-04-29
tags: [principles, anti-patterns, failure-modes]
---

# Named Anti-Patterns

> Specific, named failure behaviours that corrupt the [leverage points](leverage-points.md). Most are *behavioural*, not technical — engineers using AI in ways that produce work-shaped output without producing actual work.

The seven below come from independent practitioners (Liu, Hamel Husain, Simon Willison) who converged on a shared diagnosis: the gap between high- and low-leverage AI engineers is mostly behavioural.

---

## Low-leverage anti-patterns (#9–#12)

### Isolated Prompting (corrupts #12 Context)

**Symptom:** An engineer pastes meeting notes, a code snippet, or a requirements section into a prompt without the surrounding architectural context. The model produces output that's syntactically coherent but semantically disconnected from the actual system.

**Why it fails:** The prompt may be excellent. The failure is upstream — *what context was provided*, not *how the prompt was written*. A perfect prompt with isolated context produces wrong-but-confident output.

**Distinguishing feature:** Not a prompt-quality problem. Can occur with sophisticated L4–L5 prompts.

**Corrective:** Always include the architectural context (CLAUDE.md, relevant spec doc, current code structure). If the agent doesn't know which file to look at, the prompt is incomplete.

---

### Tool Proliferation (corrupts #9 Tools)

**Symptom:** Engineer launches 15 parallel agent instances in 15 separate terminal windows, each working independently on the same codebase. No shared state, no integration plan, no synthesis step.

**Why it fails:** Tools (#9) only produce value when their outputs *integrate*. Parallel chaos generates the *appearance* of activity while producing unintegrated, often conflicting output. The reconciliation cost frequently exceeds what one well-directed agent would have required.

**Distinguishing feature:** Not an orchestration failure — there *is* no orchestration. Treating parallel invocation as equivalent to designed multi-agent workflow.

**Corrective:** Designed ADWs (#1). Every parallel batch has a designated synthesis step. Agents go in one message; results integrate before the next phase.

---

## Medium-leverage anti-patterns (#5–#8)

### Testing Theatre (corrupts #5 Tests)

**Symptom:** Team builds evaluation frameworks without domain expert alignment, then optimises toward generic benchmark pass rates. Aggregate scores improve while product-specific failures go undetected.

**Why it fails:** Generic evals create false confidence. Tests (#5) help when they surface *real* failure modes. They become theatre when optimised for benchmarks disconnected from product behaviour.

**Distinguishing feature:** Tests run, tests pass — and tell you nothing. The failure is *test selection*, not test implementation.

**Corrective:** Manual error analysis *before* automated optimisation. Build evals customised to your product. The novice-to-expert gap in eval work centres on distinguishing high-ROI work from low-value busywork.

---

### Metric Over-Aggregation (corrupts #5 Tests, measurement layer)

**Symptom:** Distinct failure types collapsed into a single aggregate metric. Two hallucination subtypes (fabricated facts vs. invented user actions) get lumped into one "hallucination score." Aggregate improves while a subtype regresses.

**Why it fails:** Granularity is the skill in eval work. An aggregate that improves can mask a worsening subtype. Test infrastructure operates correctly but cannot surface what matters when discrimination is insufficient.

**Distinguishing feature:** Tests exist and run. The failure is *insufficient resolution* in what they measure.

**Corrective:** Per-failure-mode metrics. Each subtype gets its own number.

---

## High-leverage anti-patterns (#1–#4)

### Design Delegation (corrupts #3 Plans and #4 Architecture)

**Symptom:** Engineer defers architectural decisions to AI during implementation, reasoning "refactoring is cheap." The codebase accumulates structural choices the engineer never explicitly made and therefore cannot fully reason about.

**Why it fails:** Plans (#3) require the engineer to understand the architecture (#4) well enough to write a complete, executable specification. Delegating architecture during implementation forecloses both: plans cannot be complete without understood architecture, and architecture cannot be evaluated if its decisions were never consciously made.

**Distinguishing feature:** Not a plan-quality failure — the engineer may not be writing plans at all. The failure is the *framing*: treating AI as architect rather than as implementer executing human-defined design.

**Corrective:** *"Lead on design, delegate on implementation."* Architectural decisions get conscious sign-off from a human and are documented (e.g. in an ADR). Implementation work is delegated freely.

---

### Post-Hoc Learning (corrupts #1 ADWs)

**Symptom:** Engineers acquire AI tooling knowledge exhausted, between meetings, through ad-hoc usage rather than structured learning. Point knowledge of individual tools accumulates without the workflow design literacy that connects tools into ADWs.

**Why it fails:** ADWs (#1) — how work flows between agents — represent the highest-leverage intervention. Point-tool knowledge does not produce workflow design capability. Engineers learning tools in isolation can use individual tools competently but cannot design ADWs that compose them, because ADW design is a different skill than tool operation.

**Distinguishing feature:** Not a tool-knowledge problem — the engineer may know tools well. The failure is the absence of *workflow design literacy*, which structured learning (not ad-hoc usage) develops.

**Corrective:** Structured learning. Design ADWs intentionally. Treat workflow design as its own discipline.

---

### Automated Optimization Before Understanding (corrupts #2 Templates and #1 ADWs)

**Symptom:** Teams delegate prompt optimisation to automated tools before developing manual understanding of failure modes. Automated hill-climbing on static metrics refines known failures but cannot discover new ones; practitioners never develop judgment about whether the target metric is correct.

**Why it fails:** Templates (#2) and ADWs (#1) must encode practitioner judgment about what *good* looks like. Automated optimisation produces locally-optimal outputs *on the target metric*; it cannot encode the judgment that determines whether the target metric is the right one.

**Distinguishing feature:** Not automation that's wrong in principle — automation has its place at later stages. The failure is *sequencing*: automation at stage 1 forecloses the manual learning that produces judgment.

**Corrective:** Manual prompt writing first. *Good writing is good thinking.* Delegating early means never fully understanding requirements or failure modes.

---

## Quick reference table

| Anti-Pattern | Corrupts | Failure type |
|---|---|---|
| **Isolated Prompting** | #12 Context | Missing context, not missing prompt skill |
| **Tool Proliferation** | #9 Tools | Parallel instances without integration plan |
| **Testing Theatre** | #5 Tests | Generic evals optimised on wrong target |
| **Metric Over-Aggregation** | #5 Tests | Insufficient failure-mode discrimination |
| **Design Delegation** | #3–#4 Plans/Architecture | AI as architect, not implementer |
| **Post-Hoc Learning** | #1 ADWs | Point-tool knowledge without workflow literacy |
| **Automated Optimization Before Understanding** | #1–#2 ADWs/Templates | Judgment outsourced before developed |

---

## Practical preventions

- **Every agent task starts by loading the relevant spec doc** — prevents Isolated Prompting
- **Every parallel agent batch has a named synthesis step** — prevents Tool Proliferation
- **Architecture decisions go in an ADR before code** — prevents Design Delegation
- **Tests are written against real behaviour, not mocks of internal logic** — prevents Testing Theatre
- **Each failure mode gets its own metric** — prevents Metric Over-Aggregation
- **Workflow design is a separate effort from tool learning** — prevents Post-Hoc Learning
- **Manual prompt writing precedes any automation** — prevents Automated Optimization Before Understanding

---

## See also

- [Leverage points](leverage-points.md) — the hierarchy these anti-patterns corrupt
- [Multi-agent patterns](multi-agent-patterns.md) — designed alternatives to parallel chaos
- [Prompt template](prompt-template.md) — structured prompts that resist isolated prompting
