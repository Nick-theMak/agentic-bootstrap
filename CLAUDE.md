# CLAUDE.md (root)

> Agent instructions for the **agentic-bootstrap** repo itself. This is meta — agents working *in* this repo are improving the framework that other projects inherit.

---

## What this repo is

A reusable starter for any AI-assisted software project. It encodes:

- The 12 leverage points framework
- Named anti-patterns
- Canonical prompt templates
- Multi-agent patterns (Plan-Build-Review, Orchestrator + Scouts, Phase Gating, etc.)
- Templates for `CLAUDE.md`, project specs, ADRs, phase plans, agent conventions
- A bootstrap script (`scripts/init.sh`) that scaffolds a new project from these templates

**This repo's purpose is to be copied from, not built upon.** Other projects clone the relevant pieces; this repo stays small, focused, and stable.

---

## Working in this repo

When making changes, ask: **does this improve the framework that all future projects inherit?**

If yes → make the change here.
If it's project-specific → make it in the project's own repo.

The line: changes to `docs/principles/` and `templates/` propagate to every future project. Changes to `docs/usage/` propagate to anyone who reads the docs. Be careful what gets in.

---

## Stack

This repo is documentation + a bash script. No build, no compile, no tests beyond shellcheck on `init.sh`.

```bash
shellcheck scripts/init.sh    # lint the bootstrap script
shfmt -d scripts/init.sh      # check formatting
```

---

## Conventions specific to this repo

- **Templates use `{{PLACEHOLDER}}` for substitution.** The init script does the replacement; don't introduce other syntaxes.
- **Principles docs are stable.** Changes to `docs/principles/leverage-points.md` etc. are major-version events.
- **Templates accept project-specific extension.** When customising in a downstream project, add sections; don't rewrite the structure.
- **Versioning is semver.** Major = breaking change to template structure. Minor = new template or principle. Patch = wording / typo.

---

## Definition of done

When changing this repo:

1. The relevant principle / template / script is updated
2. The change is reflected in `docs/usage/how-to-use.md` if it changes how a user interacts with the bootstrap
3. The CHANGELOG (when added) records the change
4. The version in any pinned references is bumped if appropriate

---

## Anti-patterns to actively prevent

- **Project-specific content sneaking into templates.** Templates must be generic. If you find yourself adding "the SWMS workflow needs..." you're in the wrong repo.
- **Over-templating.** Not everything benefits from being a template. The right granularity: enough structure that consistent shape emerges; not so much that every project ends up identical.
- **Premature crystallisation.** A pattern needs to appear in 2+ projects before it earns a place here. Otherwise it's project-specific bias dressed as a standard.

---

## Surface decisions back when

- A new pattern emerges across projects (add it to `docs/principles/` or `templates/`)
- A template structure feels constraining for legitimate reasons (revisit the structure)
- The framework conflicts with new model capabilities (the principles need updating)

---

## Where things live

| Concern | Path |
|---|---|
| The framework itself | `docs/principles/` |
| Templates copied per project | `templates/` |
| User-facing docs | `docs/usage/` |
| Bootstrap script | `scripts/init.sh` |

---

## Cross-links

- The principle hierarchy: `docs/principles/leverage-points.md`
- The named anti-patterns: `docs/principles/anti-patterns.md`
- How to use this bootstrap: `docs/usage/how-to-use.md`
