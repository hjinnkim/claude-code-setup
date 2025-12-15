# Claude Code Agentic Environment Setup Pipeline

## Overview

This pipeline helps users set up a Claude Code environment that:
- Learns, remembers, and optimizes automatically
- No need to memorize commands
- Caches analysis results for reuse
- Automates repeated tasks
- Understands natural language intent and executes accordingly

---

## Pipeline Structure

```
Phase 1: Computer Environment Setup (~/.claude/)
         ↓
Phase 2: Project Environment Setup (project/.claude/)
```

---

# Phase 1: Computer Environment Setup

## File Structure

```
~/.claude/
├── CLAUDE.md                          ← Global rules
├── commands/
│   └── setup-project.md               ← Project initialization command
└── templates/
    ├── INDEX.md
    ├── project-structure.md
    ├── optimization-findings.md
    ├── command-registry.md
    ├── paper-references.md
    ├── error-solutions.md
    └── tech-decisions.md
```

---

## 1. Global CLAUDE.md

**Location:** `~/.claude/CLAUDE.md`

```markdown
# Global Context for Claude Code

## 1. Who I Am
- Role: [from interview Q1]
- Stack: [from interview Q2]
- Tasks: [from interview Q3]
- Focus: [from interview Q4]
- Language: [from interview Q0]

---

## 2. How I Work

### 2.1 Interaction Style
- Ambiguous requests: [from interview Q6]
- Multiple approaches: [from interview Q7]
- Web search: [from interview Q5]
- Large changes: [from interview Q8]

### 2.2 Optimization Priority
- Primary: [from interview Q2]
- Secondary: [from interview Q2]
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
[User-defined context that doesn't fit above sections]
```

---

## 2. Interview Template

**Purpose:** Gather user preferences to generate customized CLAUDE.md

