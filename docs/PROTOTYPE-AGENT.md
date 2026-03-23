# Prototype Agent Guide

**Last Updated:** March 23, 2026
**Agent Name:** `bizfilings-pm`
**Status:** Superseded by `/core-api-proj-status` skill

## What is the Prototype Agent?

The `bizfilings-pm` agent was the original proof-of-concept implementation for automated BIZFILINGS status reporting. It served as a testing ground for:
- Querying Jira via MCP
- Generating formatted reports
- Updating Google Docs
- Refining the report structure and metrics

**Location:** `~/.claude/agents/bizfilings-pm.claud`

**Purpose:** Experimentation and validation before creating the production skill

## Agent vs Skill: What's the Difference?

| Feature | Agent | Skill |
|---------|-------|-------|
| **Location** | `~/.claude/agents/` | `~/.claude/skills/` |
| **Invocation** | `@bizfilings-pm` in conversation | `/core-api-proj-status` as command |
| **Sharing** | Not easily shareable | Git repo for team sharing |
| **Version Control** | Manual | Automatic via Git |
| **Updates** | Edit local file | Pull from GitHub |
| **Best For** | Prototyping, testing | Production use |

## Using the Prototype Agent

### How to Invoke

In a Claude Code conversation:
```
@bizfilings-pm
```

Or with a prompt:
```
@bizfilings-pm generate the weekly status report
```

### What It Does

The agent:
1. Reads configuration from `~/.claude/bizfilings-pm-config.json`
2. Queries Jira for Core API epics
3. Fetches linked stories for each epic
4. Calculates progress metrics
5. Generates a markdown report
6. Updates a Google Doc (prepends new report)
7. Returns the document URL

### Configuration

Uses the same configuration file as the skill:
`~/.claude/bizfilings-pm-config.json`

However, the agent expects:
```json
"google": {
  "docId": "...",              // Must specify document ID
  "updateStrategy": "prepend"   // prepend or append
}
```

Note: The agent does NOT support `createNewDocEachRun` mode.

## Migration to Skill

### Why the Skill is Better

The `/core-api-proj-status` skill improves on the agent:

1. **Shareable with Team**
   - Skill lives in Git repository
   - Team members can clone and use
   - Version controlled updates

2. **Better Document Management**
   - Creates new document each time (default)
   - Date-prefixed naming
   - No document bloat
   - Supports both modes (new doc or update existing)

3. **Cleaner Invocation**
   - Simple `/core-api-proj-status` command
   - No need for conversation context
   - Consistent behavior every time

4. **Improved Error Handling**
   - Better validation
   - Clearer error messages
   - Graceful failures

5. **Enhanced Configuration**
   - More flexible options
   - Better documentation
   - Template configs

### Migration Steps

If you're currently using the agent:

1. **Install the Skill**
   ```bash
   git clone https://github.com/shaigh-lz/claude-skills.git ~/.claude/skills
   ```

2. **Update Configuration** (if needed)

   Your existing `~/.claude/bizfilings-pm-config.json` should work, but consider updating to use the new document creation mode:

   ```json
   "google": {
     "folderId": "1NDUmxDfWczFwWnMSSgzN8hU7eRK5PH0K",
     "createNewDocEachRun": true,
     "docNamePrefix": "Core API Project - Status Report"
   }
   ```

3. **Test the Skill**
   ```
   /core-api-proj-status
   ```

4. **Verify Reports**
   - Check that reports are generated correctly
   - Verify folder location
   - Confirm formatting

5. **Delete the Agent** (see below)

## Deleting the Prototype Agent

### When It's Safe to Delete

Delete the agent when:
- ✓ You've successfully run `/core-api-proj-status` at least once
- ✓ You've verified the reports meet your needs
- ✓ Your team is using the skill
- ✓ You're no longer experimenting with the agent

### How to Delete

**Option 1: Remove the agent file**
```bash
rm ~/.claude/agents/bizfilings-pm.claud
```

**Option 2: Archive it first (recommended)**
```bash
# Create backup
mv ~/.claude/agents/bizfilings-pm.claud ~/.claude/agents/bizfilings-pm.claud.backup

# Later, if confident, delete the backup
rm ~/.claude/agents/bizfilings-pm.claud.backup
```

### Verify Deletion

Check that the agent no longer appears:
```bash
ls ~/.claude/agents/

# You should not see bizfilings-pm.claud
```

In Claude Code, `@bizfilings-pm` will no longer work (this is expected).

### What About the Config File?

**Keep it!** The configuration file is shared between the agent and skill:
```
~/.claude/bizfilings-pm-config.json
```

The skill uses the same config, so don't delete it.

## Historical Context

### Development Timeline

**March 18, 2026**
- Created initial agent for proof of concept
- Tested Jira queries and data extraction
- Validated MCP server connectivity

**March 19-20, 2026**
- Refined report format
- Added progress metrics
- Implemented Google Docs integration
- Tested prepend strategy

**March 21, 2026**
- Converted agent to skill
- Created skills repository
- Published to GitHub

**March 22-23, 2026**
- Iterated on document creation strategy
- Added "create new doc each time" mode
- Fixed folder location
- Enhanced error handling

### Lessons Learned

**1. Prototype with Agents**
- Agents are perfect for quick experimentation
- Easy to iterate on instructions
- Fast feedback loop

**2. Production with Skills**
- Skills provide structure and shareability
- Git integration is invaluable
- Better for team collaboration

**3. Configuration Management**
- Separate config from code
- Use JSON for structured settings
- Keep sensitive data out of version control

**4. Document Strategy Matters**
- Single document gets unwieldy over time
- New document per report is cleaner
- Date prefixes enable easy navigation

**5. MCP Servers Are Powerful**
- Direct integration with enterprise tools
- No custom API wrappers needed
- Secure authentication built-in

## When to Use an Agent vs Skill

### Use an Agent For:
- Quick prototyping and testing
- One-off experiments
- Personal workflows
- Iterating on ideas

### Use a Skill For:
- Production workflows
- Team collaboration
- Reusable patterns
- Version-controlled processes

### Migration Path:
```
Idea → Agent (prototype) → Skill (production) → Share with team
```

## Next Steps

1. Delete the agent once migrated
2. Use `/core-api-proj-status` for all future reports
3. Share the skills repo with your team
4. See `CORE-API-STATUS-GUIDE.md` for full documentation
5. See `FUTURE-ROADMAP.md` for planned enhancements

## Questions?

- **Issues:** File at https://github.com/shaigh-lz/claude-skills/issues
- **Contact:** Shai Ghinsburg
- **Documentation:** See other docs in `docs/` directory

---

*The agent served its purpose well. Thanks for the rapid prototyping capability! 🚀*
