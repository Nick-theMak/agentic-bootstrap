# Changelog

All notable changes to `agentic-bootstrap` are documented in this file.

The format is loosely based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html). See [ROADMAP.md](ROADMAP.md) for the versioning policy.

---

## [Unreleased]

Items being staged for the next release. See [ROADMAP.md](ROADMAP.md) for v0.2 candidates.

---

## [0.1.0] — 2026-04-29

Initial release. The load-bearing foundation distilled from the agentic engineering body of practice.

### Added

#### Principles (`docs/principles/`)

- `leverage-points.md` — the 12 Leverage Points framework (Donella Meadows-style hierarchy applied to agentic systems), with per-level guidance and examples
- `anti-patterns.md` — 7 named anti-patterns (Isolated Prompting, Tool Proliferation, Testing Theatre, Metric Over-Aggregation, Design Delegation, Post-Hoc Learning, Automated Optimization Before Understanding) with corruption mappings to leverage points
- `prompt-template.md` — canonical 7-section agent prompt structure with frontmatter conventions, role-specific variations, and stage hierarchy (L1–L5)
- `multi-agent-patterns.md` — Plan-Build-Review, Orchestrator + Scouts, Phase Gating, Single-Message Parallelism, Spec as Shared Artifact, Self-Improving Slash Commands

#### Templates (`templates/`)

- `CLAUDE-template.md` — root `CLAUDE.md` template with `{{PLACEHOLDER}}` substitution
- `package-CLAUDE-template.md` — per-package `CLAUDE.md` with critical-invariants, seams, and don't-do sections
- `spec-template.md` — 10-section project spec (TL;DR, Problem, Users, Foundation, MVP scope, Architecture sketch, Open questions, Risks, Success criteria, Cross-links)
- `adr-template.md` — MADR-format Architecture Decision Record template
- `phase-plan-template.md` — time-boxed action plan with week-by-week, definition-of-done, and concurrency-opportunities sections
- `architecture-decisions-template.md` — cross-cutting architecture decisions doc with decision-log table
- `agent-working-conventions.md` — generic agent working conventions document

#### Tooling

- `scripts/init.sh` — bash bootstrap script that scaffolds a new project from templates, replaces placeholders, copies principles for in-project reference, initialises git, and emits a starter `README.md` + `docs/README.md` + `.gitignore`

#### Documentation

- `README.md` — repo overview, quick-start, layout, versioning, contribution path
- `_README.md` — vault-internal notes (not part of the public repo)
- `CLAUDE.md` — agent instructions for working *in* the bootstrap repo (meta)
- `docs/README.md` — docs entry point
- `docs/usage/how-to-use.md` — full usage guide (init script + manual setup + customisation + adopting in existing projects + updating across versions)
- `ROADMAP.md` — coverage analysis, v0.2 / v0.3 candidates, contribution rules

### Coverage notes

- Foundational chapters of the agentic engineering book (1, 2, partial 3 + 4, 7, partial 9) are well-represented
- Operational chapters (5, 6, 8) and remaining patterns (ReAct, HITL, Expert Swarm) are deferred to v0.2 / v0.3 — see [ROADMAP.md](ROADMAP.md)
- Practitioner-toolkit chapter (10) is deliberately out of scope (tool-specific)

### Known limitations

- Templates lean Claude-Code-flavoured (file named `CLAUDE.md`, references to `Task` tool and `Explore` subagent type, `.claude/` directory). Concepts are runtime-agnostic; templates require ~15-minute search-and-replace to port to other tools (Cursor, Continue, Cody, codex). v0.2 is expected to add an `AGENTS.md` alias for cross-tool support.
- `init.sh` uses Python for cross-platform string substitution. Pure-bash version is feasible if a target environment lacks Python; not currently a known constraint.
- No `LICENSE` file yet. Add MIT (or chosen license) when pushing to GitHub.

---

[Unreleased]: https://github.com/Nick-theMak/agentic-bootstrap/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/Nick-theMak/agentic-bootstrap/releases/tag/v0.1.0
