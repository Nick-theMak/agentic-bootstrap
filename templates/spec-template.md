---
title: NN — Project Spec Title
status: spec-draft
created: YYYY-MM-DD
last_updated: YYYY-MM-DD
tags: [project, spec]
---

# NN — Project Spec Title

> One-line pitch.

<!--
This is the canonical 10-section project spec template from agentic-bootstrap.
Each section has a purpose. If you're tempted to skip a section, ask why first.
The "Alternatives considered" and "Open questions" sections are deliberately
present — they prevent silent design decisions (Design Delegation anti-pattern).
-->

---

## TL;DR

Three sentences max. The reader's lift question: *"do I need to read further?"* Answer that.

---

## Problem

What pain are we solving and for whom? Quantify if possible (hours, dollars, error rates). Don't write a problem statement that's actually a feature description in disguise.

---

## Users & jobs-to-be-done

| User | Job | Today's friction |
|---|---|---|
| ... | ... | ... |

Each row is a person + their job + what's broken today. If you can't fill a row, you don't know your user well enough yet.

---

## Foundation

What this spec depends on, and what depends on this spec.

- Depends on: ...
- Enabled / consumed by: ...
- Reused by: ...

---

## MVP scope

**In:**

- Bullet list of what ships in MVP. Be specific.

**Out (explicit non-goals):**

- Bullet list of what is *explicitly* not in MVP. Naming things you're not building is as important as naming things you are.

---

## Architecture sketch

ASCII diagram or mermaid. Component-level, not implementation-level. Include the seams (where this spec connects to other specs).

```
[show the boxes and arrows]
```

### Components

- **Component name** — what it does, in one sentence
- ...

### Alternatives considered

| Decision | Option A | Option B | Recommendation |
|---|---|---|---|
| ... | ... | ... | ... |

The Recommendation column is your reasoned default. If a recommendation hasn't been validated, mark it with `[needs validation]`.

---

## Open questions

Things that need a human decision before this spec is fully executable. Each item:

1. **What's open** — the question
2. **Why it matters** — what depends on the answer
3. **Recommended default** — your best guess if no decision is made

These are the [Design Delegation](../docs/principles/anti-patterns.md) preventatives. If you have *no* open questions, either you're a genius or you're fooling yourself. Usually the latter.

---

## Risks

| Risk | Severity | Mitigation |
|---|---|---|
| ... | Critical / High / Medium / Low | ... |

Critical = the project fails if this happens. High = significant rework. Medium = real but recoverable. Low = noted, not actively mitigated.

---

## Success criteria

How we'll know MVP works.

- [ ] Specific, measurable criterion
- [ ] ...

If you can't write a checkbox you'd actually tick, you don't have a success criterion — you have a hope.

---

## Cross-links

- Depends on: ...
- Enables: ...
- Related: ...
- Inspiration / references: ...

---

<!-- Customisation notes:

- Numbering convention: 00 = index, 01–04 = projects, 05 = cross-cutting decisions, 06+ = phase plans
- Status values: spec-draft / active / done / archived
- Tags: project, spec, plus domain tags (e.g. healthcare, compliance, foundation)
- Cross-references use relative markdown: [Title](nn-spec-name.md)
- Section anchors use GitHub slugification: ## TL;DR → #tldr, ## Open questions → #open-questions
-->
