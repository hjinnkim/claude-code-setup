#!/bin/bash

# Claude Code Agentic Environment Setup
# Reads config.yaml and creates ~/.claude/ structure

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/config.yaml"
TEMPLATES_DIR="$SCRIPT_DIR/templates"
CLAUDE_DIR="$HOME/.claude"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════════════════════════╗"
echo "║     Claude Code Agentic Environment Setup                 ║"
echo "╚═══════════════════════════════════════════════════════════╝"
echo -e "${NC}"

# Check config exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo -e "${RED}❌ Error: config.yaml not found${NC}"
    echo "   Please create config.yaml first"
    exit 1
fi

# Check templates exist
if [ ! -d "$TEMPLATES_DIR" ]; then
    echo -e "${RED}❌ Error: templates/ directory not found${NC}"
    exit 1
fi

# Check if ~/.claude already exists
if [ -d "$CLAUDE_DIR" ]; then
    echo -e "${YELLOW}⚠️  ~/.claude/ already exists.${NC}"
    read -p "Overwrite? (y/N): " confirm
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        echo -e "${RED}❌ Setup cancelled.${NC}"
        exit 0
    fi
    BACKUP_DIR="$CLAUDE_DIR.backup.$(date +%Y%m%d%H%M%S)"
    echo -e "${YELLOW}Creating backup at $BACKUP_DIR${NC}"
    mv "$CLAUDE_DIR" "$BACKUP_DIR"

    # Warn if too many backups exist
    BACKUP_COUNT=$(ls -d "$HOME"/.claude.backup.* 2>/dev/null | wc -l | tr -d ' ')
    if [ "$BACKUP_COUNT" -gt 5 ]; then
        echo -e "${YELLOW}⚠️  You have $BACKUP_COUNT backups at ~/.claude.backup.*${NC}"
    fi
fi

echo -e "${GREEN}Creating ~/.claude/ structure...${NC}"

# Create directories
mkdir -p "$CLAUDE_DIR/commands"
mkdir -p "$CLAUDE_DIR/templates"

# Parse config.yaml and generate CLAUDE.md
# Using simple grep/sed since we can't rely on yq being installed

parse_yaml() {
    local key=$1
    grep "^$key:" "$CONFIG_FILE" | sed "s/^$key: *//" | sed 's/"//g' | sed "s/'//g"
}

parse_yaml_nested() {
    local parent=$1
    local key=$2
    sed -n "/^$parent:/,/^[a-z]/p" "$CONFIG_FILE" | grep "^  $key:" | sed "s/^  $key: *//" | sed 's/"//g' | sed "s/'//g"
}

parse_yaml_double_nested() {
    local parent=$1
    local child=$2
    local key=$3
    sed -n "/^$parent:/,/^[a-z_]*:/p" "$CONFIG_FILE" | sed -n "/^  $child:/,/^  [a-z]/p" | grep "^    $key:" | sed "s/^    $key: *//" | sed 's/"//g' | sed "s/'//g"
}

parse_yaml_list() {
    local key=$1
    sed -n "/^$key:/,/^[a-z]/p" "$CONFIG_FILE" | grep "^  -" | sed 's/^  - //' | sed 's/"//g' | sed "s/'//g" | tr '\n' ',' | sed 's/,$//' | sed 's/,/, /g'
}

