# Roadmap

> What `agentic-bootstrap` covers today, what could be added next, and what's deliberately deferred until real-project experience reveals what actually matters.

---

## Versioning policy

- **v0.x.y** — pre-1.0; structure may shift between minor versions. Use it; expect to re-sync downstream projects when minor versions tick over.
- **v1.0** — declared when the bootstrap has been used across 3+ projects, the structure has stabilised, and the principles section is "complete enough" for a generalist audience.
- **Major bumps after 1.0** — breaking changes to template structure or principle organisation only.
- **Minor bumps** — new templates, new principles, new patterns.
- **Patch bumps** — wording, typos, clarifications.

Each release tags `vX.Y.Z` on the main branch and updates [CHANGELOG.md](CHANGELOG.md).

---

## What v0.1 covers

The load-bearing foundation, derived from the agentic engineering body of practice:

### Principles (`docs/principles/`)

- ✅ The 12 Leverage Points (Donella Meadows-style hierarchy applied to agentic systems)
- ✅ 7 named anti-patterns (Isolated Prompting, Tool Proliferation, Testing Theatre, Metric Over-Aggregation, Design Delegation, Post-Hoc Learning, Automated Optimization Before Understanding)
- ✅ Canonical 7-section prompt template
- ✅ Multi-agent patterns: Plan-Build-Review, Orchestrator + Scouts, Phase Gating, Single-Message Parallelism, Spec as Shared Artifact, Self-Improving Slash Commands

### Templates (`templates/`)

- ✅ Root `CLAUDE.md` template with placeholders
- ✅ Per-package `CLAUDE.md` template
- ✅ 10-section project spec template
- ✅ MADR-format ADR template
- ✅ Phase plan template
- ✅ Cross-cutting architecture decisions template
- ✅ Generic agent working conventions

### Tooling

- ✅ `scripts/init.sh` — bash bootstrap that scaffolds a new project from templates
- ✅ Folder structure conventions: `docs/{specs,conventions,adr,principles}`, `.claude/{commands,hooks,agents}`, `apps/`, `packages/`

### Coverage of the agentic engineering book

Solid coverage of foundational chapters (1, 2, 4, 7, 9). Partial coverage of operational chapters (8). Deliberately no coverage of practitioner-toolkit chapter (10) — that's tool-specific and doesn't belong in a generic bootstrap.

---

## v0.2 candidates (next likely additions)

These are partial gaps in v0.1 that have known shapes and would likely propagate to all future projects.

### `docs/principles/`

- **`tool-design.md`** — tool/function schema design, when to use internal tools vs MCP vs CLI wrappers, poka-yoke constraints (book ch 5)
- **`skills-and-progressive-disclosure.md`** — when to encode behaviour as a skill vs a slash command vs a separate agent (book ch 5.5, 7.7)
- **`harness-engineering.md`** — guides + sensors framework, computational vs inferential controls (book ch 6)
- **`knowledge-evolution.md`** — explicit workflow for capturing learnings from session → CLAUDE.md → bootstrap (book ch 8.6)

### `templates/`

