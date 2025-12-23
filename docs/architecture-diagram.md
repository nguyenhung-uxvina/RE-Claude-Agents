# RE Agent System Architecture

## System Overview

```mermaid
flowchart TB
    subgraph External["External Inputs"]
        USER[("👤 Human Operator")]
        SPECIMEN["📦 Physical Specimen"]
    end

    subgraph Orchestration["Orchestration Layer"]
        ORCH["🎯 ORCHESTRATOR<br/>State Machine + Loop Control"]
    end

    subgraph Agents["Specialist Agents"]
        DIAG["🔍 DIAGNOSTICIAN<br/>Physical Reconnaissance"]
        MOD["📐 MODELER<br/>Function Structure"]
        INT["⚡ INTERVENTIONIST<br/>Application Strategy"]
        REF["🪞 REFLECTOR<br/>Meta-Learning"]
    end

    subgraph Storage["Persistent Storage"]
        AT[("🗄️ Airtable<br/>Structured Data")]
        GH[("📁 GitHub<br/>Artifacts/Docs")]
        MEM[("🧠 Memory<br/>Cross-Project")]
    end

    subgraph MCPServers["MCP Servers"]
        MCP_AT["airtable-mcp"]
        MCP_GH["github-mcp"]
        MCP_FS["filesystem-mcp"]
        MCP_BR["brave-search-mcp"]
        MCP_SEQ["sequential-thinking"]
        MCP_MEM["memory-mcp"]
        MCP_OBS["obsidian-mcp"]
    end

    USER -->|"Project Request"| ORCH
    SPECIMEN -->|"Physical Access"| DIAG

    ORCH <-->|"Handoffs"| DIAG
    ORCH <-->|"Handoffs"| MOD
    ORCH <-->|"Handoffs"| INT
    ORCH <-->|"Handoffs"| REF

    DIAG -.->|"Verification Loop"| MOD

    Agents --> MCP_AT --> AT
    Agents --> MCP_GH --> GH
    Agents --> MCP_MEM --> MEM
    Agents --> MCP_FS
    Agents --> MCP_BR
    Agents --> MCP_SEQ
    REF --> MCP_OBS

    ORCH -->|"Escalation"| USER
```

## State Machine Flow

```mermaid
stateDiagram-v2
    [*] --> INIT: Project Created

    INIT --> DIAGNOSIS: Start Analysis

    DIAGNOSIS --> MODELING: Documentation Complete<br/>(≥80% completeness)
    DIAGNOSIS --> DIAGNOSIS: Gap Detected<br/>(max 3 iterations)

    MODELING --> INTERVENTION: Models Validated<br/>(≥90% validation)
    MODELING --> DIAGNOSIS: Verification Needed
    MODELING --> MODELING: Refinement Loop<br/>(max 5 iterations)

    INTERVENTION --> REFLECTION: Recommendations Ready
    INTERVENTION --> MODELING: Model Refinement Needed

    REFLECTION --> COMPLETE: Project Closure
    REFLECTION --> DIAGNOSIS: New Cycle Recommended

    DIAGNOSIS --> ERROR: Unrecoverable Error
    MODELING --> ERROR: Unrecoverable Error
    INTERVENTION --> ERROR: Unrecoverable Error
    REFLECTION --> ERROR: Unrecoverable Error

    DIAGNOSIS --> ESCALATED: Human Required
    MODELING --> ESCALATED: Human Required
    INTERVENTION --> ESCALATED: Human Required
    REFLECTION --> ESCALATED: Human Required

    ERROR --> [*]
    ESCALATED --> [*]
    COMPLETE --> [*]
```

## Agent Communication Protocol

