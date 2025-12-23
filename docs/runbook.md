# RE Agent System - Operational Runbook

## Overview

This runbook provides operational procedures for the Reverse Engineering Agent System, including startup, monitoring, error recovery, and escalation procedures.

---

## Table of Contents

1. [System Startup](#system-startup)
2. [Health Checks](#health-checks)
3. [Project Lifecycle](#project-lifecycle)
4. [Error Recovery Procedures](#error-recovery-procedures)
5. [Escalation Procedures](#escalation-procedures)
6. [Monitoring and Alerts](#monitoring-and-alerts)
7. [Maintenance Procedures](#maintenance-procedures)

---

## System Startup

### Pre-Flight Checklist

Before starting any RE analysis project, verify the following:

#### MCP Server Connectivity

```yaml
required_servers:
  - name: airtable
    test: "List tables in base"
    expected: "Tables: Projects, Components, Functions, Working_Principles, etc."

  - name: github
    test: "List repository contents"
    expected: "Repository accessible, can read/write"

  - name: filesystem
    test: "Read project directory"
    expected: "Can access D:\Claude\RE-Claude-Agents"

  - name: brave_search
    test: "Execute test search"
    expected: "Search results returned"

  - name: sequential_thinking
    test: "Simple reasoning task"
    expected: "Structured response"

  - name: memory
    test: "Store and retrieve test value"
    expected: "Value persisted and retrieved"

optional_servers:
  - name: mcp-obsidian
    test: "Search notes"
    fallback: "Continue without Obsidian integration"

  - name: quickchart
    test: "Generate test chart"
    fallback: "Use Mermaid for diagrams"
```

#### Airtable Schema Verification

Verify all required tables exist with correct fields:

| Table | Required Fields |
|-------|-----------------|
| Projects | project_id, designation, status, objective, created_at |
| Components | component_id, project_id, name, type, parent_id |
| Functions | function_id, project_id, statement, parent_id |
| Working_Principles | principle_id, function_id, physical_effect |
| Recommendations | recommendation_id, project_id, type, feasibility |
| Lessons_Learned | lesson_id, project_id, category, insight |
| System_Logs | log_id, timestamp, level, agent_id, message |
| Checkpoints | checkpoint_id, project_id, state, timestamp |

#### GitHub Repository Check

```yaml
repository_structure:
  required_directories:
    - projects/{project_id}/
    - reports/
    - diagrams/

  required_files:
    - README.md
    - .gitignore
```

### Startup Sequence

1. **Verify MCP Connections** (all required servers responding)
2. **Load Configuration** (agent configs, thresholds, timeouts)
3. **Check for Interrupted Projects** (query Checkpoints table)
4. **Resume or Initialize** (restore from checkpoint or start fresh)

---

## Health Checks

### Periodic Health Check (Every 30 minutes)

```yaml
health_check:
  mcp_servers:
    - Check each server responds within 5 seconds
    - Log latency metrics
    - Alert if any server unreachable

  airtable:
    - Verify read access to Projects table
    - Verify write access (create/delete test record)
    - Check API rate limit status

  github:
    - Verify repository access
    - Check for uncommitted changes
    - Verify branch status

  active_projects:
    - Check state machine status
    - Verify no stuck states (idle > 48 hours)
    - Check iteration counts against limits
```

### Health Check Response Actions

| Condition | Action |
|-----------|--------|
| MCP server unreachable | Retry 3x with backoff, then alert |
| Airtable rate limited | Pause operations, wait for reset |
| Project stuck | Log warning, check after 4 hours |
| Max iterations approaching | Alert operator |

---

## Project Lifecycle

### Creating a New Project

1. **Initialize Project Record**
   ```yaml
   project:
     project_id: "{DESIGNATION}-{YEAR}-{SEQUENCE}"
     designation: "System Name"
     status: "INIT"
     objective: "replicate|counter|insert_tech|understand"
     created_at: "{timestamp}"
     created_by: "operator_id"
   ```

2. **Create Project Directory Structure**
   ```
   projects/{project_id}/
   ├── diagnosis/
   ├── modeling/
   ├── intervention/
   ├── reflection/
   └── checkpoints/
   ```

3. **Initialize State Machine**
   - Set state to INIT
   - Set iteration_count to 0
   - Create initial checkpoint

4. **Log Project Creation**
   - Audit event: PROJECT_CREATED
   - Include all initialization parameters

### Project State Transitions

```
INIT → DIAGNOSIS → MODELING → INTERVENTION → REFLECTION → COMPLETE
                      ↑           |
                      └───────────┘  (verification loop)

Any State → ERROR (on unrecoverable failure)
Any State → ESCALATED (on human escalation)
```

### Valid Transitions

| From | To | Trigger |
|------|-----|---------|
| INIT | DIAGNOSIS | Project initialized, specimen ready |
| DIAGNOSIS | MODELING | Diagnosis complete, quality gates passed |
| MODELING | INTERVENTION | Models validated, ready for application |
| MODELING | DIAGNOSIS | Verification needed (loop back) |
| INTERVENTION | REFLECTION | Recommendations complete |
| INTERVENTION | MODELING | Model refinement needed (loop back) |
| REFLECTION | COMPLETE | Lessons captured, no new cycle |
| REFLECTION | DIAGNOSIS | New cycle recommended |
| Any | ERROR | Unrecoverable error |
| Any | ESCALATED | Human escalation triggered |

---

## Error Recovery Procedures

### By Error Code

#### E001-E003: Input Errors

```yaml
error_class: "Input Validation"
immediate_action:
  1. Log error with full context
  2. Return NACK_INVALID to sender
  3. Include specific field and validation failure

recovery:
  - Sender corrects input and resubmits
  - No state change required

escalation_trigger:
  - 3 consecutive input errors from same source
```

#### E100-E104: Resource Errors

```yaml
error_class: "Resource Access"

E100_resource_not_found:
  immediate_action:
    1. Verify resource ID is correct
    2. Check if resource was deleted
    3. Search for resource in alternate locations
  recovery:
    - Recreate resource if possible
    - Request resource from original source
    - Escalate if resource is critical

E101_access_denied:
  immediate_action:
    1. Log access attempt
    2. Do not retry automatically
  recovery:
    - Escalate to system admin for permission grant

E102_resource_locked:
  immediate_action:
    1. Wait 30 seconds
    2. Retry up to 5 times
  recovery:
    - If still locked, identify locking process
    - Request lock release or escalate

E104_checksum_mismatch:
  immediate_action:
    1. Re-download artifact
    2. Verify source integrity
  recovery:
    - Regenerate from earlier checkpoint
    - Escalate if regeneration fails
```

#### E200-E206: Processing Errors

```yaml
error_class: "Processing"

E200_processing_failed:
  immediate_action:
    1. Save checkpoint
    2. Log full error context
  recovery:
    - Analyze failure point
    - Attempt alternative approach
    - Escalate with diagnostics

E201_validation_failed:
  immediate_action:
    1. Document specific validation failures
    2. Calculate gap from threshold
  recovery:
    - If gap < 10%, proceed with caveats
    - If gap >= 10%, request additional input
    - Escalate if gap cannot be closed

E204_max_iterations_exceeded:
  immediate_action:
    1. STOP all processing
    2. Save final checkpoint
    3. Prepare status report
  recovery:
    - MUST escalate to human
    - Options: force complete, restart, terminate

E205_no_progress_detected:
  immediate_action:
    1. Compare last 3 iteration metrics
    2. Identify stuck component
  recovery:
    - Try alternative approach
    - Request additional input
    - Escalate after 2 attempts

E206_verification_contradicted:
  immediate_action:
    1. Document contradiction
    2. Flag affected model sections
  recovery:
    - Revise model based on physical evidence
    - Physical evidence takes precedence
```

#### E300-E306: System Errors

```yaml
error_class: "System/Infrastructure"

E300_timeout:
  immediate_action:
    1. Save checkpoint immediately
    2. Log operation that timed out
  recovery:
    - Resume from checkpoint
    - Extend timeout if appropriate
    - Break into smaller operations

E301_agent_unavailable:
  immediate_action:
    1. Queue handoff for retry
    2. Log unavailability
  recovery:
    - Retry with exponential backoff
    - Max 3 retries over 1 hour
    - Escalate if still unavailable

E302_mcp_connection_failed:
  immediate_action:
    1. Log connection failure
    2. Check server status
  recovery:
    - Retry connection 3 times
    - Use fallback if available
    - Escalate if critical server

E305_checkpoint_corrupted:
  immediate_action:
    1. DO NOT attempt to use corrupted checkpoint
    2. Log corruption details
  recovery:
    - Load previous checkpoint
    - If all corrupted, escalate to system admin
    - May require project restart

E306_rate_limit:
  immediate_action:
    1. Stop making requests
    2. Log rate limit hit
  recovery:
    - Wait for rate limit reset (usually 60s)
    - Reduce request frequency
    - Batch operations where possible
```

### Recovery Decision Tree

```
Error Occurred
    │
    ├── Is it recoverable? (check error_codes.recoverable)
    │   ├── Yes → Attempt automatic recovery
    │   │         ├── Success → Continue processing
    │   │         └── Failure → Increment retry count
    │   │                       ├── Under limit → Retry with backoff
    │   │                       └── At limit → Escalate
    │   │
    │   └── No → Escalate immediately
    │
    └── Is checkpoint available?
        ├── Yes → Save state before escalation
        └── No → Log warning, escalate anyway
```

---

## Escalation Procedures

### Escalation Levels

| Level | Name | Response Time | Notification |
|-------|------|---------------|--------------|
| L1 | Orchestrator | Immediate | Log only |
| L2 | Human Operator | 15 minutes | Dashboard alert |
| L3 | Project Lead | 4 hours | Email + Dashboard |
| L4 | System Admin | 1 hour | All channels |

### Escalation Triggers

```yaml
auto_escalate_to_L2:
  - Max retries exceeded for any error
  - No progress after 2 iterations
  - Quality gate failure with gap >= 20%

auto_escalate_to_L3:
  - Max iterations exceeded (E204)
  - Project stalled > 48 hours
  - Conflicting objectives detected

auto_escalate_to_L4:
  - Fatal error (severity: fatal)
  - Checkpoint corruption
  - Multiple MCP servers down
  - Data integrity concerns
```

### Escalation Message Format

```yaml
escalation_message:
  header:
    escalation_id: "{uuid}"
    timestamp: "{iso8601}"
    level: "L2|L3|L4"
    project_id: "{project_id}"

  summary:
    title: "Brief description (< 100 chars)"
    severity: "warning|error|fatal"
    time_sensitive: true|false

  context:
    current_state: "{state}"
    iteration: {number}
    last_successful_operation: "{operation}"
    error_code: "{code}"
    error_message: "{message}"

  history:
    recent_actions: [...]
    recovery_attempts: [...]

  options:
    - option_id: "A"
      description: "Force completion with current results"
      risk: "May miss critical insights"
      recommended: false

    - option_id: "B"
      description: "Restart from last checkpoint"
      risk: "Lose recent progress"
      recommended: true

    - option_id: "C"
      description: "Terminate project"
      risk: "No deliverables"
      recommended: false

  checkpoint_id: "{for recovery}"
  artifacts_available: [...]
```

### Responding to Escalations

1. **Acknowledge** within response time
2. **Review** context and options
3. **Decide** on action
4. **Document** decision rationale
5. **Execute** chosen option
6. **Monitor** for resolution

---

## Monitoring and Alerts

### Key Metrics to Monitor

```yaml
project_metrics:
  - iterations_count vs max_iterations
  - time_in_current_state
  - quality_gate_scores
  - documentation_completeness
  - functions_mapped_percentage

system_metrics:
  - mcp_server_latency
  - api_rate_limit_remaining
  - checkpoint_frequency
  - error_rate_per_hour
  - escalation_rate
```

### Alert Thresholds

| Metric | Warning | Critical |
|--------|---------|----------|
| iterations_count | > 70% of max | > 90% of max |
| time_in_state | > 24 hours | > 48 hours |
| mcp_latency | > 2 seconds | > 5 seconds |
| error_rate | > 5/hour | > 10/hour |
| quality_gate_gap | > 10% | > 20% |

### Log Queries for Troubleshooting

```yaml
recent_errors:
  query: "level >= ERROR AND timestamp > {24_hours_ago}"
  sort: "timestamp DESC"

project_timeline:
  query: "project_id == {id} AND tags CONTAINS 'state_transition'"
  sort: "timestamp ASC"

agent_activity:
  query: "agent_id == {agent} AND timestamp > {since}"
  sort: "timestamp DESC"

escalation_history:
  query: "tags CONTAINS 'escalation'"
  sort: "timestamp DESC"
```

---

## Maintenance Procedures

### Daily Maintenance

1. **Review overnight logs** for errors/warnings
2. **Check active projects** for stuck states
3. **Verify checkpoint integrity** for active projects
4. **Monitor disk space** for log storage

### Weekly Maintenance

1. **Archive old logs** (> 7 days for TRACE/DEBUG)
2. **Review escalation trends**
3. **Check MCP server health trends**
4. **Backup Airtable data**

### Monthly Maintenance

1. **Archive completed project data**
2. **Review and update thresholds** if needed
3. **Clean up orphaned checkpoints**
4. **Performance review** of agent operations

### Checkpoint Maintenance

```yaml
checkpoint_cleanup:
  active_projects:
    keep: "all"

  completed_projects:
    keep: 5
    types: ["state_transition", "artifact_created"]

  archived_projects:
    keep: 1
    types: ["final"]

  orphaned_checkpoints:
    action: "delete after verification"
```

---

## Quick Reference

### Common Commands

```bash
# Check project status
Query: Projects WHERE project_id = "{id}"

# View recent logs for project
Query: System_Logs WHERE project_id = "{id}" ORDER BY timestamp DESC LIMIT 50

# Find latest checkpoint
Query: Checkpoints WHERE project_id = "{id}" ORDER BY timestamp DESC LIMIT 1

# Count active projects
Query: Projects WHERE status NOT IN ["COMPLETE", "ERROR", "TERMINATED"]
```

### Emergency Contacts

| Role | Responsibility | Escalation Path |
|------|---------------|-----------------|
| System Operator | Day-to-day operations | L2 alerts |
| Project Lead | Project decisions | L3 alerts |
| System Admin | Infrastructure issues | L4 alerts |

---

## Document History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2025-12-23 | Initial creation |
