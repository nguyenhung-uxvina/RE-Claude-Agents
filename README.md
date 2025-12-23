# Reverse Engineering Agent System

A multi-agent system for systematic reverse engineering using the **D-M-I-R** framework (Diagnosis → Modeling → Intervention → Reflection).

## Overview

This system provides a structured approach to reverse engineering that goes beyond measuring parts—it reconstructs **design decisions** and **designer intent**. The goal is exponential knowledge extraction through paradigm-level learning.

> **Key Insight**: Reverse engineering is **design archaeology**—reconstructing decisions, not just measuring parts.

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        ORCHESTRATOR                              │
│              State Machine + Loop Control + Escalation           │
└─────────────────────────────────────────────────────────────────┘
        │              │              │              │
        ▼              ▼              ▼              ▼
┌───────────┐  ┌───────────┐  ┌───────────┐  ┌───────────┐
│DIAGNOSTICIAN│  │  MODELER  │  │INTERVENTION│  │ REFLECTOR │
│   D-Phase   │  │  M-Phase  │  │  I-Phase   │  │  R-Phase  │
│Physical→Data│  │Data→Models│  │Models→Acts │  │Acts→Learn │
└───────────┘  └───────────┘  └───────────┘  └───────────┘
       ↑              │
       └──────────────┘ (verification loop)
```

### Agents

| Agent | Phase | Role |
|-------|-------|------|
| **Orchestrator** | All | State machine, routing, loop control, escalation |
| **Diagnostician** | D | Physical reconnaissance, documentation, pattern recognition |
| **Modeler** | M | Function structure reconstruction, working principle ID |
| **Interventionist** | I | Application strategies, recommendations |
| **Reflector** | R | Meta-learning, paradigm analysis, knowledge capture |

## Key Features

| Feature | Description |
|---------|-------------|
| **D-M-I-R Pipeline** | Four-phase cycle with quality gates at each transition |
| **Feedback Loops** | Verification loops between Modeler ↔ Diagnostician |
| **Loop Termination** | Max iterations, progress thresholds, timeout guards |
| **ACK/NACK Protocol** | Reliable handoff messaging with retry semantics |
| **Checkpointing** | State persistence and recovery from any point |
| **Error Handling** | Structured errors (E001-E306) with recovery options |
| **Escalation** | Automatic escalation to human operators (L1-L4) |
| **Knowledge Capture** | Cross-project learning via persistent storage |

## State Machine

```
INIT → DIAGNOSIS → MODELING → INTERVENTION → REFLECTION → COMPLETE
              ↑         │
              └─────────┘  (verification loop)

