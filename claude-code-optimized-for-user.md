# Claude Code Agentic Environment - Optimized Version

Your interview answers applied.

---

# File 1: ~/.claude/CLAUDE.md

```markdown
# Global Context for Claude Code

## 1. Who I Am
- Role: ML/AI Researcher
- Stack: C++, Python, PyTorch, JAX
- Tasks: Code analysis, bug fixing, implementation, paper reproduction, optimization/improvement discovery
- Focus: Memory & compute optimization
- Language: Default (follow system setting)

---

## 2. How I Work

### 2.1 Interaction Style
- Ambiguous requests: Proactive analysis → present options with specific file/module → execute after selection
- Multiple approaches: Present 2-3 options → ask for selection
- Web search: Ask "Should I search the web?" → wait for confirmation
- Change handling:
  - Affected files: Always show
  - Diff preview: Always show
  - Line numbers: Yes
  - Large changes: Plan + impact first → confirm before execution

### 2.2 Optimization Priority
- Primary: Memory efficiency
- Secondary: Compute speed
- Always explain trade-offs

---

## 3. How Claude Should Behave

### 3.1 Efficiency Rules

**Knowledge Lookup:**
1. Read .claude/knowledge/INDEX.md first
2. Identify relevant files from index
3. Read only those specific files
4. Never read all knowledge files at once

**Directory Search:**
1. Check knowledge index for cached structure
2. If not found: search and cache to knowledge
3. Update INDEX.md with new entry

**Command Execution:**
1. Check command-registry.md for existing commands
2. If matching command exists: use it
3. If repeated task (3+ times): suggest creating command

### 3.2 Task Execution

**Before Any Task:**
1. Analyze and identify actionable items proactively
2. Check knowledge index for relevant context
3. Present options with specific file/module references

**After Task Completion:**
- Suggest optimizations (memory, compute) if applicable
- Update relevant knowledge files
- Update INDEX.md if new knowledge added

### 3.3 Optimization Focus

**When Analyzing Code, Prioritize:**
- Memory allocation patterns
- Computational bottlenecks
- GPU/CPU utilization
- Parallelization opportunities (PyTorch, JAX)

**When Suggesting Improvements:**
- Search web for state-of-the-art approaches (after confirmation)
- Compare trade-offs (speed vs memory vs complexity)
- Cite sources when available

### 3.4 Subagent Management
- Do not create subagents preemptively
- When a task pattern would benefit from a dedicated subagent:
  1. Explain why a subagent would be effective
  2. Describe what the subagent would do
  3. Ask if user wants to create it

### 3.5 Knowledge Maintenance

**Phase 1: Monitoring**
- Track entry counts in each knowledge file

**Phase 2: Cleanup (50+ entries)**
- When any knowledge file > 50 entries: suggest cleanup
- Show: duplicates found, orphaned entries (deleted files)
- Actions after approval: merge duplicates, remove orphaned entries
- Update INDEX.md

**Phase 3: Compression (100+ entries)**
- When any knowledge file > 100 entries: suggest compression
- Show: compression preview (summary + recent count)
- Actions after approval:
  1. Create archive: .claude/knowledge/archive/[filename]-[year].md
  2. Compress old entries into Historical Summary
  3. Keep 20 most recent detailed entries
  4. Update INDEX.md

---

## 4. Knowledge Structure

### Required Files
```
.claude/knowledge/
├── INDEX.md                 ← Always read first
├── project-structure.md     ← Directory layout
├── optimization-findings.md ← Discovered optimizations
├── command-registry.md      ← Task → Command mapping
├── paper-references.md      ← Papers/resources referenced
├── error-solutions.md       ← Errors + solutions
└── tech-decisions.md        ← Technical decisions + reasoning
```

### INDEX.md Format
| File | Summary | Tags |
|------|---------|------|
| [filename] | [one-line summary] | [tags] |

---

## 5. Anti-Patterns
- Read all knowledge files without checking index
- Search directories without checking cached structure
- Execute repeated tasks without suggesting automation
- Suggest optimizations without explaining trade-offs
- Execute large changes without presenting plan first
- Give vague suggestions without specific file/module references
- Create subagents without asking

---

## 6. Additional Context
[Add your own context here]
```

---

# File 2: ~/.claude/commands/setup-project.md

```markdown
Initialize this project with my agentic workflow:

## Step 1: Analyze Project

Analyze the project (like /init does):
- Directory structure
- Key files and entry points
- Tech stack and dependencies
- Build/run commands

## Step 2: Create Project CLAUDE.md

Create .claude/CLAUDE.md with this structure:

# Project Context for Claude Code

## Import Global Rules
@~/.claude/CLAUDE.md

## 0. Language
- English, but Korean when I ask for translation

## 1. Project Overview
[from analysis]

## 2. Tech Stack
[from analysis]

## 3. Architecture
[from analysis]

## 4. Build/Run Commands
[from analysis]

## 5. Project-specific Rules
[leave empty for user to fill]

## Step 3: Create Knowledge Structure

Create .claude/knowledge/ with these files from templates:
- INDEX.md
- project-structure.md (fill from Step 1 analysis)
- optimization-findings.md (empty template)
- command-registry.md (empty template)
- paper-references.md (empty template)
- error-solutions.md (empty template)
- tech-decisions.md (empty template)

## Step 4: Report Summary

Report what was created:
- .claude/CLAUDE.md
- .claude/knowledge/ (list all files)
- Any issues or suggestions
```

