---
title: How to use agentic-bootstrap
type: usage
last_updated: 2026-04-29
---

# How to use agentic-bootstrap

> Bootstrap a new project, or add the agentic-bootstrap conventions to an existing one.

---

## Quickest path: init script

```bash
# From the agentic-bootstrap repo root
./scripts/init.sh my-new-project

# Move into the new project
cd my-new-project

# (Optional) Add TypeScript scaffolding
pnpm create turbo@latest .

# Initial commit
git add . && git commit -m "chore: bootstrap from agentic-bootstrap"
```

The script:

1. Creates a directory at `./my-new-project/`
2. Copies the `templates/` and `docs/principles/` content into it
3. Creates the canonical folder structure: `docs/specs/`, `docs/conventions/`, `docs/adr/`, `.claude/commands/`, `.claude/hooks/`
4. Replaces `{{PROJECT_NAME}}` placeholders
5. Initialises git

After running, you have a docs-first project shape ready for code.

---

## Manual path

If you don't want to use the script (or you're adding conventions to an existing project):

### 1. Copy the docs structure

```bash
# from agentic-bootstrap root
mkdir -p ../my-project/docs/{specs,conventions,adr}
cp templates/CLAUDE-template.md ../my-project/CLAUDE.md
cp templates/agent-working-conventions.md ../my-project/docs/conventions/
cp templates/architecture-decisions-template.md ../my-project/docs/specs/05-cross-cutting-architecture-decisions.md
cp templates/spec-template.md ../my-project/docs/specs/00-project-index.md
cp templates/adr-template.md ../my-project/docs/adr/0000-template.md
```

### 2. Fill in the placeholders

Open the copied files. Replace:

- `{{PROJECT_NAME}}` — your project's actual name
- `{{ONE_PARAGRAPH_DESCRIPTION}}` — what the project does
- `{{STACK_DESCRIPTION}}` — your locked stack (after deciding it)
- `{{COMMANDS_BLOCK}}` — your project's command set
- `{{PROJECT_SPECIFIC_PATHS}}` — the layout of your repo

### 3. Make the cross-cutting decisions

Open `docs/specs/05-cross-cutting-architecture-decisions.md`. Work through:

1. Stack choice
2. Identity model
3. Data residency
4. Build sequencing
5. Multi-tenancy
6. Privacy model
7. Observability
8. CI/CD
9. Versioning
10. External integrations

Don't decide ones that don't apply. Decide the ones that do *consciously*, not by default.

### 4. Write the project index

`docs/specs/00-project-index.md` is the entry point. Use the spec template; describe what the project is and how it fits together.

### 5. Customise the conventions

Open `docs/conventions/agent-working-conventions.md`. The leverage hierarchy and anti-patterns stay constant. Customise:

- The agent role catalogue (which roles your project uses)
- Project-specific forbidden patterns
- Project-specific learnings (initially empty)

### 6. First spec, first ADR, first phase plan

When you're ready to start work:

- Write spec 01 for the first piece of architecture: `docs/specs/01-<feature>.md`
- Write your first ADR: `docs/adr/0001-<decision>.md`
- Write your first phase plan: `docs/specs/06-phase-0-<name>.md`

These three artifacts let agents start work with full context.

---

## Adopting conventions in an existing project

If a project already exists and you want to add agentic-bootstrap conventions:

1. Add `docs/` if it doesn't exist; populate from `templates/`
2. Write a `CLAUDE.md` at the root using the template
3. Document existing architectural decisions retroactively (it's worth the time)
4. Add `.claude/` directory with at least one slash command and the leverage points reference

Don't try to retrofit everything in one PR. Add the docs structure first; the rest accretes.

---

## Customising templates per project

Templates are *starting points*, not mandates. Customise:

- **CLAUDE.md** — project-specific stack, commands, conventions
- **Agent conventions** — project-specific agent roles, forbidden patterns, learnings
- **Spec template** — adjust sections if your domain needs them (e.g. add Compliance for regulated work)

Don't customise:

- **The leverage hierarchy** — it's the framework, not project-specific
- **The named anti-patterns** — same
- **The prompt template structure** — same

If you find yourself customising the latter, you've discovered a generic improvement — contribute it back to agentic-bootstrap.

---

## Updating an existing project from a new bootstrap version

When agentic-bootstrap releases a new version:

1. Read the [CHANGELOG](../../CHANGELOG.md)
2. Decide which changes apply to your project
3. Cherry-pick from `templates/` — copy the changed sections, integrate carefully
4. Don't blindly overwrite your project's customisations

The bootstrap is a *starting point* and a *patterns library*. Versions update; projects diverge gracefully.

---

## Contributing patterns back

If you discover a pattern in a project that should propagate to all new projects:

1. Identify which template/principle should change
2. PR to agentic-bootstrap with the proposed change
3. Bump version, update changelog
4. Optionally re-sync existing projects

This is how the framework evolves: from real project experience back into the bootstrap.

---

## Cross-links

- [Bootstrap script](../../scripts/init.sh)
- [Templates](../../templates/)
- [Principles](../principles/)
- [Repo overview](../../README.md)
