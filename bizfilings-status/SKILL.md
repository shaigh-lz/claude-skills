---
name: bizfilings-status
description: Generate weekly status report for BIZFILINGS Core API project by querying Jira and updating Google Docs
tools:
  - mcp__atlassian__searchJiraIssuesUsingJql
  - mcp__atlassian__getJiraIssue
  - mcp__lz-google-mcp__docs_get_document
  - mcp__lz-google-mcp__docs_create_document
  - mcp__lz-google-mcp__docs_update_document
  - mcp__lz-google-mcp__docs_format_text
  - Read
---

Generate a comprehensive weekly status report for the BIZFILINGS Core API project.

Your job is to:
1. Read configuration from ~/.claude/bizfilings-pm-config.json
2. Query the BIZFILINGS Jira project for all Core API related epics
3. For each epic, fetch linked stories and calculate progress metrics
4. Generate a comprehensive weekly status report organized by milestone (epic)
5. Update a Google Doc with the formatted report

Configuration (from ~/.claude/bizfilings-pm-config.json):
- Jira Cloud ID: b9687312-bc3e-4dd3-ae6a-3b56aa5ac702
- Jira Project: BIZFILINGS
- Google Doc ID: Configured in the file
- Report Period: Last 7 days (configurable)

JQL Queries:
- Epics: Use epicSearchJql from config file
- Stories per Epic: "project = BIZFILINGS AND 'Epic Link' = {epicKey}"

Workflow:
1. Read configuration from ~/.claude/bizfilings-pm-config.json
2. Query Jira for all Core API epics using the configured JQL
3. For each epic, fetch all linked stories
4. Calculate metrics: completed, in progress, to-do, blocked stories and progress percentage
5. Generate a formatted markdown report with sections:
   - Executive Summary (overall statistics)
   - Active Milestones (In Progress epics with detailed breakdowns)
   - Upcoming Milestones (Backlog epics with summaries)
   - Recently Completed Milestones (Done epics from last 30 days)
   - Risks & Blockers (any blocked stories or stalled work)
6. Update the Google Doc using the configured updateStrategy (prepend or append)
7. Return the Google Doc URL

Report Format Guidelines:
- Use markdown formatting
- Include emojis for visual clarity: ✅ (completed), 🔄 (in progress), 📋 (to do), ⏸️ (blocked), ⚠️ (warning)
- Group epics by status (In Progress, Backlog, Done)
- Show detailed metrics for active epics (stories breakdown, progress percentage)
- List key stories for in-progress epics (max 10 per epic, configurable via maxStoriesPerEpic)
- Highlight blockers and risks prominently
- Include generation timestamp and Jira board link from config

Error Handling:
- If config file is missing, provide clear instructions to create it
- If Google Doc ID is not configured, provide clear instructions
- If no epics are found, verify JQL query and suggest checking Jira
- If stories can't be fetched for an epic, note it in the report and continue
- Handle network errors gracefully and suggest retry

Always provide the Google Doc URL after successfully updating the document.
