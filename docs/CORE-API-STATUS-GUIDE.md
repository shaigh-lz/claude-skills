# Core API Status Report Skill - User Guide

**Last Updated:** March 23, 2026
**Skill Name:** `/core-api-proj-status`

## Overview

The `/core-api-proj-status` skill generates comprehensive weekly status reports for the Core API project. It automatically:
- Queries Jira for all Core API-related epics and stories
- Calculates progress metrics and completion percentages
- Identifies blockers and risks
- Creates a formatted Google Doc report in a shared folder
- Returns the document URL for immediate access

**Report Generation Time:** ~30 seconds
**Report Frequency:** On-demand (run whenever needed)

## Prerequisites

Before using this skill, ensure you have:

### 1. Claude Code CLI Installed
The skill runs within Claude Code. If not installed:
```bash
# Installation instructions at: https://github.com/anthropics/claude-code
```

### 2. MCP Servers Configured
You need two MCP servers:

**Atlassian MCP** (for Jira access):
- Server: `mcp__atlassian`
- Tools needed: `searchJiraIssuesUsingJql`, `getJiraIssue`
- Authentication: Jira API token configured

**Google MCP** (for Drive/Docs access):
- Server: `mcp__lz-google-mcp`
- Tools needed: `docs_create_document`, `docs_get_document`
- Authentication: Google OAuth configured

### 3. Access Permissions
- **Jira**: Read access to BIZFILINGS project
- **Google Drive**: Write access to the shared status reports folder
- **Folder ID:** `1NDUmxDfWczFwWnMSSgzN8hU7eRK5PH0K`

## Setup

### Step 1: Install the Skill

Clone the skills repository:
```bash
git clone https://github.com/shaigh-lz/claude-skills.git ~/.claude/skills
```

Or if already cloned, pull latest updates:
```bash
cd ~/.claude/skills
git pull origin main
```

### Step 2: Create Configuration File

Create `~/.claude/bizfilings-pm-config.json`:

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

### Step 3: Verify MCP Servers

Check that MCP servers are configured:
```bash
# In Claude Code, run:
/mcp-status
```

You should see `atlassian` and `lz-google-mcp` listed and connected.

### Step 4: Test the Skill

Run the skill:
```bash
/core-api-proj-status
```

Expected output:
- Progress updates as it queries Jira
- Metric calculations
- Google Doc creation
- Final URL to the generated report

## Usage

### Basic Usage

Simply run the skill in Claude Code:
```
/core-api-proj-status
```

The skill will:
1. Read your configuration from `~/.claude/bizfilings-pm-config.json`
2. Query Jira for all Core API epics
3. For each epic, fetch linked stories
4. Calculate metrics (completed, in progress, blocked)
5. Generate a formatted report
6. Create a new Google Doc with today's date as prefix
7. Return the document URL

### What to Expect

**Duration:** ~30 seconds
**Output Format:** Google Doc URL
**Document Name:** `YYYY-MM-DD Core API Project - Status Report`
**Location:** Shared Drive folder (configured in `folderId`)

### Example Output

```
✅ Weekly Status Report Generated Successfully!

**Report Summary:**
- 21 Total Epics tracked
- 2 Active Epics: Read API (92% complete) and Write API (71% complete)
- 6 Recently Completed Epics in last 30 days
- 13 Backlog Epics awaiting prioritization
- No blockers identified

📄 View Report:
https://docs.google.com/document/d/1bn5Z05Qh_6tLDGUlVAzoMPLscobx_8lifT8p61nCC8E/edit
```

## Configuration Options

### Jira Configuration

```json
"jira": {
  "cloudId": "...",           // Your Jira cloud ID
  "projectKey": "...",        // Project key (e.g., "BIZFILINGS")
  "epicSearchJql": "...",     // JQL to find epics
  "boardUrl": "..."           // Link to Jira board for reports
}
```

**Customizing Epic Search:**
Modify `epicSearchJql` to change which epics are included:
```json
"epicSearchJql": "project = BIZFILINGS AND issuetype = Epic AND summary ~ 'Core API' AND status != Done"
```

### Google Drive Configuration

