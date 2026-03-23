#!/bin/bash
# Sync Claude Code skills to GitHub

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

# Stage all changes
git add -A

# Commit with timestamp
COMMIT_MSG="Update skills - $(date '+%Y-%m-%d %H:%M:%S')

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"

git commit -m "$COMMIT_MSG"

# Push to GitHub
git push origin main

echo "✓ Skills synced to GitHub: https://github.com/shaigh-lz/claude-skills"
