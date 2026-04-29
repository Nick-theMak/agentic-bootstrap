# CLAUDE.md — packages/{{PACKAGE_NAME}}

> {{ONE_LINE_PURPOSE}}. Implements [`docs/specs/{{RELEVANT_SPEC}}`](../../docs/specs/{{RELEVANT_SPEC}}).

<!--
Per-package CLAUDE.md template from agentic-bootstrap.
Replace placeholders. Each package gets its own CLAUDE.md so agents working in a
specific package have the local context they need without navigating to root.

Keep this tight (~60–100 lines). The root CLAUDE.md covers monorepo-wide rules.
This file covers package-specific specifics: critical invariants, local dev,
package-specific conventions, the seams.
-->

---

## What this package does

- {{BULLET_LIST_OF_RESPONSIBILITIES}}

---

## Architecture (sketch, if non-obvious)

```
[only include if the architecture is non-obvious from reading the code]
```

---

## Critical invariants (don't break these)

1. {{INVARIANT_1}}
2. {{INVARIANT_2}}
3. ...

If a change appears to break any of these, stop and surface to the human — do not "fix it cleverly." This is the kind of decision that gets a spec entry or ADR.

---

## Local dev

```bash
# from repo root
pnpm --filter {{PACKAGE_NAME}} dev
pnpm --filter {{PACKAGE_NAME}} test --watch
pnpm --filter {{PACKAGE_NAME}} build
```

Optional: `docker compose -f docker-compose.dev.yml up -d` for dependencies (Postgres, NATS, etc.).

---

## Tests

- **Unit:** Vitest, co-located `*.test.ts`. Cover [WHAT].
- **Integration:** `__tests__/integration/`. Spin up [DEPENDENCIES]; exercise [FLOWS].
- **Contract** (if SDK package): contract tests against the live server.

---

## Conventions specific to this package

- {{PACKAGE_SPECIFIC_RULE_1}}
- {{PACKAGE_SPECIFIC_RULE_2}}
- ...

Examples of what goes here:
- "All routes use Fastify's typed schema feature with Zod validation"
- "Errors thrown from the X path are typed (`XError`, `YError`); never plain `Error`"
- "No `console.log`; use the package logger"

---

## Where the seams are

| Outbound | Goes to | Format |
|---|---|---|
| ... | ... | ... |

| Inbound | From | Validation |
|---|---|---|
| ... | ... | ... |

---

## Don't

- {{ANTI_PATTERN_SPECIFIC_TO_THIS_PACKAGE_1}}
- {{ANTI_PATTERN_SPECIFIC_TO_THIS_PACKAGE_2}}
- ...

Examples:
- "Don't add an UPDATE or DELETE migration on this table — ever."
- "Don't expose the HTTP layer to consumers. They use the SDK; that's the seam."

---

## Surface decisions back when

- A new {{X}} requires {{Y}}
- A performance bottleneck appears in {{Z}}
- {{OTHER_TRIGGERS}}

These are architectural calls that go in [`docs/specs/05-cross-cutting-architecture-decisions.md`](../../docs/specs/05-cross-cutting-architecture-decisions.md) or a new ADR — not silent commits.