```markdown
# Claude Code Environment Setup Interview

## How This Interview Works

- Questions will be asked **one at a time**
- Wait for your answer before moving to the next question
- You can ask clarifying questions anytime
- You can ask about something else entirely
- You can revisit previous decisions
- Say "next" or answer to proceed

## 인터뷰 진행 방식

- 질문은 **한 번에 하나씩** 진행됩니다
- 답변 후 다음 질문으로 넘어갑니다
- 언제든 질문할 수 있습니다
- 다른 주제에 대해 질문할 수도 있습니다
- 이전 결정을 다시 검토할 수 있습니다
- "다음" 또는 답변으로 진행합니다

---

## Part 0: Language Setting

### Question 0-1: Interview Language

What language do you want to use for this interview?

- English
- Korean
- Other: ___

This only affects the interview process. Claude Code language settings will be asked next.

### 질문 0-1: 인터뷰 언어

이 인터뷰를 어떤 언어로 진행할까요?

- 영어 (English)
- 한국어 (Korean)
- 기타: ___

이 설정은 인터뷰 과정에만 적용됩니다. Claude Code 언어 설정은 다음 질문에서 진행합니다.

[WAIT FOR ANSWER BEFORE PROCEEDING]

---

### Question 0-2: Claude Code Language Preference
What language do you want to use with Claude Code?

**Global setting** (applies to all projects by default):
- Default (follow system setting)
- Both English
- Both Korean
- Custom: ___

**Project setting** (override for each project):
- Same as global
- English, but Korean when I ask for translation
- Korean for explanations, English for code/comments
- Custom: ___

You can set separately for input (your requests) and output (Claude's responses).

Example answers:
- "Global: Default, Project: English, but Korean when I ask for translation"
- "Global: Both English, Project: Same as global"
- "Global: Input English, Output Korean"

This can be changed anytime by:
- Telling Claude in conversation
- Editing ~/.claude/CLAUDE.md (global)
- Editing project/.claude/CLAUDE.md (project)

→ This determines how Claude communicates with you.

Any questions about this, or anything else before we continue?

[WAIT FOR ANSWER BEFORE PROCEEDING]

---

## Part 1: Profile

### Question 1: Project Type
What type of projects do you mainly work on?

Select all that apply (or describe your own):
- ML/AI Research
- Web Development
- Backend Systems
- Data Engineering
- Other: ___

Example answers:
- "ML/AI Research" → 딥러닝/머신러닝 연구 중심
- "Web Development, Backend Systems" → 풀스택 개발
- "ML/AI Research with focus on computer vision" → 특정 분야 명시

→ This determines how Claude analyzes code and what perspectives to prioritize.

Any questions about this, or anything else before we continue?

[WAIT FOR ANSWER BEFORE PROCEEDING]

---

### Question 2: Languages & Frameworks
What languages and frameworks do you use?

Select all that apply (or describe your own):
- Python, PyTorch, JAX
- TypeScript, React, Node.js
- C++, CUDA
- Other: ___

Example answers:
- "C++, Python, PyTorch, JAX" → ML 연구 + 성능 최적화
- "Python, PyTorch" → 순수 ML/DL 개발
- "TypeScript, React, Node.js, PostgreSQL" → 웹 풀스택

→ This determines Claude's default suggestions and code style.

Any questions about this, or anything else before we continue?

[WAIT FOR ANSWER BEFORE PROCEEDING]

---

### Question 3: Task Types
What tasks will you do with Claude Code?

Select all that apply (or describe your own):
- Code analysis/review
- Bug fixing
- New feature implementation
- Paper code reproduction
- Optimization/improvement discovery
- Other: ___

Example answers:
- "All of the above" → 다양한 작업 수행
- "Code analysis, bug fixing, optimization discovery" → 유지보수 중심
- "All + search web for suitable options when finding improvements" → 최신 기법 탐색 포함

→ This determines what proactive suggestions Claude makes.

Any questions about this, or anything else before we continue?

[WAIT FOR ANSWER BEFORE PROCEEDING]

---

### Question 4: Optimization Direction
What do you prioritize when optimizing?

Rank by priority (or describe your own):
1. ___
2. ___
3. ___

Options:
- Memory efficiency
- Compute speed
- Code readability
- Other: ___

Example answers:
- "1. Memory efficiency, 2. Compute speed" → GPU VRAM 제한 환경
- "Memory and compute equally" → 균형 잡힌 최적화
- "1. Code readability, 2. Memory efficiency" → 유지보수성 우선

→ This determines what Claude suggests first when recommending improvements.

Any questions about this, or anything else before we continue?

[WAIT FOR ANSWER BEFORE PROCEEDING]

---

### Question 5: Web Search Usage
Do you want Claude to search the web for resources?

- A) Search automatically when needed
- B) Ask before searching

Example answers:
- "A" → 시간 절약 우선, 자동으로 최신 정보 찾길 원함
- "B" → 불필요한 검색 방지, 내가 통제하고 싶음
- "B, 단 에러 메시지는 자동 검색" → 평소엔 확인, 에러는 빠른 해결 원함

→ This determines how Claude handles external information lookup.

Any questions about this, or anything else before we continue?

[WAIT FOR ANSWER BEFORE PROCEEDING]

---

## Part 2: Interaction Style

### Question 6: Ambiguous Requests
When your request is unclear, how should Claude respond?

- A) Refine internally and execute immediately
- B) Ask for clarification first
- C) Show refined interpretation, then execute
- D) Proactive analysis → present options with specific file/module → execute after selection

Example answers:
- "A" → 속도 우선, Claude 판단 신뢰
- "B" → 정확성 우선, 확인 후 진행
- "D" → 구체적인 옵션 보고 선택하고 싶음
- "D, with specific file and module references" → 파일/모듈 단위로 명확하게

→ This determines how Claude handles vague instructions.

Any questions about this, or anything else before we continue?

[WAIT FOR ANSWER BEFORE PROCEEDING]

---

### Question 7: Multiple Approaches
When there are several ways to solve a problem:

- A) Choose the best one and execute
- B) Present 2-3 options and ask for selection
- C) Recommend 1 + briefly mention alternatives

Example answers:
- "A" → 빠른 실행 우선, Claude 판단 신뢰
- "B" → 옵션 비교 후 내가 결정하고 싶음
- "C" → 추천받되 대안도 알고 싶음
- "B, with trade-offs explained for each option" → 트레이드오프 명확히 비교

→ This determines how Claude presents solutions.

Any questions about this, or anything else before we continue?

[WAIT FOR ANSWER BEFORE PROCEEDING]

---

### Question 8: Change Handling
How should Claude handle code changes?

**Before any change, show:**
- Affected files: [Always / Large changes only / Never]
- Diff preview: [Always / Large changes only / Never]
- Line numbers: [Yes / No]

**For large changes:**
- A) Execute directly
- B) Present plan + expected impact first, wait for confirmation

Example answers:
- "Affected files: Always, Diff: Always, Line numbers: Yes, Large changes: B"
  → 모든 변경 전에 정확히 뭐가 바뀌는지 확인하고 싶음
- "Affected files: Large changes only, Diff: Large changes only, Line numbers: No, Large changes: B"
  → 작은 변경은 빠르게, 큰 변경만 신중하게
- "Affected files: Never, Diff: Never, Large changes: A"
  → 속도 우선, Claude 판단 신뢰

→ This determines how Claude communicates and handles changes.

Any questions about this, or anything else before we continue?

[WAIT FOR ANSWER BEFORE PROCEEDING]

---

## Part 3: Final

### Question 9: Additional Context
Is there any other context you want Claude to know that wasn't covered?

Examples:
- Specific coding conventions
- Preferred libraries to use/avoid
- Project constraints (hardware, deadlines)
- Team conventions
- Anything else

Example answers:
- "Skip" → 나중에 필요하면 추가
- "Always use type hints in Python" → 코드 스타일 선호
- "Avoid using pandas, prefer polars" → 라이브러리 선호
- "I have 24GB VRAM GPU" → 하드웨어 제약 (프로젝트별로 다르면 프로젝트 설정에서)

You can skip if nothing comes to mind. You can always add later by editing ~/.claude/CLAUDE.md

[WAIT FOR ANSWER BEFORE PROCEEDING]

---

## Summary

After completing this interview, the following will be created:

```
~/.claude/
├── CLAUDE.md              ← Global rules based on your answers
├── templates/             ← Templates for project setup
└── commands/
    └── setup-project.md   ← Project initialization command