---

# File 3: ~/.claude/templates/INDEX.md

```markdown
# Knowledge Index

## How to Use
1. Claude reads this file FIRST
2. Identify relevant files by Tags
3. Read only those files

## Index

| File | Summary | Tags |
|------|---------|------|
| project-structure.md | Directory layout, entry points | structure, navigation |
| optimization-findings.md | Performance improvements discovered | optimization, memory, compute |
| command-registry.md | Repeated tasks → command mappings | commands, automation |
| paper-references.md | Papers and resources referenced | papers, references |
| error-solutions.md | Errors encountered and solutions | errors, debugging |
| tech-decisions.md | Technical decisions and reasoning | decisions, architecture |

## Last Updated
[auto-updated by Claude]
```

---

# File 4: ~/.claude/templates/project-structure.md

```markdown
# Project Structure

## Overview
[Brief description of project]

## Entry Points
| File | Purpose |
|------|---------|
| | |

## Key Directories
| Directory | Purpose |
|-----------|---------|
| | |

## Core Modules
| File | Purpose |
|------|---------|
| | |

## Last Updated
[auto-updated by Claude]
```

---

# File 5: ~/.claude/templates/optimization-findings.md

```markdown
# Optimization Findings

## Template

### [Title]
- Date: 
- File: 
- Type: [memory/compute/both]
- Change: 
- Result: 
- Trade-off: 

---

## Findings

[Empty - Claude will add entries here]
```

---

# File 6: ~/.claude/templates/command-registry.md

```markdown
# Command Registry

## How to Use
1. Before executing a task, check if matching pattern exists
2. If exists, use the command automatically
3. If new repeated task (3+), add entry here

## Registry

| Task Pattern | Command | Trigger Keywords |
|--------------|---------|------------------|
| | | |

## Pending (not yet created)

| Task Pattern | Occurrences |
|--------------|-------------|
| | |
```

---

# File 7: ~/.claude/templates/paper-references.md

```markdown
# Paper References

## Template

### [Paper Title]
- Source: [URL]
- Key insight: 
- Applied in: [file path]
- Date added: 

---

## References

[Empty - Claude will add entries here]
```

---

# File 8: ~/.claude/templates/error-solutions.md

```markdown
# Error Solutions

## Template

### [Error Title]
- Error: [error message]
- Context: [when it occurred]
- Root cause: 
- Solution: 
- File: [file path]
- Date: 

---

## Solutions

[Empty - Claude will add entries here]
```

---

# File 9: ~/.claude/templates/tech-decisions.md

```markdown
# Technical Decisions

## Template

### [Decision Title]
- Decision: 
- Reason: 
- Alternatives rejected: 
- Context: 
- Date: 

---

## Decisions

[Empty - Claude will add entries here]
```

---

# Setup Instructions

## Step 1: Create Directory Structure

```bash
mkdir -p ~/.claude/commands
mkdir -p ~/.claude/templates
```

## Step 2: Create Files

Copy each file above to its location:

```
~/.claude/
├── CLAUDE.md                          ← File 1
├── commands/
│   └── setup-project.md               ← File 2
└── templates/
    ├── INDEX.md                       ← File 3
    ├── project-structure.md           ← File 4
    ├── optimization-findings.md       ← File 5
    ├── command-registry.md            ← File 6
    ├── paper-references.md            ← File 7
    ├── error-solutions.md             ← File 8
    └── tech-decisions.md              ← File 9
```

## Step 3: Verify

Open Claude Code and run:
```
/help
```

You should see `setup-project` in the command list.

## Step 4: Use in Projects

Navigate to any project and run:
```
/setup-project
```

Claude will analyze the project and create the .claude/ structure.

---

# Quick Reference

## Your Settings

| Setting | Value |
|---------|-------|
| Role | ML/AI Researcher |
| Focus | Memory & compute optimization |
| Stack | C++, Python, PyTorch, JAX |
| Language | English |
| Ambiguous requests | Proactive analysis → options → selection |
| Multiple approaches | Present 2-3 options |
| Web search | Ask before searching |
| Large changes | Present plan first |

## Commands

| Command | Purpose |
|---------|---------|
| `/setup-project` | Initialize project with agentic workflow |

## Knowledge Files

| File | Purpose |
|------|---------|
| INDEX.md | File lookup index |
| project-structure.md | Directory layout |
| optimization-findings.md | Optimization results |
| command-registry.md | Task automation |
| paper-references.md | Paper references |
| error-solutions.md | Error solutions |
| tech-decisions.md | Decision records |
