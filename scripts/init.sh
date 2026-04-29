#!/usr/bin/env bash
#
# init.sh — bootstrap a new agentic project from agentic-bootstrap templates
#
# Usage: ./scripts/init.sh <project-name> [target-dir]
#   project-name    Required. The new project's name (used as folder name and
#                   substituted into {{PROJECT_NAME}} placeholders).
#   target-dir      Optional. Parent directory for the new project. Defaults to
#                   the parent of agentic-bootstrap.
#
# Example:
#   ./scripts/init.sh oseco-projects ~/code

set -euo pipefail

# ---------- args ----------

PROJECT_NAME="${1:-}"
if [[ -z "$PROJECT_NAME" ]]; then
  echo "usage: $0 <project-name> [target-dir]" >&2
  exit 1
fi

# Validate project name (lowercase letters, numbers, hyphens only)
if [[ ! "$PROJECT_NAME" =~ ^[a-z][a-z0-9-]*$ ]]; then
  echo "error: project name must be lowercase letters, numbers, hyphens only" >&2
  echo "       got: $PROJECT_NAME" >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BOOTSTRAP_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
TARGET_DIR="${2:-$(dirname "$BOOTSTRAP_ROOT")}"
PROJECT_DIR="$TARGET_DIR/$PROJECT_NAME"

if [[ -e "$PROJECT_DIR" ]]; then
  echo "error: $PROJECT_DIR already exists" >&2
  exit 1
fi

# ---------- create structure ----------

echo "→ Creating $PROJECT_DIR"
mkdir -p "$PROJECT_DIR"/{docs/{specs,conventions,adr,principles},packages,apps,.claude/{commands,hooks,agents}}

# ---------- copy templates ----------

echo "→ Copying templates"
cp "$BOOTSTRAP_ROOT/templates/CLAUDE-template.md" "$PROJECT_DIR/CLAUDE.md"
cp "$BOOTSTRAP_ROOT/templates/agent-working-conventions.md" "$PROJECT_DIR/docs/conventions/agent-working-conventions.md"
cp "$BOOTSTRAP_ROOT/templates/architecture-decisions-template.md" "$PROJECT_DIR/docs/specs/05-cross-cutting-architecture-decisions.md"
cp "$BOOTSTRAP_ROOT/templates/spec-template.md" "$PROJECT_DIR/docs/specs/00-project-index.md"
cp "$BOOTSTRAP_ROOT/templates/adr-template.md" "$PROJECT_DIR/docs/adr/0000-template.md"
cp "$BOOTSTRAP_ROOT/templates/phase-plan-template.md" "$PROJECT_DIR/docs/specs/06-phase-0-template.md"

# Copy principles for reference (not editable templates, but useful in-repo reference)
cp "$BOOTSTRAP_ROOT/docs/principles/leverage-points.md" "$PROJECT_DIR/docs/principles/leverage-points.md"
cp "$BOOTSTRAP_ROOT/docs/principles/anti-patterns.md" "$PROJECT_DIR/docs/principles/anti-patterns.md"
cp "$BOOTSTRAP_ROOT/docs/principles/prompt-template.md" "$PROJECT_DIR/docs/principles/prompt-template.md"
cp "$BOOTSTRAP_ROOT/docs/principles/multi-agent-patterns.md" "$PROJECT_DIR/docs/principles/multi-agent-patterns.md"

# ---------- replace placeholders ----------

echo "→ Replacing placeholders"
DATE=$(date +%Y-%m-%d)

# Use a portable in-place sed (works on macOS and Linux)
find "$PROJECT_DIR" -type f \( -name "*.md" -o -name "*.yml" -o -name "*.json" \) -print0 |
  while IFS= read -r -d '' file; do
    # Use Python for cross-platform reliability
    python3 -c "
import sys
path = sys.argv[1]
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()
content = content.replace('{{PROJECT_NAME}}', '$PROJECT_NAME')
content = content.replace('YYYY-MM-DD', '$DATE')
with open(path, 'w', encoding='utf-8') as f:
    f.write(content)
" "$file"
  done

# ---------- write a starter docs/README.md ----------

cat > "$PROJECT_DIR/docs/README.md" <<EOF
# $PROJECT_NAME docs

Authoritative source for design, architecture, and convention docs.

## Structure

- \`specs/\` — Project specs (numbered 00–06+)
- \`conventions/\` — Agent working conventions
- \`adr/\` — Architecture Decision Records (repo-local technical choices)
- \`principles/\` — Reference material from agentic-bootstrap (the 12 leverage points, anti-patterns, prompt templates, multi-agent patterns)

## Reading order for new contributors

1. \`specs/00-project-index.md\` — what this project is
2. \`specs/05-cross-cutting-architecture-decisions.md\` — the decisions that shape every part
3. \`specs/06-phase-0-template.md\` — what's being built right now (rename to phase-0-actual.md)
4. \`conventions/agent-working-conventions.md\` — how agents should work here

## Updating these docs

- Specs change in PRs alongside code
- Decisions get logged with date in \`05-cross-cutting-architecture-decisions.md\`
- ADRs accumulate in \`adr/\`
- Conventions evolve via PR review
EOF

# ---------- write a starter README ----------

cat > "$PROJECT_DIR/README.md" <<EOF
# $PROJECT_NAME

> [One-line pitch — fill this in.]

[Longer description — what does this project do, who's it for.]

## Stack

[Locked stack — see \`docs/specs/05-cross-cutting-architecture-decisions.md\`.]

## Quick start

\`\`\`bash
pnpm install
pnpm dev
pnpm test
\`\`\`

## Docs

All design, architecture, and conventions live in \`docs/\`. Start at \`docs/README.md\`.

Generated from [agentic-bootstrap](https://github.com/Nick-theMak/agentic-bootstrap).
EOF

# ---------- gitignore ----------

cat > "$PROJECT_DIR/.gitignore" <<EOF
# dependencies
node_modules/
.pnpm-store/

# build output
dist/
build/
.next/
.turbo/

# env
.env
.env.local
.env.*.local

# logs
*.log

# misc
.DS_Store
.vscode/settings.json
.idea/
EOF

# ---------- initialise git ----------

echo "→ Initialising git"
cd "$PROJECT_DIR"
git init -q
git add .
git commit -q -m "chore: bootstrap from agentic-bootstrap

Generated using agentic-bootstrap. See docs/principles/ for the
framework reference, docs/specs/ for project-specific architecture."

# ---------- done ----------

echo ""
echo "✓ Bootstrapped $PROJECT_NAME at $PROJECT_DIR"
echo ""
echo "Next steps:"
echo "  cd $PROJECT_DIR"
echo "  # 1. Decide stack and fill in docs/specs/05-cross-cutting-architecture-decisions.md"
echo "  # 2. Update CLAUDE.md with project-specific stack and commands"
echo "  # 3. Replace docs/specs/00-project-index.md with the actual project description"
echo "  # 4. Optionally bootstrap TS monorepo: pnpm create turbo@latest ."
echo ""
