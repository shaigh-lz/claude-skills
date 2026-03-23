# Claude Code Skills

Custom skills for Claude Code CLI to automate workflows and enhance productivity.

**Repository:** https://github.com/shaigh-lz/claude-skills

## Skills

### bizfilings-status
Generates comprehensive weekly status reports for the BIZFILINGS Core API project by:
- Querying Jira for epic and story progress
- Calculating completion metrics and identifying blockers
- Updating a Google Doc with formatted markdown report

**Usage:** `/bizfilings-status`

**Configuration:** Requires `~/.claude/bizfilings-pm-config.json` with Jira and Google Docs settings.

## Installation

To use these skills in your Claude Code environment:

1. Clone this repository:
   ```bash
   git clone https://github.com/shaigh-lz/claude-skills.git ~/.claude/skills
   ```

2. Ensure any required configuration files are in place

3. Invoke skills using `/skill-name` in Claude Code

## Syncing Updates

To push skill updates to GitHub with a clear commit message:

```bash
# With message as argument
~/.claude/skills/sync.sh "Add new feature X to improve Y"

# Or run interactively (will prompt for message)
~/.claude/skills/sync.sh
```

**Commit Message Guidelines:**
- Describe **what** changed and **why**
- Be specific and clear
- Use imperative mood (e.g., "Add feature" not "Added feature")
- Examples:
  - ✅ "Add error handling for missing Jira credentials"
  - ✅ "Update bizfilings-status to show velocity metrics"
  - ✅ "Fix incorrect progress calculation in epic summaries"
  - ❌ "Update" (too vague)
  - ❌ "Changes" (not descriptive)

Or manually:
```bash
cd ~/.claude/skills
git add -A
git commit -m "Clear description of what changed and why

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>"
git push
```

## Skill Structure

Each skill directory contains:
- `SKILL.md` - The skill definition with YAML frontmatter and instructions

Example structure:
```
skills/
├── skill-name/
│   └── SKILL.md
├── README.md
├── .gitignore
└── sync.sh
```

## Creating New Skills

To create a new skill:

1. Create a directory: `mkdir -p ~/.claude/skills/my-skill`
2. Create `SKILL.md` with frontmatter:
```markdown
---
name: my-skill
description: Brief description
tools:
  - tool1
  - tool2
---

Your skill instructions here...
```
3. Test with `/my-skill`
4. Sync to GitHub with a clear message:
   ```bash
   ~/.claude/skills/sync.sh "Add my-skill for doing X"
   ```

## Requirements

- Claude Code CLI
- MCP servers for integrations (Atlassian, Google, etc.)
- Appropriate API credentials configured

## License

MIT

## Author

Created for personal productivity workflows with Claude Code.
