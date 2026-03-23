# Team Access Guide: Using Claude Skills

**Last Updated:** March 23, 2026
**Repository:** https://github.com/shaigh-lz/claude-skills

This guide helps team members install and use the Claude skills repository.

## Overview

Claude skills are reusable workflows that automate common tasks. The skills in this repository currently include:

- `/core-api-proj-status` - Generate weekly status reports for Core API

More skills will be added over time. All skills are shareable via this Git repository.

## Prerequisites

Before you can use these skills, you need:

### 1. Claude Code CLI Installed

Claude Code is required to run skills.

**Check if installed:**
```bash
claude --version
```

**If not installed:**
Follow installation instructions at: https://github.com/anthropics/claude-code

### 2. MCP Servers Configured

Skills use Model Context Protocol (MCP) servers to access external tools like Jira and Google.

**Required MCP servers:**
- `atlassian` - For Jira access
- `lz-google-mcp` - For Google Drive/Docs access

**Check MCP servers:**
In Claude Code, run:
```
/mcp-status
```

You should see both servers listed and connected.

**If not configured:**
Contact your admin or see Claude Code MCP setup documentation.

### 3. Tool Access & Permissions

You need:
- **Jira:** Read access to BIZFILINGS project
- **Google Drive:** Write access to status reports folder
- **Folder ID:** `1NDUmxDfWczFwWnMSSgzN8hU7eRK5PH0K`

## Installation

### Step 1: Clone the Repository

Clone the skills repository to `~/.claude/skills`:

```bash
git clone https://github.com/shaigh-lz/claude-skills.git ~/.claude/skills
```

**Note:** The location `~/.claude/skills` is where Claude Code looks for skills.

### Step 2: Verify Installation

Check that skills are available:

```bash
ls -la ~/.claude/skills
```

You should see:
```
core-api-proj-status/
docs/
README.md
sync.sh
.gitignore
```

In Claude Code, skills will now be available:
```
/core-api-proj-status
```

### Step 3: Configure Personal Settings

Create your configuration file:

```bash
# Create the config directory if it doesn't exist
mkdir -p ~/.claude

# Create the config file
touch ~/.claude/bizfilings-pm-config.json
```

Edit `~/.claude/bizfilings-pm-config.json` with your editor:

```json
{
  "jira": {
    "cloudId": "b9687312-bc3e-4dd3-ae6a-3b56aa5ac702",
    "projectKey": "BIZFILINGS",
    "epicSearchJql": "project = BIZFILINGS AND issuetype = Epic AND summary ~ 'Core API'",
    "boardUrl": "https://legalzoom.atlassian.net/jira/software/c/projects/BIZFILINGS/boards/2289"
  },
  "google": {
    "folderId": "1NDUmxDfWczFwWnMSSgzN8hU7eRK5PH0K",
    "createNewDocEachRun": true,
    "docNamePrefix": "Core API Project - Status Report"
  },
  "report": {
    "periodDays": 7,
    "includeBacklog": true,
    "maxBacklogEpics": 10,
    "showCompletedDays": 30,
    "maxStoriesPerEpic": 10
  }
}
```

**Important:** Keep this config file private. Don't commit it to Git.

### Step 4: Test the Skills

Run the status report skill:

```
/core-api-proj-status
```

Expected result:
- Queries Jira for epics and stories
- Generates a comprehensive report
- Creates a Google Doc in the shared folder
- Returns the document URL

## Updating Skills

### Getting Latest Changes

Pull updates from the repository:

```bash
cd ~/.claude/skills
git pull origin main
```

This updates all skills to the latest version.

### Update Frequency

Check for updates:
- **Weekly:** For active development
- **Monthly:** For stable use
- **When notified:** If team announces updates

## Using Skills

### Available Skills

#### `/core-api-proj-status`

Generate weekly status reports.

**Usage:**
```
/core-api-proj-status
```

**Documentation:** See `docs/CORE-API-STATUS-GUIDE.md`

**Time:** ~30 seconds
**Output:** Google Doc URL

---

*More skills will be added here as they're created.*

## Contributing to Skills

Want to improve a skill or create a new one?

### Modifying Existing Skills

1. **Make changes** in `~/.claude/skills/`
2. **Test thoroughly**
3. **Use the sync script:**
   ```bash
   cd ~/.claude/skills
   ./sync.sh "Clear description of what changed and why"
   ```

The sync script will:
- Stage all changes
- Create a commit with your message
- Add Claude co-author attribution
- Push to GitHub

### Creating New Skills

1. **Create directory:**
   ```bash
   mkdir ~/.claude/skills/my-new-skill
   ```

2. **Create `SKILL.md`:**
   ```markdown
   ---
   name: my-new-skill
   description: Brief description of what it does
   tools:
     - tool1
     - tool2
   ---

   Your skill instructions here...
   ```

3. **Test the skill:**
   ```
   /my-new-skill
   ```

4. **Document it:**
   - Add entry to main README.md
   - Create detailed guide in `docs/` if needed

5. **Sync to GitHub:**
   ```bash
   ./sync.sh "Add my-new-skill for doing X"
   ```

### Commit Message Guidelines