```

Ready to generate your environment?
```

---

## 3. Knowledge Templates

### 3.1 INDEX.md

**Location:** `~/.claude/templates/INDEX.md`

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

### 3.2 project-structure.md

**Location:** `~/.claude/templates/project-structure.md`

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

### 3.3 optimization-findings.md

**Location:** `~/.claude/templates/optimization-findings.md`

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

### 3.4 command-registry.md

**Location:** `~/.claude/templates/command-registry.md`

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

### 3.5 paper-references.md

**Location:** `~/.claude/templates/paper-references.md`

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

### 3.6 error-solutions.md

**Location:** `~/.claude/templates/error-solutions.md`

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

### 3.7 tech-decisions.md

**Location:** `~/.claude/templates/tech-decisions.md`

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

## 4. setup-project.md Command

**Location:** `~/.claude/commands/setup-project.md`

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

```
# Project Context for Claude Code

## Import Global Rules
@~/.claude/CLAUDE.md

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
```

## Step 3: Create Knowledge Structure

Create .claude/knowledge/ with these files:

INDEX.md:
```
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

project-structure.md:
- Fill with analysis results from Step 1

optimization-findings.md, command-registry.md, paper-references.md, error-solutions.md, tech-decisions.md:
- Create with empty templates from ~/.claude/templates/

## Step 4: Report Summary

Report what was created:
- .claude/CLAUDE.md
- .claude/knowledge/ (list all files)
- Any issues or suggestions
```

---

# Phase 2: Project Environment Setup

## Resulting Structure

After running `/setup-project` in a project:

```
project/
├── .claude/
│   ├── CLAUDE.md                      ← Project-specific context
│   └── knowledge/
│       ├── INDEX.md
│       ├── project-structure.md       ← Filled from analysis
│       ├── optimization-findings.md   ← Empty template
│       ├── command-registry.md        ← Empty template
│       ├── paper-references.md        ← Empty template
│       ├── error-solutions.md         ← Empty template
│       └── tech-decisions.md          ← Empty template
└── [project files]
```

---

## Project CLAUDE.md Structure

```markdown
# Project Context for Claude Code

## Import Global Rules
@~/.claude/CLAUDE.md

## 1. Project Overview
[Auto-generated from analysis]

## 2. Tech Stack
[Auto-generated from analysis]

## 3. Architecture
[Auto-generated from analysis]

## 4. Build/Run Commands
[Auto-generated from analysis]

## 5. Project-specific Rules
[User fills as needed]
```

---

# Usage Flow

## First Time Setup (New Computer)

```
1. Run interview (using interview-template.md)
         ↓
2. Generate ~/.claude/CLAUDE.md based on answers
         ↓
3. Create ~/.claude/templates/ with all templates
         ↓
4. Create ~/.claude/commands/setup-project.md
         ↓
Done! Global environment ready.
```

## Each New Project

```
1. Navigate to project directory
         ↓
2. Run: /setup-project
         ↓
3. Claude analyzes project + creates .claude/ structure
         ↓
4. Start working with full agentic support
```

---

# Example: Filled Global CLAUDE.md

Based on the interview conducted in this session:

```markdown
# Global Context for Claude Code

## 1. Who I Am
- Role: ML/AI Researcher
- Focus: Memory & compute optimization
- Stack: C++, Python, PyTorch, JAX
- Language: English

---

## 2. How I Work

### 2.1 Interaction Style
- Ambiguous requests: Proactive analysis → present options with specific file/module → execute after selection
- Multiple approaches: Present 2-3 options → ask for selection
- Web search: Ask "Should I search the web?" → wait for confirmation
- Large changes: Present plan + expected impact first → execute after confirmation

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
[User-defined context that doesn't fit above sections]
```

---

# Design Principles

## 1. Efficiency First
- INDEX.md prevents reading all files
- Knowledge caching prevents repeated analysis
- Command registry automates repeated tasks

## 2. User Context Preservation
- Global CLAUDE.md captures user identity
- Project CLAUDE.md captures project context
- Interview captures preferences accurately

## 3. Proactive but Controlled
- Claude suggests optimizations proactively
- But asks before web search
- And presents plans before large changes

## 4. Flexible
- Subagents created on demand, not preemptively
- Additional context section for edge cases
- All settings adjustable via conversation
