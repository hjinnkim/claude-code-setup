# /setup-project

Extend /init with global settings and knowledge system.

## Pre-check

1. Verify ~/.claude/CLAUDE.md exists
   - If not: "~/.claude/CLAUDE.md not found. Clone claude-code-setup and run ./setup.sh"
2. Check if .claude/knowledge/ already exists
   - If yes: Ask "Knowledge exists. (A) Update structure only (B) Full reset (C) Cancel"

## Steps

### Step 1: Merge global settings
- Read ~/.claude/CLAUDE.md (global)
- Read .claude/CLAUDE.md (project, from /init)
- Append global settings AFTER /init content:
  ```
  <!-- GLOBAL SETTINGS START -->
  [Who I Am, How I Work, How Claude Should Behave, Knowledge Structure, Anti-Patterns, Additional Context]
  <!-- GLOBAL SETTINGS END -->
  ```
- If markers already exist: replace content between markers only
- Never modify /init-generated content above markers

### Step 2: Create .claude/knowledge/
- Copy from ~/.claude/templates/ to .claude/knowledge/:
  - INDEX.md
  - project-structure.md
  - optimization-findings.md
  - command-registry.md
  - paper-references.md
  - error-solutions.md
  - tech-decisions.md
- Create directories:
  - .claude/knowledge/papers/
  - .claude/commands/

### Step 3: Fill project-structure.md
Use /init analysis to fill:
- Directory layout (tree structure)
- Entry points (main files)
- Key modules (core functionality)
- Build/run commands (from package.json, Makefile, etc.)
- Dependencies (from requirements.txt, package.json, etc.)

### Step 4: Report
```
✅ Setup complete!

Created:
- .claude/CLAUDE.md (merged with global settings)
- .claude/knowledge/ (7 files)
- .claude/commands/

Next steps:
1. Review .claude/knowledge/project-structure.md
2. Start working - Claude will learn and update knowledge files
```