# Extract values
ROLE=$(parse_yaml "role")
STACK=$(parse_yaml_list "stack")
TASKS=$(parse_yaml_list "tasks")
OPT_PRIMARY=$(parse_yaml_nested "optimization" "primary")
OPT_SECONDARY=$(parse_yaml_nested "optimization" "secondary")
LANGUAGE=$(parse_yaml "language")
WEB_SEARCH=$(parse_yaml_nested "interaction" "web_search")
AMBIGUOUS=$(parse_yaml_nested "interaction" "ambiguous_requests")
MULTI_APPROACH=$(parse_yaml_nested "interaction" "multiple_approaches")
AFFECTED_FILES=$(parse_yaml_double_nested "interaction" "change_handling" "affected_files")
DIFF_PREVIEW=$(parse_yaml_double_nested "interaction" "change_handling" "diff_preview")
LINE_NUMBERS=$(parse_yaml_double_nested "interaction" "change_handling" "line_numbers")
LARGE_CHANGES=$(parse_yaml_double_nested "interaction" "change_handling" "large_changes")
RESPONSE_STYLE=$(parse_yaml_nested "interaction" "response_style")
PROMPT_CORRECTION=$(parse_yaml_nested "interaction" "prompt_correction")
MODES_DETECTION=$(parse_yaml_nested "modes" "detection")
# Parse large_threshold (triple nested)
LARGE_THRESHOLD_FILES=$(sed -n '/^interaction:/,/^[a-z_]*:/p' "$CONFIG_FILE" | sed -n '/change_handling:/,/^  [a-z]/p' | sed -n '/large_threshold:/,/^    [a-z]/p' | grep "files:" | sed 's/.*files: *//')
LARGE_THRESHOLD_LINES=$(sed -n '/^interaction:/,/^[a-z_]*:/p' "$CONFIG_FILE" | sed -n '/change_handling:/,/^  [a-z]/p' | sed -n '/large_threshold:/,/^    [a-z]/p' | grep "lines:" | sed 's/.*lines: *//')
ADDITIONAL=$(parse_yaml "additional_context")

# Map ambiguous_requests letter to full text
case $AMBIGUOUS in
    A) AMBIGUOUS_TEXT="Refine internally and execute immediately" ;;
    B) AMBIGUOUS_TEXT="Ask for clarification first" ;;
    C) AMBIGUOUS_TEXT="Show refined interpretation, then execute" ;;
    D) AMBIGUOUS_TEXT="Proactive analysis → present options → execute after selection" ;;
    *) AMBIGUOUS_TEXT="$AMBIGUOUS" ;;
esac

# Map multiple_approaches letter to full text
case $MULTI_APPROACH in
    A) MULTI_TEXT="Choose the best one and execute" ;;
    B) MULTI_TEXT="Present 2-3 options → ask for selection" ;;
    C) MULTI_TEXT="Recommend 1 + briefly mention alternatives" ;;
    *) MULTI_TEXT="$MULTI_APPROACH" ;;
esac

# Generate CLAUDE.md
# ============================================
# SAFE-EDIT ZONE: Wording changes only. No logic changes allowed.
# Do NOT modify: $VARIABLE references, heredoc structure (EOF), or conditional logic.
# ============================================
cat > "$CLAUDE_DIR/CLAUDE.md" << EOF
# Global Context for Claude Code

## 1. Who I Am
- Role: $ROLE
- Stack: $STACK
- Tasks: $TASKS
- Focus: $OPT_PRIMARY (primary), $OPT_SECONDARY (secondary)
- Language: $LANGUAGE

---

## 2. How I Work

### 2.1 Interaction Style
- Ambiguous requests: $AMBIGUOUS_TEXT
- Multiple approaches: $MULTI_TEXT
- Web search: $WEB_SEARCH
- Response style: $RESPONSE_STYLE
- Prompt correction: $PROMPT_CORRECTION
- Change handling:
  - Affected files: $AFFECTED_FILES
  - Diff preview: $DIFF_PREVIEW
  - Line numbers: $LINE_NUMBERS
  - Large changes: $LARGE_CHANGES
  - Large threshold: $LARGE_THRESHOLD_FILES files / $LARGE_THRESHOLD_LINES lines

### 2.2 Optimization Priority
- Primary: $OPT_PRIMARY
- Secondary: $OPT_SECONDARY
- Always explain trade-offs

### 2.3 Response Structure
Default response order:
1. Conclusion / action summary
2. Executable command or code
3. (Optional) Brief rationale or caveats

