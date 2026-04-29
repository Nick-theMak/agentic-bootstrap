# CLAUDE.md (root)

> Agent instructions for the {{PROJECT_NAME}} repo. The authoritative design source is `docs/` in this repo. The repo is self-contained — clone it, get every spec, every decision, every convention.

<!--
This file is the root CLAUDE.md template from agentic-bootstrap.
Replace {{PROJECT_NAME}} and other placeholders with project-specific values.
Customise the Stack, Commands, and Where things live sections per project.
The Session-start directive, Code conventions, Working pattern, Multi-agent
rules, Definition of done, and Anti-patterns sections are intended to stay
constant across projects.
-->

---

## At session start (read this first)

Before doing any work in this repo:

1. **Read [`docs/conventions/agent-working-conventions.md`](docs/conventions/agent-working-conventions.md) once.** It contains the leverage-point hierarchy, the named anti-patterns, the agent role catalogue, the prompt template, and the multi-agent patterns. Internalising it is how the agentic engineering framework activates for this project.
2. **Skim [`docs/specs/00-project-index.md`](docs/specs/00-project-index.md)** to know what exists in `docs/specs/`.
3. **For the specific task you're about to do, read the relevant spec in `docs/specs/`** before writing any code or making any decision.

Don't skip these. The framework only works when it's loaded; loading it is one read each.

---

## What this repo is

{{ONE_PARAGRAPH_DESCRIPTION}}

Authoritative specs live in `docs/`:

- Project index: [`docs/specs/00-project-index.md`](docs/specs/00-project-index.md)
- Architecture decisions: [`docs/specs/05-cross-cutting-architecture-decisions.md`](docs/specs/05-cross-cutting-architecture-decisions.md)
- Agent conventions: [`docs/conventions/agent-working-conventions.md`](docs/conventions/agent-working-conventions.md)
- ADRs: `docs/adr/`

Update specs in the same PR as the code change that motivates them. They live in git for a reason.

---

## Stack (locked — don't change without an ADR + decision-log entry)

{{STACK_DESCRIPTION}}

Polyglot deviation, if any, is documented in [`docs/specs/05-cross-cutting-architecture-decisions.md`](docs/specs/05-cross-cutting-architecture-decisions.md). Any deviation requires an entry in that doc with date and rationale.

---

## Commands

```bash
{{COMMANDS_BLOCK}}
```

---

## Code conventions

- TypeScript strict mode (or language equivalent). No `any`.
- Validate at every external boundary (HTTP, queue, SDK call) — Zod or equivalent.
- Migrations are forward-only.
- Tests co-located with source; integration tests in `__tests__/`.
- Commits: conventional commits format.
- **Default to writing no comments.** Add a comment only when the *why* is non-obvious. Don't explain *what* — well-named identifiers do that.
- Don't add error handling, fallbacks, or validation for impossible scenarios. Trust internal code; only validate at boundaries.

---

## Working pattern

For non-trivial tasks, follow Plan-Build-Review:

1. **Plan** — read the relevant spec in `docs/specs/`; produce a numbered plan; surface architectural decisions back to the human (don't pick silently)
2. **Build** — execute the plan; tests + lint + typecheck must pass
3. **Review** — self-review or hand to a Reviewer agent; verify against the spec

For exploration: use a read-only Scout/Explore subagent to keep orchestrator context clean.

---

## Multi-agent rules

When dispatching multiple agents in one Claude Code session:

- **All `Task` calls go in one message** for true parallelism
- **Each agent gets a self-contained prompt** — point at the relevant spec file in `docs/specs/`, don't summarise
- **Specify the report shape** — every agent returns a structured report (status / output / open questions)
- **Phase gate** — Scout ✓ → Plan ✓ → Build ✓ → Review ✓; don't shortcut

See [`docs/conventions/agent-working-conventions.md`](docs/conventions/agent-working-conventions.md) for the full convention reference.

---

## Definition of done (every task)

1. Tests, lint, typecheck pass locally and in CI
2. The relevant spec in `docs/specs/` is updated if the task altered any decision in it
3. Any new convention is recorded in the relevant package's `CLAUDE.md` or `docs/conventions/`
4. The change is summarised in the PR description, not in code comments

---

## Anti-patterns to actively prevent

- **Isolated Prompting** — never start a task without loading the relevant spec into context
- **Tool Proliferation** — never spawn parallel agents without an integration plan
- **Design Delegation** — humans lead on design decisions; agents implement
- **Testing Theatre** — tests must hit real code paths

---

## Where things live

| Concern | Path |
|---|---|
| All specs | `docs/specs/` |
| Conventions | `docs/conventions/` |
| Repo-local ADRs | `docs/adr/` |
| Slash commands, agent defs, hooks | `.claude/` |
{{PROJECT_SPECIFIC_PATHS}}

---

## When in doubt

1. Read the spec for the area you're working in (`docs/specs/`)
2. If still ambiguous, surface the question — don't pick silently
3. If you discover a learning, record it in the relevant `CLAUDE.md` or convention doc
