# agentic-bootstrap

> A reusable starter for any AI-assisted software project. Captures the agentic engineering patterns (the 12 leverage points, named anti-patterns, prompt templates, multi-agent workflows) and packages them as a copy-and-go scaffold. Like `create-react-app`, but for projects designed from day one to be built by humans + agents working together.

---

## What this is

A template repo that gives you, on day one of any new project:

- A `CLAUDE.md` template with the conventions baked in
- A `docs/` structure (specs, conventions, ADRs) — the same shape every project should have
- The 12 leverage points framework as a permanent reference
- The named anti-patterns to actively prevent
- Canonical prompt templates for agent tasks
- Multi-agent patterns (Plan-Build-Review, Orchestrator, Phase Gating, Single-Message Parallelism)
- An `init.sh` script that bootstraps a new project from these templates with one command

It's the *operating system* layer for agentic projects. The actual project (oseco-projects, future-projects, anything) sits on top.

---

## Why it exists

Every new project re-invents the same setup work:

- "What goes in CLAUDE.md?"
- "How should specs be structured?"
- "What's the canonical prompt format for a builder agent?"
- "When do we use Opus vs Sonnet vs Haiku?"
- "What anti-patterns should I prevent?"

These are *generic* questions with *generic* good answers. This repo encodes them so the work happens once, propagates everywhere.

The patterns themselves come from:

- Agentic engineering principles (the leverage hierarchy and named anti-patterns)
- Production multi-agent workflows
- The os-eco ecosystem (mulch, seeds, canopy, sapling, overstory)
- Direct experience building agentically across multiple projects

This repo is the distillation. Every project starts here.

---

## How to use

### One-line bootstrap

```bash
# from anywhere
./scripts/init.sh my-new-project
cd my-new-project
pnpm create turbo@latest .   # add the actual TS scaffolding
```

### Manual

1. Clone this repo
2. Copy `templates/` and `docs/` into your new project
3. Fill in placeholders (`{{PROJECT_NAME}}`, `{{STACK}}`, etc.) in the copied files
4. Commit and start building

### Per-project customization

The templates are starting points. Customise:

- `CLAUDE.md` for project-specific stack and commands
- `docs/conventions/agent-working-conventions.md` for project-specific rules
- `docs/specs/05-cross-cutting-architecture-decisions.md` for the 6 cross-cutting calls every project must make

The *structure* should stay constant across projects. The *content* fills in per project.

---

## Repo layout

```
agentic-bootstrap/
├── README.md                              # this file
├── CLAUDE.md                              # for working in this repo
├── docs/
│   ├── README.md
│   ├── principles/
│   │   ├── leverage-points.md             # the 12 points framework
│   │   ├── anti-patterns.md               # 7 named anti-patterns
│   │   ├── prompt-template.md             # canonical agent prompt structure
│   │   └── multi-agent-patterns.md        # plan-build-review, orchestrator, etc.
│   └── usage/
│       └── how-to-use.md                  # bootstrap a new project
├── templates/
│   ├── CLAUDE-template.md                 # root CLAUDE.md
│   ├── package-CLAUDE-template.md         # per-package CLAUDE.md
│   ├── spec-template.md                   # 10-section project spec
│   ├── adr-template.md                    # MADR architecture decision record
│   ├── phase-plan-template.md             # action plan template
│   ├── architecture-decisions-template.md # cross-cutting decisions doc
│   └── agent-working-conventions.md       # generic conventions
└── scripts/
    └── init.sh                            # bootstrap script
```

---

## Versioning + roadmap

This repo follows semver. Breaking changes to template structure bump the major version. Projects should pin a version of agentic-bootstrap they were generated from, so updates are an opt-in re-sync rather than a surprise.

- **Current release:** v0.1.0 (initial)
- **Release history:** [CHANGELOG.md](CHANGELOG.md)
- **Roadmap + coverage analysis:** [ROADMAP.md](ROADMAP.md) — what's covered, what's planned, what's deferred, and how it maps to the agentic engineering book chapter-by-chapter

---

## When to update a generated project

When agentic-bootstrap releases a new version with a useful improvement:

1. Read the [changelog](CHANGELOG.md)
2. Decide if the change applies to your project
3. Either: cherry-pick the relevant template change, or run a re-sync script (when one exists — see [ROADMAP.md](ROADMAP.md))

Don't blindly update. Templates are starting points, not authority.

---

## Contributing patterns back

If you discover a pattern in a generated project that should propagate to all new projects, contribute it back to agentic-bootstrap:

1. Add to the relevant `docs/principles/` or `templates/` file
2. Bump the version
3. Note in the changelog

This is how the framework evolves: from real project experience back into the bootstrap.

---

## License

MIT. Use it. Fork it. Adapt it.

---

## Cross-links

- The framework these patterns come from: agentic engineering body of knowledge
- A concrete project built on these patterns: oseco-projects (sibling repo)
- Tooling: os-eco ecosystem (mulch, seeds, canopy, sapling, overstory) — CLI implementations of these same patterns