```mermaid
sequenceDiagram
    participant O as Orchestrator
    participant D as Diagnostician
    participant M as Modeler
    participant I as Interventionist
    participant R as Reflector

    Note over O: Project Initialized (INIT)

    rect rgb(200, 220, 240)
        Note over O,D: DIAGNOSIS Phase
        O->>D: DIAGNOSIS_REQUEST
        D-->>O: ACK
        D->>D: Document System
        D-->>O: DIAGNOSIS_COMPLETE
        O->>O: Checkpoint
    end

    rect rgb(220, 240, 200)
        Note over O,M: MODELING Phase
        O->>M: MODELING_REQUEST
        M-->>O: ACK
        M->>M: Build Function Structure

        opt Verification Needed
            M->>O: VERIFICATION_NEEDED
            O->>D: VERIFICATION_REQUEST
            D-->>O: VERIFICATION_RESPONSE
            O->>M: VERIFICATION_DATA
        end

        M-->>O: MODELING_COMPLETE
        O->>O: Checkpoint
    end

    rect rgb(240, 220, 200)
        Note over O,I: INTERVENTION Phase
        O->>I: INTERVENTION_REQUEST
        I-->>O: ACK
        I->>I: Generate Recommendations
        I-->>O: INTERVENTION_COMPLETE
        O->>O: Checkpoint
    end

    rect rgb(240, 200, 240)
        Note over O,R: REFLECTION Phase
        O->>R: REFLECTION_REQUEST
        R-->>O: ACK
        R->>R: Capture Lessons
        R-->>O: REFLECTION_COMPLETE
        O->>O: Final Checkpoint
    end

    Note over O: Project Complete
```

## Data Flow Architecture

```mermaid
flowchart LR
    subgraph Inputs["📥 Inputs"]
        PHY["Physical Specimen"]
        DOC["Existing Docs"]
        OBJ["Objectives"]
    end

    subgraph DIAG_Process["DIAGNOSIS"]
        D1["External Observation"]
        D2["Subsystem Decomposition"]
        D3["Component Analysis"]
        D4["Pattern Recognition"]
    end

    subgraph DIAG_Output["Diagnosis Artifacts"]
        DR["Diagnosis Report"]
        CC["Component Catalog"]
        PI["Pattern Indicators"]
    end

    subgraph MOD_Process["MODELING"]
        M1["Flow Identification"]
        M2["Subfunction Extraction"]
        M3["Working Principle ID"]
        M4["Function Structure"]
    end

    subgraph MOD_Output["Modeling Artifacts"]
        FS["Function Structure<br/>Diagram"]
        WP["Working Principles<br/>Catalog"]
        DP["Design Paradigm<br/>Analysis"]
    end

    subgraph INT_Process["INTERVENTION"]
        I1["Replication Analysis"]
        I2["Counter-System Analysis"]
        I3["Tech Insertion Analysis"]
        I4["Leverage Mapping"]
    end

    subgraph INT_Output["Intervention Artifacts"]
        REC["Recommendations"]
        FEAS["Feasibility<br/>Assessments"]
        ROAD["Implementation<br/>Roadmap"]
    end

    subgraph REF_Process["REFLECTION"]
        R1["After-Action Review"]
        R2["Paradigm Assessment"]
        R3["Capability Assessment"]
        R4["Knowledge Capture"]
    end

    subgraph REF_Output["Reflection Artifacts"]
        LL["Lessons Learned"]
        PROC["Process<br/>Improvements"]
        KNOW["Knowledge Base<br/>Updates"]
    end

    PHY --> D1
    DOC --> D1
    OBJ --> D1

    D1 --> D2 --> D3 --> D4
    D4 --> DR & CC & PI

    DR & CC & PI --> M1
    M1 --> M2 --> M3 --> M4
    M4 --> FS & WP & DP

    FS & WP & DP --> I1 & I2 & I3
    I1 & I2 & I3 --> I4
    I4 --> REC & FEAS & ROAD

    REC & FEAS & ROAD --> R1
    R1 --> R2 --> R3 --> R4
    R4 --> LL & PROC & KNOW
```

## Handoff Protocol (ACK/NACK)

```mermaid
sequenceDiagram
    participant S as Sender Agent
    participant R as Receiver Agent

    S->>R: Handoff Message<br/>{handoff_id, payload, timeout}

    alt Valid Input
        R-->>S: ACK<br/>{estimated_completion}
        R->>R: Process Request

        alt Success
            R-->>S: COMPLETE<br/>{results, artifacts}
        else Partial Success
            R-->>S: PARTIAL<br/>{partial_results, gaps}
        else Error
            R-->>S: ERROR<br/>{error_code, recovery_options}
        end

    else Invalid Input
        R-->>S: NACK_INVALID<br/>{validation_errors}

    else Agent Busy
        R-->>S: NACK_BUSY<br/>{queue_position, availability}

    else Timeout
        Note over S: No response within timeout
        S->>S: Retry with backoff<br/>(max 3 attempts)
        S-->>S: ESCALATE if all retries fail
    end
```

## Error Handling & Escalation