Any State → ERROR (unrecoverable failure)
Any State → ESCALATED (human intervention required)
```

### Loop Controls

| Loop | Max Iterations | Threshold | On Exceed |
|------|----------------|-----------|-----------|
| Diagnosis | 3 | 10% improvement | ESCALATE |
| Modeling verification | 5 | Batch of 3 | PROCEED_WITH_CAVEATS |
| Global | 20 | 30 days | ESCALATE_TO_HUMAN |

## Project Structure

```
RE-Claude-Agents/
├── agents/                     # Agent specifications
│   ├── orchestrator.md         # State machine, routing, escalation
│   ├── diagnostician.md        # Physical documentation
│   ├── modeler.md              # Function structure reconstruction
│   ├── interventionist.md      # Application strategy
│   └── reflector.md            # Meta-learning, knowledge capture
│
├── schemas/                    # Data schemas
│   ├── base-types.yaml         # Unified type definitions
│   ├── input-schema.yaml       # Project input format
│   ├── handoff-schema.yaml     # Inter-agent messaging (ACK/NACK)
│   ├── error-schema.yaml       # Error codes E001-E306
│   ├── logging-schema.yaml     # Log levels and audit events
│   ├── checkpoint-schema.yaml  # State persistence
│   └── mcp-operations.yaml     # MCP server operations
│
├── templates/                  # Message templates
│   ├── handoff-templates.yaml  # Pre-filled handoff messages
│   └── example-input.yaml      # Sample project input
│
├── skills/                     # Reusable analysis skills
│   └── SKILLS.md               # Skill definitions
│
├── docs/                       # Documentation
│   ├── architecture-diagram.md # Visual system architecture
│   └── runbook.md              # Operational procedures
│
├── projects/                   # Project workspaces
│   └── {project-id}/           # Per-project artifacts
│
├── SKILL.md                    # Main system specification
├── QUICK-START.md              # 30-minute setup guide
└── LEVERAGE-ANALYSIS.md        # Systems theory analysis
```

## D-M-I-R Framework

### Phase 1: DIAGNOSIS
Physical reconnaissance and documentation of the target system.

| Activity | Output |
|----------|--------|
| External observation | Dimensions, interfaces, markings |
| Subsystem decomposition | Assembly hierarchy, connections |
| Component analysis | Part identification, materials |
| Pattern recognition | Design paradigm indicators |

**Quality Gate**: ≥80% documentation completeness

### Phase 2: MODELING
Reconstruct function structure and identify working principles.

| Activity | Output |
|----------|--------|
| Flow identification | Energy, material, signal flows |
| Subfunction extraction | Function hierarchy (F1, F1.1, ...) |
| Working principle ID | Physical effects, effect carriers |
| Design paradigm analysis | Goals, constraints, trade-offs |

**Quality Gate**: ≥90% validation score, ≥95% components mapped

### Phase 3: INTERVENTION
Generate actionable recommendations based on analysis objective.

| Objective | Strategy |
|-----------|----------|
| `replicate` | Indigenous alternative development |
| `counter` | Vulnerability analysis, countermeasures |
| `insert_tech` | Technology transfer to existing systems |
| `understand` | Complete system comprehension |

**Quality Gate**: All strategies evaluated, feasibility assessed

### Phase 4: REFLECTION
Capture lessons learned and improve the process.

| Activity | Output |
|----------|--------|
| After-action review | What worked, what didn't |
| Paradigm assessment | Assumptions tested, mental model updates |
| Capability assessment | Skill gaps, tool needs |
| Knowledge capture | Lessons to Airtable, GitHub, Memory |

**Quality Gate**: ≥5 lessons captured, ≥1 process improvement

## MCP Server Integration

### Required Servers

| Server | Purpose |
|--------|---------|
| `@airtable/mcp-server-airtable` | Structured data (components, functions, logs) |
| `@anthropic/mcp-server-github` | Artifact storage, version control |
| `@anthropic/mcp-server-filesystem` | Local file access |
| `@anthropic/mcp-server-brave-search` | Part number lookup, specs |
| `@anthropic/mcp-server-sequential-thinking` | Multi-step reasoning |
| `@anthropic/mcp-server-memory` | Cross-project knowledge |

### Optional Servers

| Server | Purpose |
|--------|---------|
| `mcp-obsidian` | Knowledge base notes |
| `quickchart-mcp-server` | Chart generation |
| `mcp-mermaid` | Diagram rendering |

## Airtable Schema

| Table | Purpose |
|-------|---------|
| `Projects` | Project metadata and status |
| `Components` | Physical component catalog |
| `Functions` | Function hierarchy |
| `Working_Principles` | Physical effects and solutions |
| `Recommendations` | Generated recommendations |
| `Lessons_Learned` | Captured insights |
| `System_Logs` | Operational logging |
| `Checkpoints` | State snapshots |

## Error Handling

| Range | Category | Example |
|-------|----------|---------|
| E001-E099 | Input errors | Invalid schema, missing field |
| E100-E199 | Resource errors | Not found, access denied |
| E200-E299 | Processing errors | Validation failed, max iterations |
| E300-E399 | System errors | Timeout, MCP connection failed |

### Escalation Levels

| Level | Recipient | Response Time |
|-------|-----------|---------------|
| L1 | Orchestrator | Immediate (automatic) |
| L2 | Human Operator | 15 minutes |
| L3 | Project Lead | 4 hours |
| L4 | System Admin | 1 hour |

## Quick Start

### 1. Configure MCP Servers

```json
{
  "mcpServers": {
    "airtable": {
      "command": "npx",
      "args": ["-y", "@airtable/mcp-server-airtable"],
      "env": {
        "AIRTABLE_API_KEY": "your-api-key",
        "AIRTABLE_BASE_ID": "your-base-id"
      }
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-github"],
      "env": { "GITHUB_TOKEN": "your-token" }
    },
    "brave-search": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-brave-search"],
      "env": { "BRAVE_API_KEY": "your-api-key" }
    },
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-sequential-thinking"]
    },
    "memory": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-memory"]
    },
    "filesystem": {
      "command": "npx",
      "args": ["-y", "@anthropic/mcp-server-filesystem"]
    }
  }
}
```

### 2. Set Up Airtable

Create tables per `schemas/mcp-operations.yaml`. See [QUICK-START.md](QUICK-START.md) for details.

### 3. Initialize Project

```yaml
project:
  designation: "Target System Name"
  objective: understand  # replicate | counter | insert_tech | understand
  origin_country: "Country"
  priority: high

specimen_access:
  location: "Lab location"
  access_duration: 40  # hours
  destructive_allowed: true
```

### 4. Run Analysis

```
Using the reverse-engineering-agent-system skill, analyze this system:

System: [designation]
Objective: [replicate/counter/insert_tech/understand]
Access: [full/partial/remote]

Start with DIAGNOSIS phase.
```

## Usage Patterns

### Full Analysis
```
Reverse engineer [system].
Goal: Develop indigenous alternative for [application].
```

### Counter-System Development
```
Analyze [threat system] vulnerabilities.
Goal: Develop countermeasures.
```

### Technology Insertion
```
Compare [foreign system] to our [indigenous system].
Identify working principles to adopt.
```

## Leverage Points (Meadows Framework)

| Level | Leverage Point | Agent |
|-------|----------------|-------|
| L1 | Transcendence | Reflector |
| L2 | Paradigm | Modeler, Reflector |
| L3 | Goals | Modeler, Interventionist |
| L4 | Self-organization | Reflector |
| L5 | Rules | Interventionist |
| L6 | Information flows | Diagnostician, Modeler |
| L7 | Reinforcing loops | Interventionist, Reflector |
| L10 | Physical structure | Diagnostician |

## Integrated Skills

| Skill | Integration Point |
|-------|-------------------|
| `pahl-beitz-mastery` | Function structure methodology |
| `meadows-leverage-analyzer` | Prioritization across agents |
| `feedback-loop-detector` | Control system analysis |
| `stock-flow-mapper` | Flow identification |
| `engineering-design-review-mentor` | Quality assurance |
| `engineering-concept-evaluation-assistant` | VDI 2225 evaluation |

## Documentation

| Document | Description |
|----------|-------------|
| [SKILL.md](SKILL.md) | Complete system specification |
| [QUICK-START.md](QUICK-START.md) | Setup guide |
| [Architecture Diagrams](docs/architecture-diagram.md) | Visual architecture |
| [Operational Runbook](docs/runbook.md) | Procedures & recovery |
| [Error Schema](schemas/error-schema.yaml) | Error codes |
| [Handoff Templates](templates/handoff-templates.yaml) | Message templates |

## License

Proprietary - Internal Use Only

## Contact

Nguyen Hung - nguyenhung@uxvina.com

---

*Built with Claude Code and MCP*
