#!/bin/bash
# Sync Claude Code skills to GitHub with clear commit messages

set -e

SKILLS_DIR="$HOME/.claude/skills"
cd "$SKILLS_DIR"

# Check if there are any changes
if [[ -z $(git status -s) ]]; then
    echo "✓ No changes to sync"
    exit 0
fi

# Show what will be committed
echo "📝 Changes to sync:"
git status -s
echo ""

# Get commit message from argument or prompt for it
if [ -n "$1" ]; then
    COMMIT_MSG="$1"
else
    echo "Enter commit message (describe what changed and why):"
    read -r COMMIT_MSG

    if [ -z "$COMMIT_MSG" ]; then
        echo "❌ Commit message required. Aborting."
        exit 1
    fi
fi

# Stage all changes
git add -A

# Create full commit message with co-author
FULL_MSG="$COMMIT_MSG

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

git commit -m "$FULL_MSG"

# Push to GitHub
git push origin main

echo ""
echo "✓ Skills synced to GitHub: https://github.com/shaigh-lz/claude-skills"