```mermaid
flowchart TB
    subgraph Detection["Error Detection"]
        ERR["Error Occurred"]
    end

    subgraph Classification["Error Classification"]
        E1["E001-E099<br/>Input Errors"]
        E2["E100-E199<br/>Resource Errors"]
        E3["E200-E299<br/>Processing Errors"]
        E4["E300-E399<br/>System Errors"]
    end

    subgraph Recovery["Recovery Actions"]
        R1["Fix Input<br/>& Retry"]
        R2["Verify Resource<br/>& Retry"]
        R3["Alternative<br/>Approach"]
        R4["Wait & Retry<br/>with Backoff"]
    end

    subgraph Escalation["Escalation Levels"]
        L1["L1: Orchestrator<br/>(Automatic)"]
        L2["L2: Human Operator<br/>(15 min response)"]
        L3["L3: Project Lead<br/>(4 hour response)"]
        L4["L4: System Admin<br/>(1 hour response)"]
    end

    ERR --> E1 & E2 & E3 & E4

    E1 --> R1
    E2 --> R2
    E3 --> R3
    E4 --> R4

    R1 -->|"3 failures"| L2
    R2 -->|"5 failures"| L2
    R3 -->|"No progress"| L3
    R4 -->|"Service down"| L4

    L2 -->|"Cannot resolve"| L3
    L3 -->|"System issue"| L4
```

## Checkpoint & Recovery

```mermaid
flowchart TB
    subgraph Triggers["Checkpoint Triggers"]
        T1["State Transition"]
        T2["Handoff Complete"]
        T3["Artifact Created"]
        T4["Every 30 Minutes"]
        T5["Before Error"]
    end

    subgraph Checkpoint["Checkpoint Data"]
        CP["📸 Checkpoint"]
        CP_STATE["State Machine State"]
        CP_ITER["Iteration Count"]
        CP_AGENTS["Agent States"]
        CP_ARTIFACTS["Artifact References<br/>(with checksums)"]
        CP_PROGRESS["Progress Metrics"]
        CP_PENDING["Pending Work"]
    end

    subgraph Storage["Checkpoint Storage"]
        S_AT["Airtable<br/>(Metadata)"]
        S_LOCAL["Local File<br/>(Full Data)"]
        S_GH["GitHub Archive<br/>(Long-term)"]
    end

    subgraph Recovery["Recovery Process"]
        REC1["1. Load Checkpoint"]
        REC2["2. Verify Artifacts"]
        REC3["3. Restore State"]
        REC4["4. Restore Agents"]
        REC5["5. Replay Pending"]
        REC6["6. Resume Processing"]
    end

    T1 & T2 & T3 & T4 & T5 --> CP
    CP --> CP_STATE & CP_ITER & CP_AGENTS & CP_ARTIFACTS & CP_PROGRESS & CP_PENDING
    CP --> S_AT & S_LOCAL
    S_LOCAL -->|"After 30 days"| S_GH

    S_AT & S_LOCAL --> REC1
    REC1 --> REC2 --> REC3 --> REC4 --> REC5 --> REC6
```

## MCP Server Integration

```mermaid
flowchart TB
    subgraph Agents["RE Agents"]
        ORCH["Orchestrator"]
        DIAG["Diagnostician"]
        MOD["Modeler"]
        INT["Interventionist"]
        REF["Reflector"]
    end

    subgraph Required["Required MCP Servers"]
        AT["🗄️ Airtable MCP<br/>Structured data storage"]
        GH["📁 GitHub MCP<br/>Artifact versioning"]
        FS["📂 Filesystem MCP<br/>Local file access"]
        BR["🔍 Brave Search MCP<br/>Part/spec lookup"]
        SEQ["🧠 Sequential Thinking<br/>Multi-step reasoning"]
        MEM["💾 Memory MCP<br/>Cross-project knowledge"]
    end

    subgraph Optional["Optional MCP Servers"]
        OBS["📝 Obsidian MCP<br/>Knowledge notes"]
        QC["📊 QuickChart MCP<br/>Visualizations"]
        MER["🎨 Mermaid MCP<br/>Diagrams"]
    end

    ORCH --> AT & GH & MEM
    DIAG --> AT & FS & BR & SEQ
    MOD --> AT & GH & SEQ & OBS
    INT --> AT & GH & BR & MEM
    REF --> AT & GH & MEM & OBS

    MOD -.-> QC & MER
```

## Airtable Schema

