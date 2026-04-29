---
title: Canonical Prompt Template
type: principle
last_updated: 2026-04-29
tags: [principles, prompts, templates]
---

# Canonical Prompt Template

> The 7-section structure every agent task should follow. Consistent shape = predictable agent behaviour. This is the #2 Templates leverage point applied to prompts.

---

## The structure

```markdown
---
name: <agent-task-name>
description: <action-oriented trigger — when should this be used?>
model: haiku | sonnet | opus
tools: [Tool1, Tool2, ...]
---

## Purpose
<single responsibility, one sentence>

## Variables
<inputs the agent receives — file paths, IDs, prior work products>

## Instructions
- IMPORTANT: <critical constraints in CAPS>
- <positive instructions>
- <what NOT to do — but framed as positives where possible>

## Workflow
1. <step>
2. <step>
3. <step>

## Report
### Summary
- Status: <success/failure/partial>
- Output: <path or result>
- Open questions: <things requiring human decision>
```

---

## Why each section exists

### Frontmatter (`name`, `description`, `model`, `tools`)

Metadata for orchestrators. The `description` field is the routing trigger — it answers *"when should this agent be used?"* in action terms. Bad: "An agent for code stuff." Good: "Builder agent that implements features against a spec, runs tests, and reports failures."

Model and tools constrain what the agent can do. Always be explicit; defaults bite later.

### Purpose

Single responsibility, one sentence. If you can't say it in a sentence, the agent has too many jobs — split it.

### Variables

What inputs does the agent receive? File paths, ticket IDs, prior agent outputs, customer requirements. Make explicit so the agent can validate before acting.

### Instructions

The behaviour rules. Critical constraints get CAPS prefixes (`IMPORTANT:`, `NEVER:`, `MUST:`) so attention is drawn to them. Forbidden patterns to avoid:

- "Based on the changes..."
- "I have created..."
- "Here is the..."
- "Let me..."
- "I will..."

These are meta-commentary patterns the model produces by default; they waste tokens and obscure the actual result. Banning them in instructions is more effective than telling the agent to be terse.

### Workflow

Numbered steps, sequential. The agent follows them top-down. If a step is conditional, make the condition explicit ("If file does not exist, skip this step.").

### Report

The agent's output structure. Always:

- **Status** — did it succeed?
- **Output** — where to look (file path, URL, message)
- **Open questions** — things the agent didn't resolve and that need human input

Forcing this structure means downstream agents (or humans) can act on the report without reading the whole transcript.

---

## Filled example: Builder agent

```markdown
---
name: feature-builder
description: Implements a single feature from a spec doc and verifies tests pass. Use when a feature is well-defined and ready for implementation.
model: sonnet
tools: [Read, Write, Edit, Bash, Glob, Grep]
---

## Purpose
Implement a feature defined in a spec doc, with passing tests, ready for review.

## Variables
SPEC_PATH: $1                           # path to the spec markdown
FEATURE_NAME: $2                        # short identifier
PACKAGE: $3                             # which workspace package to work in

## Instructions
- IMPORTANT: Read the SPEC_PATH in full before writing any code.
- IMPORTANT: All code is TypeScript strict mode; no `any`; no disabling type errors.
- Run tests after each meaningful change. Don't accumulate untested work.
- If the spec is ambiguous, stop and report the ambiguity in Open Questions.
- Use Zod for any external boundary (HTTP, queue, SDK call).
- Co-locate `*.test.ts` with source.
- Don't add comments unless the *why* is non-obvious.

## Workflow
1. Read SPEC_PATH; produce a numbered implementation plan.
2. Verify the plan is executable end-to-end against the current codebase. If not, surface gaps as Open Questions and stop.
3. Implement the plan step by step.
4. Run `pnpm --filter <PACKAGE> test` after each step.
5. Run `pnpm --filter <PACKAGE> lint && pnpm --filter <PACKAGE> typecheck` at the end.
6. Produce the Report.

## Report
### Summary
- Status: <success/failure/partial>
- Output: <file paths changed, PR description draft>
- Open questions: <ambiguities found in spec; decisions deferred to human>
```

---

## Variations per role

The structure is the same; emphasis shifts.

| Role | Strong sections | Notes |
|---|---|---|
| **Scout** | Purpose, Variables, Workflow | Read-only; report findings; no Implementation; spawn 5–10 in parallel |
| **Builder** | Instructions, Workflow, Report | Implementation focus; tests + lint mandatory |
| **Reviewer** | Instructions (verification criteria), Report | Read-only; verify against spec; flag deviations |
| **Lead/Orchestrator** | Workflow (multi-phase), Variables (sub-agent dispatches) | Coordinates other agents; tracks phase gates |
| **Merger** | Instructions (conflict resolution rules), Workflow | Branch integration; preserves both intentions |

---

## Common mistakes

### Forgetting Variables

If the agent doesn't know exactly what input it's receiving, the prompt feels conversational and the output drifts. Make variables explicit even if they seem obvious.

### Vague success criteria

"Make this better" → bad. "All tests pass and the bundle size doesn't increase by more than 5%" → good. The success criteria appear in Instructions or in the Workflow's last step.

### Negative-only instructions

"Don't do X. Don't do Y. Don't use Z." Models follow positives better. Reframe as: "Use A. Use B. Use C."

### No Report shape

Without a structured Report, the agent fills with noise — decoration, congratulations, summaries of work done. The structured Report constrains output to what's actionable.

### Conflating multiple tasks

If the agent is doing three things, write three prompts. Composability beats omnibus.

---

## Stage hierarchy (prompt maturity)

Prompts mature through stages. Don't skip to L5 prematurely.

| Level | What it is | When to use |
|---|---|---|
| L1 | Free-form natural language | Throwaway tasks, exploration |
| L2 | Structured with sections | Repeatable internal use |
| L3 | Templated with variables | Used by multiple people |
| L4 | Versioned + tested + measured | Production workflows |
| L5 | Composed (calls other prompts) | Multi-agent orchestration |

Most production agent prompts should be L3–L4. L5 is for orchestrators (a Lead agent that dispatches Scouts and Builders).

Premature L5 = unmaintainable. Late-arriving L1 = ad-hoc chaos. Match the level to the actual usage.

---

## See also

- [Leverage points](leverage-points.md) — #2 Templates, #10 Prompt
- [Anti-patterns](anti-patterns.md) — Isolated Prompting, Automated Optimization Before Understanding
- [Multi-agent patterns](multi-agent-patterns.md) — when prompts compose