```json
"google": {
  "folderId": "...",                    // Folder ID for reports
  "createNewDocEachRun": true,          // Create new doc each time
  "docNamePrefix": "..."                // Prefix for document names
}
```

**Alternative: Update Single Document**
To update one document instead of creating new ones:
```json
"google": {
  "docId": "...",                       // Existing document ID
  "createNewDocEachRun": false,
  "updateStrategy": "prepend"           // or "append"
}
```

### Report Configuration

```json
"report": {
  "periodDays": 7,              // Report covers last N days
  "includeBacklog": true,       // Show backlog epics
  "maxBacklogEpics": 10,        // Limit backlog items shown
  "showCompletedDays": 30,      // Include epics completed in last N days
  "maxStoriesPerEpic": 10       // Max stories to list per epic
}
```

## Report Structure

Generated reports include:

### 1. Executive Summary
- Total epic count
- Active epics with progress
- Recently completed epics
- Backlog count
- Key metrics

### 2. Active Milestones (In Progress)
For each in-progress epic:
- Epic name and link
- Progress percentage
- Story breakdown (done, in progress, in review, backlog)
- Active stories with assignees
- Recently completed stories

### 3. Upcoming Milestones (Backlog)
- List of backlog epics
- Brief summaries

### 4. Recently Completed Milestones
- Epics completed in last 30 days
- Completion dates
- Story counts

### 5. Risks & Blockers
- Blocked stories
- Stalled work
- Observations
- Recommendations

## Troubleshooting

### Error: "Config file not found"

**Problem:** Configuration file missing or in wrong location

**Solution:**
```bash
# Check if file exists
ls -la ~/.claude/bizfilings-pm-config.json

# If missing, create it (see Setup section above)
# Make sure it's in your home directory: ~/.claude/
```

### Error: "MCP server not connected"

**Problem:** Atlassian or Google MCP server not available

**Solution:**
```bash
# Check MCP status
/mcp-status

# Restart Claude Code if needed
# Verify MCP configuration in Claude Code settings
```

### Error: "Permission denied" when creating Google Doc

**Problem:** No write access to the configured folder

**Solution:**
1. Verify you have edit access to folder `1NDUmxDfWczFwWnMSSgzN8hU7eRK5PH0K`
2. Check Google MCP authentication:
   ```bash
   # In Claude Code:
   /mcp-tools lz-google-mcp
   ```
3. Re-authenticate if needed

### Error: "No epics found"

**Problem:** JQL query returns no results

**Solution:**
1. Verify the JQL query in your config:
   ```json
   "epicSearchJql": "project = BIZFILINGS AND issuetype = Epic AND summary ~ 'Core API'"
   ```
2. Test the JQL in Jira directly
3. Adjust the query if project structure changed

### Slow Performance

**Problem:** Report generation takes longer than expected

**Possible Causes:**
- Many epics with lots of stories
- Network latency
- Jira API rate limits

**Solutions:**
- Reduce `maxStoriesPerEpic` in configuration
- Limit epics with more specific JQL
- Run during off-peak hours

### Report Missing Information

**Problem:** Expected epics or stories not appearing

**Solution:**
1. Check epic naming matches JQL query
2. Verify story linking (Epic Link field set correctly)
3. Check Jira permissions
4. Review story status values

## Best Practices

1. **Run Weekly:** Generate reports every Monday for the previous week
2. **Review Before Sharing:** Scan the report for accuracy
3. **Keep Config Updated:** Update folder IDs and JQL as needed
4. **Archive Old Reports:** Organize Drive folder periodically
5. **Customize for Your Team:** Adjust metrics and format as needed

## Getting Help

- **Issues:** File at https://github.com/shaigh-lz/claude-skills/issues
- **Questions:** Contact Shai Ghinsburg
- **Documentation:** See other docs in `docs/` directory

## Next Steps

- See `FUTURE-ROADMAP.md` for planned enhancements
- See `TEAM-ACCESS.md` for sharing with team members
- See `STRATEGIC-PLAN.md` for overall vision

---

*For the prototype agent version, see `PROTOTYPE-AGENT.md`*