Write clear, descriptive commit messages:

**Good examples:**
- ✅ "Add error handling for missing Jira credentials"
- ✅ "Update core-api-proj-status to show velocity metrics"
- ✅ "Fix incorrect progress calculation in epic summaries"

**Bad examples:**
- ❌ "Update" (too vague)
- ❌ "Changes" (not descriptive)
- ❌ "Fix bug" (which bug?)

**Format:**
- Use imperative mood ("Add feature" not "Added feature")
- Be specific about what changed
- Explain why if not obvious

## Troubleshooting

### Skill Not Found

**Problem:** `/my-skill` says skill not found

**Solutions:**
1. Verify installation:
   ```bash
   ls ~/.claude/skills/my-skill/SKILL.md
   ```
2. Restart Claude Code
3. Re-clone if directory structure is wrong

### MCP Connection Issues

**Problem:** "MCP server not connected" error

**Solutions:**
1. Check MCP status: `/mcp-status`
2. Restart Claude Code
3. Verify MCP configuration in settings
4. Re-authenticate if needed

### Permission Denied Errors

**Problem:** Can't create Google Docs or access Jira

**Solutions:**
1. Verify you have required permissions
2. Check Google Drive folder access
3. Verify Jira project access
4. Re-authenticate MCP servers

### Configuration Errors

**Problem:** Config file not found or invalid

**Solutions:**
1. Verify file location: `~/.claude/bizfilings-pm-config.json`
2. Check JSON syntax (use jsonlint)
3. Compare against template in docs
4. Check file permissions

### Git Sync Issues

**Problem:** Can't push changes to GitHub

**Solutions:**
1. Verify you have write access to repo
2. Check Git authentication:
   ```bash
   cd ~/.claude/skills
   git remote -v
   ```
3. Pull latest changes first: `git pull origin main`
4. Resolve any conflicts

## Getting Help

### Documentation

- **Skills README:** `~/.claude/skills/README.md`
- **User Guides:** `~/.claude/skills/docs/`
- **Strategic Plan:** `docs/STRATEGIC-PLAN.md`
- **Roadmap:** `docs/FUTURE-ROADMAP.md`

### Support

- **File Issues:** https://github.com/shaigh-lz/claude-skills/issues
- **Ask Questions:** Start a discussion on GitHub
- **Contact:** Shai Ghinsburg

### Feature Requests

Have an idea for a new skill or enhancement?

1. **Check roadmap:** See if it's already planned
2. **File an issue:** Describe your idea with use case
3. **Discuss:** Collaborate on design
4. **Build it:** Contribute code if you can

## Security & Best Practices

### Keep Credentials Secure

**DO:**
- ✅ Store configs in `~/.claude/` directory
- ✅ Use environment variables for secrets
- ✅ Keep config files private
- ✅ Limit sharing of API tokens

**DON'T:**
- ❌ Commit config files to Git
- ❌ Share credentials in Slack/email
- ❌ Hardcode API keys in skills
- ❌ Store passwords in plain text

### Configuration Files

Add to `.gitignore`:
```
*.config.json
*.credentials
.env
```

Use template configs:
```
config.template.json  # Commit this
config.json          # Don't commit (in .gitignore)
```

### Access Control

**Repository Access:**
- Skills repo: Team read access
- Contributing: Request write access
- Sensitive skills: Private repository

**Tool Access:**
- Jira: Follow company policies
- Google: Use company account
- MCP: Secure authentication

## Repository Structure

```
~/.claude/skills/
├── core-api-proj-status/       # Status report skill
│   └── SKILL.md
├── docs/                    # Documentation
│   ├── STRATEGIC-PLAN.md
│   ├── CORE-API-STATUS-GUIDE.md
│   ├── PROTOTYPE-AGENT.md
│   ├── FUTURE-ROADMAP.md
│   └── TEAM-ACCESS.md (this file)
├── README.md                # Main repository readme
├── .gitignore               # Git ignore rules
└── sync.sh                  # Sync script for updates
```

## Next Steps

1. ✅ Install skills repository
2. ✅ Configure personal settings
3. ✅ Test with `/core-api-proj-status`
4. 📚 Read the documentation
5. 💡 Share feedback and ideas
6. 🚀 Contribute improvements

## FAQ

**Q: Do I need to configure MCP servers myself?**
A: Typically, your admin sets up MCP servers org-wide. Check with your team lead.

**Q: Can I customize skills for my needs?**
A: Yes! Clone the skill, modify it, and use locally. Consider contributing improvements back.

**Q: How often are skills updated?**
A: Currently weekly during active development. Watch the repo for notifications.

**Q: Can I create private skills?**
A: Yes, create skills in `~/.claude/skills/` that you don't push to the shared repo.

**Q: What if I don't have access to a required tool?**
A: Request access from your manager or admin. Some skills may require specific permissions.

**Q: How do I uninstall a skill?**
A: Delete the skill directory: `rm -rf ~/.claude/skills/skill-name`

**Q: Can skills access my local files?**
A: Only if the skill explicitly uses file reading tools and you approve the action.

---

**Welcome to the team! Happy automating! 🎉**
