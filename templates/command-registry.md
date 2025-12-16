# Command Registry

## Structure
```
.claude/
├── commands/                 ← Actual command files
│   └── [command-name].md
└── knowledge/
    └── command-registry.md   ← Index (this file)
```

## Pending Patterns
Track repeated tasks here for cross-session persistence.
When count >= 3, suggest creating a command.

| Task Pattern | Count | Last Seen |
|--------------|-------|-----------|
| | | |

## Auto-detected Patterns
When a task is repeated 3+ times, suggest creating a command.

## Entry Format
```
### /command-name
- **Trigger**: [what task this automates]
- **Created**: [date]
- **Usage count**: [number]
- **File**: .claude/commands/[command-name].md
```

## Command File Template (for .claude/commands/*.md)
```markdown
# /command-name

[Description of what this command does]

## Steps
1. [step 1]
2. [step 2]
...
```

## Command Creation Workflow
1. Detect repeated task (3+ times)
2. Suggest command to user
3. If approved:
   - Create .claude/commands/[command-name].md
   - Add entry to this registry
4. Update usage count when command is used

## Registered Commands

<!-- Add entries below -->