```mermaid
erDiagram
    Projects ||--o{ Components : contains
    Projects ||--o{ Functions : has
    Projects ||--o{ Recommendations : generates
    Projects ||--o{ Lessons_Learned : produces
    Projects ||--o{ System_Logs : logs
    Projects ||--o{ Checkpoints : saves

    Components ||--o{ Components : parent_of
    Components }o--|| Functions : realizes

    Functions ||--o{ Functions : parent_of
    Functions ||--o{ Working_Principles : uses

    Projects {
        string project_id PK
        string designation
        enum status
        enum objective
        string origin_country
        datetime created_at
    }

    Components {
        string component_id PK
        string project_id FK
        string name
        enum type
        string parent_id FK
        string function_id FK
        string manufacturer
        string part_number
    }

    Functions {
        string function_id PK
        string project_id FK
        string statement
        string parent_id FK
        int level
        bool essential
    }

    Working_Principles {
        string principle_id PK
        string function_id FK
        string name
        string physical_effect
        enum category
        enum novelty
    }

    Recommendations {
        string recommendation_id PK
        string project_id FK
        enum type
        string summary
        number feasibility
        enum priority
        enum status
    }

    Lessons_Learned {
        string lesson_id PK
        string project_id FK
        enum category
        text insight
        text action
        enum status
    }

    System_Logs {
        string log_id PK
        datetime timestamp
        enum level
        enum agent_id
        string project_id FK
        string message
    }

    Checkpoints {
        string checkpoint_id PK
        string project_id FK
        datetime timestamp
        enum state
        int iteration
        enum trigger
        url data_uri
    }
```

## Loop Control & Termination

```mermaid
flowchart TB
    subgraph GlobalLimits["Global Limits"]
        GL1["Max Total Iterations: 20"]
        GL2["Max Duration: 30 days"]
        GL3["Idle Timeout: 48 hours"]
    end

    subgraph DiagnosisLoop["Diagnosis Loop"]
        DL_START["Start Diagnosis"]
        DL_CHECK{"Completeness<br/>≥ 80%?"}
        DL_ITER{"Iterations<br/>< 3?"}
        DL_PROG{"Progress<br/>≥ 10%?"}
        DL_CONT["Continue<br/>Diagnosis"]
        DL_DONE["→ MODELING"]
        DL_ESC["→ ESCALATE"]
    end

    subgraph ModelingLoop["Modeling Verification Loop"]
        ML_START["Start Verification"]
        ML_CHECK{"All Verified?"}
        ML_ITER{"Iterations<br/>< 5?"}
        ML_BATCH["Process Batch<br/>(max 3)"]
        ML_DONE["→ INTERVENTION"]
        ML_CAVEAT["→ PROCEED<br/>WITH CAVEATS"]
    end

    DL_START --> DL_CHECK
    DL_CHECK -->|"Yes"| DL_DONE
    DL_CHECK -->|"No"| DL_ITER
    DL_ITER -->|"Yes"| DL_PROG
    DL_ITER -->|"No"| DL_ESC
    DL_PROG -->|"Yes"| DL_CONT --> DL_CHECK
    DL_PROG -->|"No"| DL_ESC

    ML_START --> ML_CHECK
    ML_CHECK -->|"Yes"| ML_DONE
    ML_CHECK -->|"No"| ML_ITER
    ML_ITER -->|"Yes"| ML_BATCH --> ML_CHECK
    ML_ITER -->|"No"| ML_CAVEAT

    GlobalLimits -.->|"Enforced on all loops"| DiagnosisLoop
    GlobalLimits -.->|"Enforced on all loops"| ModelingLoop
```

---

## Quick Reference

| Component | Purpose | Key Files |
|-----------|---------|-----------|
| Orchestrator | State machine, routing, escalation | `agents/orchestrator.md` |
| Diagnostician | Physical documentation | `agents/diagnostician.md` |
| Modeler | Function structure reconstruction | `agents/modeler.md` |
| Interventionist | Application strategy | `agents/interventionist.md` |
| Reflector | Meta-learning, knowledge capture | `agents/reflector.md` |
| Handoff Schema | Message formats | `schemas/handoff-schema.yaml` |
| Error Schema | Error codes & recovery | `schemas/error-schema.yaml` |
| Checkpoint Schema | State persistence | `schemas/checkpoint-schema.yaml` |

---

*Generated: 2025-12-23*
