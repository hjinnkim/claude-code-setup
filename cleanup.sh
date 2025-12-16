#!/bin/bash

# Claude Code Setup - Cleanup Script
# Removes ~/.claude/ and all backups for fresh testing

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${YELLOW}Claude Code Setup - Cleanup${NC}"
echo ""

# Check what exists
CLAUDE_EXISTS=false
BACKUP_COUNT=0

if [ -d "$HOME/.claude" ]; then
    CLAUDE_EXISTS=true
fi

BACKUP_COUNT=$(ls -d "$HOME"/.claude.backup.* 2>/dev/null | wc -l | tr -d ' ')

# Show current state
echo "Current state:"
if [ "$CLAUDE_EXISTS" = true ]; then
    echo "  ~/.claude/ exists"
else
    echo "  ~/.claude/ not found"
fi
echo "  $BACKUP_COUNT backup(s) found"
echo ""

# Nothing to clean
if [ "$CLAUDE_EXISTS" = false ] && [ "$BACKUP_COUNT" -eq 0 ]; then
    echo -e "${GREEN}Already clean. Nothing to remove.${NC}"
    exit 0
fi

# Confirm
read -p "Remove all? (y/N): " confirm
if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
    echo -e "${RED}Cancelled.${NC}"
    exit 0
fi

# Remove
if [ "$CLAUDE_EXISTS" = true ]; then
    rm -rf "$HOME/.claude"
    echo "  Removed ~/.claude/"
fi

if [ "$BACKUP_COUNT" -gt 0 ]; then
    rm -rf "$HOME"/.claude.backup.*
    echo "  Removed $BACKUP_COUNT backup(s)"
fi

echo ""
echo -e "${GREEN}Cleanup complete.${NC}"
