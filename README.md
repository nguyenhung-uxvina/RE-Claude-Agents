# Reverse Engineering Agent System

A multi-agent system for systematic reverse engineering of foreign military systems using the D-M-I-R framework (Diagnosis, Modeling, Intervention, Reflection).

## Overview

This system provides a structured approach to reverse engineering that goes beyond measuring parts—it reconstructs **design decisions** and **designer intent**. The goal is exponential knowledge extraction through paradigm-level learning.

### Key Insight

> Reverse engineering is **design archaeology**—reconstructing decisions, not just measuring parts.

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                      ORCHESTRATOR AGENT                         │
│                (Workflow Coordinator + State Machine)            │
└───────────────────────────┬─────────────────────────────────────┘
                            │
        ┌───────────────────┼───────────────────┐
        ▼                   ▼                   ▼
┌───────────────┐   ┌───────────────┐   ┌───────────────┐
│ DIAGNOSTICIAN │──▶│    MODELER    │──▶│INTERVENTIONIST│
│   (D-Phase)   │   │   (M-Phase)   │   │   (I-Phase)   │
│ Physical→Data │   │  Data→Models  │   │Models→Actions │
└───────────────┘   └───────────────┘   └───────────────┘
                            │
                            ▼
                    ┌───────────────┐
                    │   REFLECTOR   │
                    │   (R-Phase)   │
                    │Actions→Learning│
                    └───────────────┘
```

### Agents

| Agent | Phase | Role |
|-------|-------|------|
| **Orchestrator** | All | Workflow coordination, state management, agent routing |
| **Diagnostician** | D | Physical reconnaissance, documentation, pattern recognition |
| **Modeler** | M | Function structure reconstruction, working principle identification |
| **Interventionist** | I | Knowledge extraction, application strategies, recommendations |
| **Reflector** | R | Meta-learning, paradigm analysis, process improvement |

### MCP Server Integration

- **Airtable** - Analysis database, component tracking
- **GitHub** - Documentation repository, version control
- **Filesystem** - Local file access, CAD/image handling
- **Sequential Thinking** - Complex reasoning chains
- **Brave Search** - Technical reference lookup
- **Memory** - Cross-session knowledge persistence
- **Obsidian** - Knowledge base integration

## Project Structure

```
RE-Claude-Agents/
├── SKILL.md                    # Main system specification
├── QUICK-START.md              # 30-minute setup guide
├── LEVERAGE-ANALYSIS.md        # Systems theory analysis
│
├── agents/                     # Agent specifications
│   ├── orchestrator.md
│   ├── diagnostician.md
│   ├── modeler.md
│   ├── interventionist.md
│   └── reflector.md
│
├── schemas/                    # YAML schemas
│   ├── input-schema.yaml       # Input formats
│   ├── output-schema.yaml      # Output formats
│   └── handoff-schema.yaml     # Inter-agent communication
│
├── templates/                  # Reusable templates
│   ├── diagnosis-template.md
│   ├── function-structure.yaml
│   ├── working-principles.yaml
│   └── vdi-2225-evaluation.md
│
├── references/                 # Technical references
│   ├── physical-effects-catalog.md
│   ├── design-paradigms.md
│   └── mil-spec-reference.md
│
└── examples/                   # Worked examples
    ├── rcws-analysis/          # RCWS reverse engineering
    └── target-uav-analysis/    # UAV technology insertion
```

## Quick Start

### 1. Configure MCP Servers

```bash
claude mcp add airtable-mcp --env AIRTABLE_API_KEY=pat_xxxxx -- npx -y @anthropic/airtable-mcp
claude mcp add github-mcp --env GITHUB_TOKEN=ghp_xxxxx -- npx -y @anthropic/github-mcp
claude mcp add sequential-thinking -- npx -y @anthropic/sequential-thinking-mcp
claude mcp add brave-search --env BRAVE_API_KEY=BSA_xxxxx -- npx -y @anthropic/brave-search-mcp
claude mcp add memory -- npx -y @anthropic/memory-mcp
claude mcp add filesystem --env ALLOWED_PATHS=/path/to/projects -- npx -y @anthropic/filesystem-mcp
```

### 2. Set Up Airtable Database

Create base with tables: **Projects**, **Components**, **Functions**, **Lessons Learned**

See [QUICK-START.md](QUICK-START.md) for detailed table schemas.

### 3. Run First Analysis

```
Using the reverse-engineering-agent-system skill, analyze this system:

System: [Your system designation]
Objective: [replicate/counter/insert_tech/understand]
Access: [full/partial/remote]

Start with DIAGNOSIS phase.
```

## Usage Patterns

### Full Analysis
```
Reverse engineer captured [system].
Goal: Develop indigenous alternative for [application].
```

### Targeted Analysis
```
Analyze the [subsystem] of [system].
Focus: Working principles and control algorithms.
```

### Counter-System Development
```
Analyze [threat system] vulnerabilities.
Goal: Develop countermeasures.
```

### Technology Insertion
```
Compare [foreign system] to our [indigenous system].
Identify working principles we should adopt.
```

## Core Methodology

### D-M-I-R Framework

1. **Diagnosis** - Document physical evidence systematically
2. **Modeling** - Reconstruct function structure and working principles
3. **Intervention** - Extract actionable knowledge and recommendations
4. **Reflection** - Capture lessons and improve the process

### Leverage Point Optimization

The system targets high-leverage interventions (Meadows' framework):

| Level | Focus | Impact |
|-------|-------|--------|
| L2 | Paradigm | 10x knowledge extraction |
| L3 | Goals | Capability alignment |
| L5 | Rules | Quality enforcement |
| L6 | Information | MCP-enabled data access |
| L7 | Reinforcing Loops | Knowledge accumulation |

## Documentation

- [SKILL.md](SKILL.md) - Complete system specification
- [QUICK-START.md](QUICK-START.md) - Setup and first project guide
- [LEVERAGE-ANALYSIS.md](LEVERAGE-ANALYSIS.md) - Systems theory foundation

## Examples

- [RCWS Analysis](examples/rcws-analysis/) - Full military system reverse engineering
- [Target UAV](examples/target-uav-analysis/) - Commercial system technology insertion

## Integrated Skills

| Skill | Integration Point |
|-------|-------------------|
| `pahl-beitz-mastery` | Function structure methodology |
| `meadows-leverage-analyzer` | Prioritization across all agents |
| `feedback-loop-detector` | Control system analysis |
| `stock-flow-mapper` | Flow identification |
| `engineering-design-review-mentor` | Quality assurance |
| `engineering-concept-evaluation-assistant` | VDI 2225 evaluation |

## License

Proprietary - Internal Use Only

## Contact

Nguyen Hung - nguyenhung@uxvina.com