- **`AGENTS.md`** — alias for `CLAUDE.md` to support cross-tool (Cursor, codex, Continue) using the emerging standard filename; init script writes both files to the same content
- **`evals-template.md`** — per-project evals harness scaffold (Husain's three-level hierarchy)
- **`runbook-template.md`** — operational runbook for fleets / production agentic services
- **`slash-command-template.md`** — canonical structure for `.claude/commands/*.md`

### Tooling

- **Cross-tool `init.sh` mode** — flag that emits `AGENTS.md` + Cursor `.cursor/` + Continue `.continue/` configs alongside `.claude/`
- **`scripts/sync.sh`** — re-sync a downstream project to a newer bootstrap version, preserving customisations
- **`scripts/check.sh`** — lint a downstream project against the bootstrap conventions (does it have a 05 architecture decisions doc? Are conventions current?)

---

## v0.3+ — deeper operational content (deferred)

These benefit from real-project experience. Don't add until at least one project has been through the operational phase and produced learnings worth generalising.

### Operations (book ch 8)

- **`debugging-agents.md`** — systematic debugging when an agent goes wrong: context audit, prompt inspection, tool replay
- **`cost-and-latency.md`** — model tier optimisation, batching, cache-warming, when caching pays
- **`production-concerns.md`** — observability stack, alerting, on-call for agent fleets
- **`operating-agent-swarms.md`** — running multi-agent fleets in production, kill-switches, runaway agent detection

### Patterns (book ch 7)

- **ReAct Pattern** — relevant if extending beyond pure code work
- **Human-in-the-Loop Pattern** — explicit treatment beyond "humans review PRs"
- **Expert Swarm Pattern** — niche; add when a project needs it

### Mental models (book ch 9)

- **Prompt Maturity Model** — explicit ladder for L1 → L5 prompts
- **Execution Topologies** — when to fan out, when to chain, when to round-trip
- **Design as Bottleneck** — making the human design review the rate-limiting step deliberately, not by accident

---

## What's deliberately not in scope

- **Tool-specific tooling** — the `os-eco/` ecosystem is great, but it's a specific implementation. The bootstrap stays runtime-agnostic in concept.
- **Project-specific examples** — examples should live in actual project repos, not in the bootstrap. The bootstrap shows *structure*, not *content*.
- **A single "blessed" stack** — the bootstrap suggests defaults but doesn't enforce them. Each project's `05 - architecture-decisions.md` makes the call.
- **A web UI / GUI** — bash + markdown is enough. If a UI emerges, it lives in a sibling repo.

---

## Coverage matrix vs the book

For full transparency, here's where v0.1 sits against each book chapter:

| Book chapter | Coverage |
|---|---|
| 1. Foundations (12 leverage points, anti-patterns) | ✅ Full |
| 2. Prompt (types, structuring, language) | ✅ Full |
| 3. Model (selection, behaviour, multi-model) | ⚠️ Embedded in agent role catalogue |
| 4. Context (fundamentals, strategies, patterns) | ⚠️ Context-budget covered; advanced patterns deferred |
| 5. Tool Use (design, restrictions, scaling, skills) | ❌ v0.2 candidate |
| 6. Harnesses (the stack, control system, security) | ❌ v0.2 candidate |
| 7. Patterns (Plan-Build-Review, Orchestrator, Self-Improving Experts, Phase Gating, etc.) | ✅ Major patterns covered; ReAct / HITL / Expert Swarm deferred |
| 8. Practices (Debugging, Evaluation, Cost, Production, Knowledge Evolution, Swarms) | ❌ v0.3+ |
| 9. Mental Models (Pit of Success, Specs as Code, Context as Code, Software Factories) | ⚠️ Implicit; could be made explicit in v0.2 |
| 10. Practitioner Toolkit (Claude Code, ADK, IDEs, Frameworks) | 🚫 Out of scope (tool-specific) |

---

## Contribution rules (for adding to the bootstrap)

When you discover a pattern in a real project that should propagate:

1. **Wait until it appears in 2+ projects** — one project's bias isn't a generic pattern
2. **Identify which file changes** — principle vs template vs tooling
3. **Make the change minimally** — don't bundle multiple ideas into one PR
4. **Update the CHANGELOG** — note the addition under the next minor version
5. **Tag a release when the changes accumulate** — typically every 1–2 months, or when a downstream project needs the new content

What *not* to add:

- Project-specific examples (they go in the project, not the bootstrap)
- Tool-specific configurations (they go in the project's `.claude/` or `.cursor/`, not in the bootstrap)
- Speculative patterns ("this might be useful someday") — wait for the second project that needs it

---

## Cross-links

- [Bootstrap README](README.md) — overview and quick-start
- [Changelog](CHANGELOG.md) — release history
- [Principles](docs/principles/) — the framework reference (stable)
- [Templates](templates/) — copy-and-fill files