### 2.4 Mode Keywords
User can set mode explicitly with \`[mode: xxx]\` keyword.
Current detection setting: $MODES_DETECTION

**Modes:**
- \`[mode: explore]\` - Read-only, no modification suggestions
- \`[mode: fix]\` - Minimal changes, minimal explanation
- \`[mode: explain]\` - Concept explanation, no code changes
- \`[mode: plan]\` - Design work, execute only after approval

**Detection behavior:**
- off: User must specify mode explicitly
- soft: Show \`[mode: fix suggested]\` and **execute immediately** without waiting. User can override in next message by saying "no" or \`[mode: X]\`
- auto: Apply detected mode silently

**Detection rules:**
| Pattern | Mode |
|---------|------|
| "what is", "how does", "where is", "show me", "find" | explore |
| "fix", "change", "update", "modify", "correct", "patch" | fix |
| "why", "describe", "explain", "help me understand" | explain |
| "implement", "add feature", "refactor", "redesign", "create new" | plan |

---

## 3. How Claude Should Behave

**Rule Priority:** When multiple rules apply: Mode → Response Length → Communication Rules → Feature-specific rules. On conflict, higher priority wins; if ambiguous (e.g., "fix and explain why"), ask user.

### 3.0 Core Behavior Rules

EOF

# Add response length rules based on setting
# CONDITIONAL ZONE: Edit wording inside 'EOF' blocks. Do NOT change if/else structure.
if [ "$RESPONSE_STYLE" = "detailed" ]; then
cat >> "$CLAUDE_DIR/CLAUDE.md" << 'EOF'
**Response Length:** Always include full explanation and rationale.
EOF
else
cat >> "$CLAUDE_DIR/CLAUDE.md" << 'EOF'
**Response Length:** Short by default. Expand only when asked.
EOF
fi

cat >> "$CLAUDE_DIR/CLAUDE.md" << EOF

**Prompt Correction:** (current: $PROMPT_CORRECTION)
- off: Always attempt to answer, never suggest correction
- gradual: Answer first. Suggest correction only when user says "not what I meant" or asks follow-up. If no feedback given, assume answer was acceptable
- strict: Suggest correction before answering any vague question

Correction format examples:
| Vague | Suggested |
|-------|-----------|
| "explain this" | "explain the auth flow in auth.py:login()" |
| "fix it" | "fix the null error in data_loader.py:142" |
| "what's wrong?" | "what's causing TypeError in utils.py:parse_json()?" |
| "make it faster" | "optimize memory in model.py:forward()" |
| "this doesn't work" | "debug why test_auth.py:test_login fails" |

> Tip: Specific prompts (right column) yield faster, more accurate results.

**Command Detection:**
- When imperative form detected ("do X", "make Y", "show Z"):
  - Prioritize result over explanation
  - Add brief explanation only if necessary after execution

**Context Planning:**
- Before reading files, judge first:
  - Is the full file really needed?
  - Would specific function/class suffice?
  - Is a summary enough?

### 3.1 Efficiency Rules

**Knowledge Lookup:**
1. Check if .claude/knowledge/ exists (if not, run /setup-project first)
2. Read .claude/knowledge/INDEX.md first
3. Identify relevant files from index
4. Read only those specific files
5. Never read all knowledge files at once

**Directory Search:**
1. Check project-structure.md first
2. Only search if structure unknown or outdated
3. Update project-structure.md after search

### 3.2 Learning Rules

**After completing any task:**
1. Check if result is reusable knowledge
2. If yes: save to appropriate knowledge file
3. Update INDEX.md with new entry

**Knowledge is reusable if:**
- Recurring error solved → error-solutions.md
- Measured performance improvement → optimization-findings.md
- Architecture-affecting decision → tech-decisions.md
- Paper referenced by project code → paper-references.md

**Knowledge types:**
- Optimization found → optimization-findings.md
- Error solved → error-solutions.md
- Technical decision → tech-decisions.md
- Paper referenced → .claude/knowledge/papers/[paper-name].md

**Paper reference workflow:**
1. Add metadata entry to paper-references.md
2. Create detailed summary in papers/[paper-name].md
3. Use template from paper-references.md for summary format

### 3.3 Automation Rules

**Task tracking (cross-session persistent):**
- Record repeated tasks in command-registry.md "Pending Patterns" section
- Format: | Task pattern | Count | Last seen |
- When count >= 3 → suggest automation

**Suggest command when:**
- Same file pattern accessed repeatedly
- Same analysis requested multiple times
- Same fix applied to multiple locations

**Command creation workflow:**
1. Detect repeated task (3+ times)
2. Suggest command to user
3. If approved:
   - Create .claude/commands/[command-name].md
   - Add entry to command-registry.md
4. Update usage count when command is used

### 3.4 Communication Rules

**Before any change:**
- Show affected files
- Show line numbers
- Show diff preview

**Before large changes:**
1. Present plan with expected impact
2. Wait for confirmation
3. Execute step by step

**When presenting options:**
- Include specific file/module references
- Explain trade-offs
- Recommend one option with reasoning

**Session Recovery:**
Trigger: 3+ completed steps OR file modifications made

After trigger:
- Ask: "Save progress? (y/n)"
- If yes: write to "Session Recovery" section in project-structure.md
  - Why project-structure.md: keeps context with project layout; avoids separate state file; ephemeral by design

On new session, if saved progress exists:
- Ask: "Previous session found. Show summary? (y/n)"
- After reload: clear the saved state

Summary format:
\`\`\`
[project]: [task]
Done: [completed items]
Next: [remaining items]
\`\`\`

### 3.5 Knowledge Maintenance

**Definitions (used in cleanup/automation):**
- Orphaned entry: references file/function no longer in codebase → remove in Phase 2
- Duplicate entry: same solution in different wording → merge in Phase 2
- Task similarity: same file pattern + action type → triggers automation in 3.3

**Phase 1: Monitoring**
- Track entry counts in each knowledge file

**Phase 2: Cleanup (50+ entries)**
- Suggest cleanup when any knowledge file > 50 entries
- Show: duplicates found, orphaned entries
- After approval: merge duplicates, remove orphaned, update INDEX.md

**Phase 3: Compression (100+ entries)**
- When any knowledge file > 100 entries: suggest compression
- Actions after approval:
  1. Create archive: .claude/knowledge/archive/[filename]-[year].md
  2. Compress old entries into Historical Summary
  3. Keep 20 most recent detailed entries
  4. Update INDEX.md

### 3.6 Request Refinement

**Apply to:**
- Multi-step tasks
- Optimization/analysis requests
- Ambiguous scope requests

**Skip for:**
- Single file edits
- Clear single commands
- Direct questions

**Refinement Process (when applied):**
1. Check user focus from "Who I Am"
2. Identify task type
3. Check knowledge for relevant context
4. Execute based on "Ambiguous requests" setting

---

## 4. Knowledge Structure

### Required Files
\`\`\`
.claude/knowledge/
├── INDEX.md
├── project-structure.md
├── optimization-findings.md
├── command-registry.md
├── paper-references.md
├── papers/                  ← Detailed paper summaries
├── error-solutions.md
└── tech-decisions.md
\`\`\`

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
$ADDITIONAL
EOF

# Copy templates
cp "$TEMPLATES_DIR/setup-project.md" "$CLAUDE_DIR/commands/"
cp "$TEMPLATES_DIR/INDEX.md" "$CLAUDE_DIR/templates/"
cp "$TEMPLATES_DIR/project-structure.md" "$CLAUDE_DIR/templates/"
cp "$TEMPLATES_DIR/optimization-findings.md" "$CLAUDE_DIR/templates/"
cp "$TEMPLATES_DIR/command-registry.md" "$CLAUDE_DIR/templates/"
cp "$TEMPLATES_DIR/paper-references.md" "$CLAUDE_DIR/templates/"
cp "$TEMPLATES_DIR/error-solutions.md" "$CLAUDE_DIR/templates/"
cp "$TEMPLATES_DIR/tech-decisions.md" "$CLAUDE_DIR/templates/"

echo ""
echo -e "${GREEN}✅ Setup complete!${NC}"
echo ""
echo "Created structure:"
echo "~/.claude/"
echo "├── CLAUDE.md"
echo "├── commands/"
echo "│   └── setup-project.md"
echo "└── templates/"
echo "    ├── INDEX.md"
echo "    ├── project-structure.md"
echo "    ├── optimization-findings.md"
echo "    ├── command-registry.md"
echo "    ├── paper-references.md"
echo "    ├── error-solutions.md"
echo "    └── tech-decisions.md"
echo ""
echo -e "${BLUE}Next steps:${NC}"
echo "1. cd /your/project"
echo "2. claude"
echo "3. /setup-project"
