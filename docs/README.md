# agentic-bootstrap docs

> Reference material for AI-assisted software engineering. Read these once to internalise the framework; reference them whenever you're designing a new project.

---

## Structure

| Folder | Contents |
|---|---|
| `principles/` | The framework: 12 leverage points, anti-patterns, prompt template, multi-agent patterns |
| `usage/` | How to use this bootstrap — bootstrap a new project, customise templates, contribute back |

---

## Reading order

If you're new to agentic engineering:

1. [The 12 Leverage Points](principles/leverage-points.md) — the framework that organises everything else
2. [Named Anti-Patterns](principles/anti-patterns.md) — what corrupts each leverage point
3. [Canonical Prompt Template](principles/prompt-template.md) — how to write prompts that work
4. [Multi-Agent Patterns](principles/multi-agent-patterns.md) — how multiple agents compose

If you're starting a new project:

1. [How to use](usage/how-to-use.md) — bootstrap script + manual setup
2. Browse `templates/` to see what's available
3. Run `./scripts/init.sh <project-name>`

---

## Living document

This is a body of practice, not a static spec. Update when:

- A new pattern emerges across multiple projects
- A new failure mode shows up that needs naming
- A template can be improved with a real-project lesson

Bump version, push tag, optionally re-sync existing projects.

---

## Cross-links

- The bootstrap repo overview: [../README.md](../README.md)
- Templates: [../templates/](../templates/)
- Bootstrap script: [../scripts/init.sh](../scripts/init.sh)
