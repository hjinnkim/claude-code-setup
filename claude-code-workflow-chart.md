# Claude Code Agentic Environment Workflow

## Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        CLAUDE CODE AGENTIC WORKFLOW                         │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│ PHASE 1: ENVIRONMENT SETUP (One-time)                                       │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   [Start] ──► [Interview] ──► [Generate ~/.claude/] ──► [Done]              │
│                   │                    │                                    │
│                   ▼                    ▼                                    │
│              Q0-1: Language       CLAUDE.md                                 │
│              Q0-2: Claude Lang    commands/setup-project.md                 │
│              Q1-Q10: Profile      templates/*                               │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│ PHASE 2: PROJECT SETUP (Per Project)                                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│   [Enter Project] ──► [/setup-project] ──► [Analysis] ──► [Generate]        │
│                                                │              │             │
│                                                ▼              ▼             │
│                                         Dir structure    .claude/          │
│                                         Tech stack       CLAUDE.md         │
│                                         Entry points     knowledge/*       │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

---

## Daily Usage Workflow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           USER REQUEST HANDLING                             │
└─────────────────────────────────────────────────────────────────────────────┘

                              ┌──────────────┐
                              │ User Request │
                              └──────┬───────┘
                                     │
                                     ▼
                    ┌────────────────────────────────┐
                    │ Is request clear?              │
                    └────────────────┬───────────────┘
                                     │
                    ┌────────────────┴────────────────┐
                    │                                 │
                    ▼                                 ▼
              ┌─────────┐                      ┌─────────────┐
              │  Clear  │                      │  Ambiguous  │
              └────┬────┘                      └──────┬──────┘
                   │                                  │
                   │                                  ▼
                   │                    ┌─────────────────────────┐
                   │                    │ Proactive Analysis      │
                   │                    │ - Identify actionable   │
                   │                    │ - Find specific files   │
                   │                    │ - Present 2-3 options   │
                   │                    └───────────┬─────────────┘
                   │                                │
                   │                                ▼
                   │                    ┌─────────────────────────┐
                   │                    │ User selects option     │
                   │                    └───────────┬─────────────┘
                   │                                │
                   └───────────────┬────────────────┘
                                   │
                                   ▼
                    ┌────────────────────────────────┐
                    │ Check Knowledge (INDEX.md)     │
                    └────────────────┬───────────────┘
                                     │
                    ┌────────────────┴────────────────┐
                    │                                 │
                    ▼                                 ▼
            ┌───────────────┐               ┌───────────────┐
            │ Found in      │               │ Not found     │
            │ knowledge     │               │               │
            └───────┬───────┘               └───────┬───────┘
                    │                               │
                    ▼                               ▼
            ┌───────────────┐               ┌───────────────┐
            │ Read specific │               │ Search/       │
            │ file only     │               │ Analyze       │
            └───────┬───────┘               └───────┬───────┘
                    │                               │
                    │                               ▼
                    │                       ┌───────────────┐
                    │                       │ Save to       │
                    │                       │ knowledge     │
                    │                       └───────┬───────┘
                    │                               │
                    └───────────────┬───────────────┘
                                    │
                                    ▼
                     ┌────────────────────────────────┐
                     │ Execute Task                   │
                     └────────────────┬───────────────┘
                                      │
                                      ▼
                     ┌────────────────────────────────┐
                     │ Is this a change/modification? │
                     └────────────────┬───────────────┘
                                      │
                     ┌────────────────┴────────────────┐
                     │                                 │
                     ▼                                 ▼
               ┌──────────┐                     ┌──────────┐
               │   Yes    │                     │    No    │
               └────┬─────┘                     └────┬─────┘
                    │                                │
                    ▼                                │
     ┌──────────────────────────────┐               │
     │ Show before execution:       │               │
     │ - Affected files             │               │
     │ - Line numbers               │               │
     │ - Diff preview               │               │
     └──────────────┬───────────────┘               │
                    │                                │
                    ▼                                │
     ┌──────────────────────────────┐               │
     │ User confirms?               │               │
     └──────────────┬───────────────┘               │
                    │                                │
          ┌─────────┴─────────┐                     │
          ▼                   ▼                     │
     ┌─────────┐        ┌─────────┐                │
     │   Yes   │        │   No    │                │
     └────┬────┘        └────┬────┘                │
          │                  │                      │
          │                  ▼                      │
          │           ┌─────────────┐              │
          │           │ Cancel/     │              │
          │           │ Modify      │              │
          │           └─────────────┘              │
          │                                        │
          └────────────────┬───────────────────────┘
                           │
                           ▼
            ┌────────────────────────────────┐
            │ Task Complete                  │
            └────────────────┬───────────────┘
                             │
                             ▼
            ┌────────────────────────────────┐
            │ Post-task actions:             │
            │ - Suggest optimizations?       │
            │ - Update knowledge files?      │
            │ - Repeated task? (3+)          │
            └────────────────────────────────┘
```

---

## Web Search Workflow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                            WEB SEARCH WORKFLOW                              │
└─────────────────────────────────────────────────────────────────────────────┘

     ┌───────────────────┐
     │ Need external     │
     │ information       │
     └─────────┬─────────┘
               │
               ▼
     ┌───────────────────┐
     │ "Should I search  │
     │ the web?"         │
     └─────────┬─────────┘
               │
     ┌─────────┴─────────┐
     │                   │
     ▼                   ▼
┌─────────┐        ┌─────────┐
│   Yes   │        │   No    │
└────┬────┘        └────┬────┘
     │                  │
     ▼                  ▼
┌───────────┐    ┌───────────────┐
│ Search    │    │ Use existing  │
│ web       │    │ knowledge     │
└─────┬─────┘    └───────────────┘
      │
      ▼
┌───────────────────┐
│ Present results   │
│ with sources      │
└─────────┬─────────┘
          │
          ▼
┌───────────────────┐
│ Save to           │
│ paper-references  │
│ (if relevant)     │
└───────────────────┘
```

---

## Large Change Workflow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          LARGE CHANGE WORKFLOW                              │
└─────────────────────────────────────────────────────────────────────────────┘

     ┌───────────────────┐
     │ Large change      │
     │ requested         │
     └─────────┬─────────┘
               │
               ▼
     ┌───────────────────────────────────┐
     │ Present Plan:                     │
     │ ┌───────────────────────────────┐ │
     │ │ 1. What will be changed       │ │
     │ │ 2. Affected files (list)      │ │
     │ │ 3. Expected impact            │ │
     │ │ 4. Potential risks            │ │
     │ └───────────────────────────────┘ │
     └─────────────┬─────────────────────┘
                   │
                   ▼
     ┌───────────────────┐
     │ User confirms?    │
     └─────────┬─────────┘
               │
     ┌─────────┴─────────┐
     │                   │
     ▼                   ▼
┌─────────┐        ┌─────────┐
│   Yes   │        │   No    │
└────┬────┘        └────┬────┘
     │                  │
     ▼                  ▼
┌───────────┐    ┌───────────────┐
│ For each  │    │ Cancel or     │
│ file:     │    │ modify plan   │
│           │    └───────────────┘
│ Show diff │
│ preview   │
│     │     │
│     ▼     │
│ Confirm?  │
│     │     │
│     ▼     │
│ Execute   │
└───────────┘
```

---

## Knowledge Maintenance Workflow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       KNOWLEDGE MAINTENANCE WORKFLOW                        │
└─────────────────────────────────────────────────────────────────────────────┘

                    ┌───────────────────┐
                    │ Knowledge file    │
                    │ entry added       │
                    └─────────┬─────────┘
                              │
                              ▼
                    ┌───────────────────┐
                    │ Check entry count │
                    └─────────┬─────────┘
                              │
          ┌───────────────────┼───────────────────┐
          │                   │                   │
          ▼                   ▼                   ▼
    ┌───────────┐      ┌───────────┐      ┌───────────┐
    │  < 50     │      │  50-99    │      │  100+     │
    │  entries  │      │  entries  │      │  entries  │
    └─────┬─────┘      └─────┬─────┘      └─────┬─────┘
          │                  │                  │
          ▼                  ▼                  ▼
    ┌───────────┐    ┌─────────────────┐  ┌─────────────────┐
    │ Continue  │    │ PHASE 2:        │  │ PHASE 3:        │
    │ normally  │    │ Cleanup         │  │ Compression     │
    └───────────┘    │                 │  │                 │
                     │ "50+ entries.   │  │ "100+ entries.  │
                     │ Cleanup?"       │  │ Compressing..." │
                     │                 │  │                 │
                     │ Show:           │  │ Show preview:   │
                     │ - Duplicates    │  │ - Summary       │
                     │ - Orphaned      │  │ - Recent 20     │
                     │                 │  │                 │
                     │ After approval: │  │ After approval: │
                     │ - Merge dupes   │  │ - Create archive│
                     │ - Remove orphan │  │ - Compress old  │
                     │ - Update INDEX  │  │ - Keep recent 20│
                     └─────────────────┘  └─────────────────┘
```

---

## Multiple Approaches Workflow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                       MULTIPLE APPROACHES WORKFLOW                          │
└─────────────────────────────────────────────────────────────────────────────┘

     ┌───────────────────┐
     │ Multiple ways to  │
     │ solve problem     │
     └─────────┬─────────┘
               │
               ▼
     ┌───────────────────────────────────┐
     │ Present 2-3 Options:              │
     │ ┌───────────────────────────────┐ │
     │ │ Option 1: [Method A]          │ │
     │ │ - Trade-off: ...              │ │
     │ │                               │ │
     │ │ Option 2: [Method B]          │ │
     │ │ - Trade-off: ...              │ │
     │ │                               │ │
     │ │ Option 3: [Method C]          │ │
     │ │ - Trade-off: ...              │ │
     │ └───────────────────────────────┘ │
     └─────────────┬─────────────────────┘
                   │
                   ▼
     ┌───────────────────┐
     │ User selects      │
     └─────────┬─────────┘
               │
               ▼
     ┌───────────────────┐
     │ Execute selected  │
     │ approach          │
     └─────────┬─────────┘
               │
               ▼
     ┌───────────────────┐
     │ Save decision to  │
     │ tech-decisions.md │
     │ (if significant)  │
     └───────────────────┘
```

---

## Command Registry Workflow

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                        COMMAND REGISTRY WORKFLOW                            │
└─────────────────────────────────────────────────────────────────────────────┘

     ┌───────────────────┐
     │ User requests     │
     │ task              │
     └─────────┬─────────┘
               │
               ▼
     ┌───────────────────────────────────┐
     │ Check command-registry.md         │
     └─────────────┬─────────────────────┘
                   │
     ┌─────────────┴─────────────┐
     │                           │
     ▼                           ▼
┌─────────────┐          ┌─────────────┐
│ Command     │          │ No matching │
│ exists      │          │ command     │
└──────┬──────┘          └──────┬──────┘
       │                        │
       ▼                        ▼
┌─────────────┐          ┌─────────────────────┐
│ Use         │          │ Execute task        │
│ existing    │          └──────┬──────────────┘
│ command     │                 │
└─────────────┘                 ▼
                         ┌─────────────────────┐
                         │ Track occurrence    │
                         └──────┬──────────────┘
                                │
                                ▼
                         ┌─────────────────────┐
                         │ 3+ occurrences?     │
                         └──────┬──────────────┘
                                │
                    ┌───────────┴───────────┐
                    │                       │
                    ▼                       ▼
              ┌───────────┐          ┌───────────┐
              │    Yes    │          │    No     │
              └─────┬─────┘          └─────┬─────┘
                    │                      │
                    ▼                      ▼
          ┌─────────────────┐      ┌─────────────┐
          │ "Create command │      │ Continue    │
          │ for this task?" │      │ normally    │
          └─────────────────┘      └─────────────┘
```

---

## File Structure Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          FILE STRUCTURE OVERVIEW                            │
└─────────────────────────────────────────────────────────────────────────────┘

~/.claude/                              (Global - applies to all projects)
├── CLAUDE.md                           ← Your identity & preferences
│   ├── Who I Am                          - Role, Stack, Language
│   ├── How I Work                        - Interaction style
│   ├── How Claude Should Behave          - Rules & behaviors
│   ├── Knowledge Structure               - File organization
│   └── Anti-Patterns                     - What NOT to do
│
├── commands/
│   └── setup-project.md                ← Project initialization
│
└── templates/                          ← Templates for new projects
    ├── INDEX.md
    ├── project-structure.md
    ├── optimization-findings.md
    ├── command-registry.md
    ├── paper-references.md
    ├── error-solutions.md
    └── tech-decisions.md


project/.claude/                        (Project-specific)
├── CLAUDE.md                           ← Project context
│   ├── Import Global Rules               @~/.claude/CLAUDE.md
│   ├── Language                          Project-specific language
│   ├── Project Overview                  From analysis
│   ├── Tech Stack                        From analysis
│   ├── Architecture                      From analysis
│   └── Project-specific Rules            User-defined
│
└── knowledge/                          ← Project knowledge cache
    ├── INDEX.md                        ← Always read first
    ├── project-structure.md            ← Directory layout
    ├── optimization-findings.md        ← Optimization results
    ├── command-registry.md             ← Task → command mapping
    ├── paper-references.md             ← Referenced papers
    ├── error-solutions.md              ← Error solutions
    ├── tech-decisions.md               ← Technical decisions
    └── archive/                        ← Compressed old entries
        └── [filename]-[year].md
```

---

## Quick Reference: Your Settings

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                         YOUR OPTIMIZED SETTINGS                             │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│ PROFILE                                                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│ Role:      ML/AI Researcher                                                 │
│ Stack:     C++, Python, PyTorch, JAX                                        │
│ Tasks:     Analysis, bug fix, implementation, paper reproduction,           │
│            optimization discovery                                           │
│ Focus:     Memory & compute optimization                                    │
│ Language:  Global: Default | Project: English (Korean on request)           │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│ INTERACTION STYLE                                                           │
├─────────────────────────────────────────────────────────────────────────────┤
│ Ambiguous requests:  Proactive analysis → options with file/module → select │
│ Multiple approaches: Present 2-3 options → ask for selection                │
│ Web search:          Ask before searching                                   │
│ Change handling:                                                            │
│   - Affected files:  Always show                                            │
│   - Diff preview:    Always show                                            │
│   - Line numbers:    Yes                                                    │
│   - Large changes:   Plan + impact first → confirm                          │
└─────────────────────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────────────────────┐
│ KNOWLEDGE MAINTENANCE                                                       │
├─────────────────────────────────────────────────────────────────────────────┤
│ < 50 entries:   Normal operation                                            │
│ 50+ entries:    Suggest cleanup (duplicates, orphaned)                      │
│ 100+ entries:   Auto-compress (summary + recent 20 + archive)               │
└─────────────────────────────────────────────────────────────────────────────┘
```
