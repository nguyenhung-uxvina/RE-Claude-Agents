---
name: reverse-engineering-agent-system
description: Multi-agent system for reverse engineering foreign military systems using D-M-I-R framework. Orchestrates specialized agents (Diagnostician, Modeler, Interventionist, Reflector) with MCP server integration for systematic analysis of foreign military equipment to enable replication, counter-system development, or technology insertion. Use when analyzing foreign military hardware, reconstructing design intent, developing indigenous alternatives, or building counter-system capabilities.
---

# Reverse Engineering Agent System

A systems-based multi-agent architecture for reverse engineering foreign military systems, applying D-M-I-R framework with leverage point optimization for exponential knowledge extraction.

## System Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           ORCHESTRATOR AGENT                                │
│                    (Workflow Coordinator + State Machine)                   │
│                                                                             │
│  Triggers: "reverse engineer", "analyze foreign system", "replicate",       │
│            "counter-system", "technology insertion"                         │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
         ┌──────────────────────────┼──────────────────────────┐
         ▼                          ▼                          ▼
┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
│  DIAGNOSTICIAN  │      │     MODELER     │      │ INTERVENTIONIST │
│     AGENT       │ ───► │     AGENT       │ ───► │     AGENT       │
│                 │      │                 │      │                 │
│ D-M-I-R: D      │      │ D-M-I-R: M      │      │ D-M-I-R: I      │
│ Physical→Data   │      │ Data→Models     │      │ Models→Actions  │
└─────────────────┘      └─────────────────┘      └─────────────────┘
         │                        │                        │
         └────────────────────────┴────────────────────────┘
                                  │
                                  ▼
                       ┌─────────────────┐
                       │    REFLECTOR    │
                       │     AGENT       │
                       │                 │
                       │ D-M-I-R: R      │
                       │ Actions→Learning│
                       └─────────────────┘

MCP SERVERS:
├── airtable-mcp      → Analysis database, component tracking
├── github-mcp        → Documentation repository, version control
├── filesystem-mcp    → Local file access, CAD/image handling
├── sequential-mcp    → Complex reasoning chains
├── brave-search-mcp  → Technical reference search
├── memory-mcp        → Cross-session knowledge persistence
└── obsidian-mcp      → Knowledge base integration
```

## Core Philosophy

**Leverage Point Focus**: This system targets L2-L6 (paradigm, goals, rules, information flows) rather than just L10-L12 (physical structure, parameters). The goal is to extract **design intent** and **designer paradigm**, not just measurements.

**Key Insight**: Reverse engineering is **design archaeology** - reconstructing decisions, not just measuring parts.

## Agent Specifications

---

### 1. ORCHESTRATOR AGENT

**Role**: Workflow coordinator, state management, agent routing

**Trigger Patterns**:
- "reverse engineer [system]"
- "analyze foreign [equipment/system]"
- "replicate [system]"
- "develop counter-system for [threat]"
- "technology insertion from [source]"
- "how does [foreign system] work"

**State Machine**:
```
STATES:
├── INIT           → Receive system, validate inputs
├── DIAGNOSIS      → Route to Diagnostician
├── MODELING       → Route to Modeler  
├── INTERVENTION   → Route to Interventionist
├── REFLECTION     → Route to Reflector
├── COMPLETE       → Deliver final report
└── ERROR          → Handle failures, retry logic

TRANSITIONS:
INIT ──────────────► DIAGNOSIS (always)
DIAGNOSIS ─────────► MODELING (when documentation complete)
DIAGNOSIS ─────────► DIAGNOSIS (when gaps detected)
MODELING ──────────► INTERVENTION (when models validated)
MODELING ──────────► DIAGNOSIS (when physical evidence needed)
INTERVENTION ──────► REFLECTION (when recommendations ready)
REFLECTION ────────► COMPLETE (when learning captured)
REFLECTION ────────► DIAGNOSIS (when new cycle needed)
```

**MCP Dependencies**:
- `airtable-mcp`: Project state tracking, agent handoffs
- `memory-mcp`: Cross-session persistence

**Input Schema**:
```yaml
system_identification:
  designation: string           # Foreign system name/designation
  origin_country: string        # Country of origin
  specimen_type: enum           # [physical, documentation, intelligence, captured]
  access_level: enum            # [full, partial, remote, destroyed]
  security_classification: enum # [UNCLASSIFIED, RESTRICTED, SECRET]

analysis_objective:
  primary_goal: enum            # [replicate, counter, insert_tech, understand]
  target_systems: list          # Vietnamese systems to apply knowledge
  timeline: string              # Analysis deadline
  
constraints:
  available_equipment: list     # Test equipment available
  personnel_expertise: list     # Team capabilities
  budget: number               # Resources available
```

**Output Schema**:
```yaml
analysis_complete:
  status: enum                  # [complete, partial, blocked]
  deliverables:
    function_structure: uri     # Function structure document
    working_principles: uri     # Working principle catalog
    recommendations: uri        # Application recommendations
    paradigm_analysis: uri      # Design philosophy report
  next_actions: list           # Recommended follow-up
  lessons_learned: list        # Process improvements
```

**Workflow Orchestration Logic**:
```python
def orchestrate(input):
    # Initialize analysis project in Airtable
    project_id = airtable.create_project(input)
    
    # Phase 1: Diagnosis
    while not diagnosis_complete:
        documentation = diagnostician.analyze(input, project_id)
        if documentation.gaps_detected:
            # Request additional physical access
            request_additional_access(documentation.gaps)
        else:
            diagnosis_complete = True
    
    # Phase 2: Modeling
    while not modeling_complete:
        models = modeler.reconstruct(documentation, project_id)
        if models.needs_physical_verification:
            # Route back to Diagnostician
            verification = diagnostician.verify(models.verification_requests)
            models = modeler.update(models, verification)
        else:
            modeling_complete = True
    
    # Phase 3: Intervention
    recommendations = interventionist.extract(models, input.analysis_objective)
    
    # Phase 4: Reflection
    lessons = reflector.capture(project_id, recommendations)
    
    # Complete
    return compile_final_report(project_id)
```

---

### 2. DIAGNOSTICIAN AGENT

**Role**: Physical reconnaissance, documentation, pattern recognition

**D-M-I-R Phase**: DIAGNOSIS

**Leverage Points Targeted**:
- L6 (Information Flows): Systematic documentation creates information asymmetry advantage
- L10 (Structure): Physical structure mapping

**Trigger from Orchestrator**:
- "document system [system_id]"
- "verify physical evidence for [model_id]"
- "gap analysis for [documentation_id]"

**MCP Dependencies**:
- `filesystem-mcp`: Access images, CAD files, measurements
- `airtable-mcp`: Component database, tracking
- `brave-search-mcp`: Part number lookup, technical references
- `sequential-mcp`: Multi-step reasoning for pattern recognition

**Skills Invoked**:
- `stock-flow-mapper`: Identify physical flows (energy, material, signal)
- `engineering-design-review-mentor`: Quality check documentation

**Input Schema**:
```yaml
documentation_request:
  system_id: string
  specimen_access: object
    location: string
    access_duration: hours
    handling_restrictions: list
  documentation_level: enum    # [external, subsystem, component]
  focus_areas: list            # Specific subsystems if known
  existing_documentation: list # Previous analysis references
```

**Analysis Process**:

**Level 1: External Observation (Non-destructive)**
```yaml
external_documentation:
  dimensional:
    overall_dimensions: [L, W, H]
    weight: kg
    mounting_interfaces: list
  interfaces:
    electrical_connectors: list    # Type, pin count, voltage markings
    hydraulic_ports: list
    pneumatic_fittings: list
    data_interfaces: list
  markings:
    manufacturer_labels: list
    part_numbers: list              # CRITICAL intelligence
    serial_numbers: list
    mil_spec_markings: list
    safety_warnings: list
  materials:
    visible_materials: list
    surface_treatments: list        # Anodizing, painting, plating
    corrosion_evidence: list
```

**Level 2: Subsystem Decomposition**
```yaml
subsystem_documentation:
  assembly_hierarchy:
    top_level_assemblies: list
    subassembly_breakdown: tree
    fastener_types: list            # Torque markings if visible
  interfaces:
    cable_harness_routing: diagram
    mechanical_connections: list
    seal_types: list
    lubrication_points: list
  manufacturing_signatures:
    casting_marks: list
    machining_patterns: list
    assembly_sequence_evidence: list
```

**Level 3: Component Analysis**
```yaml
component_documentation:
  for_each_component:
    part_identification:
      marking: string
      commercial_equivalent: string  # If identified
      custom_vs_cots: enum
    material_analysis:
      visual_identification: string
      spectrometry_result: object   # If available
    manufacturing:
      process_signatures: list      # Casting, forging, machining
      tolerance_indicators: list
    wear_analysis:
      wear_patterns: list           # Indicates operating conditions
      failure_modes_evident: list
```

**Pattern Recognition Module**:

```yaml
design_paradigm_indicators:
  safety_margins:
    observed_factors: number       # Calculate from sizing
    risk_tolerance: enum           # [conservative, balanced, aggressive]
    reliability_philosophy: string
  
  modularity:
    module_boundaries: list
    interface_standardization: level
    maintenance_philosophy: string  # Field-replaceable? Depot-level?
    upgrade_provisions: list
  
  material_selection:
    cost_vs_performance: ratio
    weight_sensitivity: level
    environmental_requirements: list
  
  manufacturing_approach:
    volume_indicators: list        # Casting vs machining
    automation_level: estimate
    quality_control_evidence: list
  
  redundancy:
    redundant_systems: list
    failure_mode_provisions: list
    mission_criticality_indicators: list
```

**Output Schema**:
```yaml
diagnosis_report:
  documentation_completeness: percentage
  
  physical_data:
    external_observation: object
    subsystem_decomposition: object
    component_catalog: list
    
  pattern_analysis:
    design_paradigm: object
    manufacturing_paradigm: object
    quality_paradigm: object
    
  gaps_detected:
    missing_documentation: list
    access_required: list
    equipment_needed: list
    
  intelligence_value:
    part_numbers_decoded: list     # Traceable to suppliers
    mil_spec_identified: list
    design_standards_inferred: list
    
  handoff_to_modeler:
    ready: boolean
    blockers: list
```

---

### 3. MODELER AGENT

**Role**: Function structure reconstruction, working principle identification

**D-M-I-R Phase**: MODELING

**Leverage Points Targeted**:
- L2 (Paradigm): Reconstruct designer's mental model
- L3 (Goals): Identify system goals (stated vs actual)
- L6 (Information): Create complete system model

**Key Insight**: The function structure is the "Rosetta Stone" - it allows translation between foreign implementation and indigenous alternatives.

**Trigger from Orchestrator**:
- "reconstruct function structure for [diagnosis_id]"
- "identify working principles for [subsystem_id]"
- "validate model with [verification_data]"

**MCP Dependencies**:
- `airtable-mcp`: Function structure database, working principle catalog
- `github-mcp`: Store validated models, version control
- `sequential-mcp`: Multi-step reasoning for function decomposition
- `obsidian-mcp`: Cross-reference with engineering knowledge base

**Skills Invoked**:
- `stock-flow-mapper`: Map energy/material/signal flows
- `feedback-loop-detector`: Identify control loops in system
- `meadows-leverage-analyzer`: Analyze system leverage points
- `pahl-beitz-mastery`: Apply systematic design methodology

**Reconstruction Process**:

**Step 1: Flow Identification**
```yaml
flow_analysis:
  energy_flows:
    - input: [type, source, magnitude]
      transformations: list
      output: [type, destination, magnitude]
  
  material_flows:
    - input: [material, form, rate]
      transformations: list
      output: [material, form, rate]
  
  signal_flows:
    - input: [signal_type, source, format]
      processing: list
      output: [signal_type, destination, format]
```

**Step 2: Subfunction Extraction**
```yaml
subfunction_hierarchy:
  overall_function: string        # Single sentence: verb + noun + qualifier
  
  primary_subfunctions:           # Level 1 decomposition
    - id: F1
      statement: string           # "Convert electrical energy to rotation"
      inputs: list
      outputs: list
      physical_elements: list     # Components that realize this
      
  secondary_subfunctions:         # Level 2 decomposition
    - parent: F1
      id: F1.1
      statement: string
      # ... recursive structure
```

**Step 3: Working Principle Identification**

For each subfunction, identify:
```yaml
working_principle_catalog:
  - subfunction_id: F1.1
    physical_effect: string        # "Electromagnetic induction"
    effect_carrier: string         # "Permanent magnet + wound stator"
    form_design_features:
      - feature: string
        purpose: string
    working_principle_name: string # "Brushless DC motor"
    
    alternatives_considered:       # What designer could have chosen
      - principle: string
        why_not_chosen: string     # Inferred trade-off
        
    design_catalog_reference:      # Pahl & Beitz physical effects
      catalog_id: string
      figure_reference: string
```

**Step 4: Function Structure Diagram**
```yaml
function_structure:
  diagram_format: mermaid         # Or DOT, PlantUML
  
  mermaid_code: |
    flowchart TB
      subgraph OVERALL["Enable remote engagement from protected position"]
        subgraph F1["F1: ACQUIRE TARGET"]
          F1.1["Sense visual spectrum"]
          F1.2["Sense thermal spectrum"]
          F1.3["Process imagery"]
          F1.4["Display to operator"]
        end
        
        subgraph F2["F2: TRACK TARGET"]
          F2.1["Calculate motion"]
          F2.2["Predict position"]
          F2.3["Generate commands"]
        end
        
        %% Energy flows (red)
        ElecPower["⚡ Electrical Power"] --> F1.1
        
        %% Signal flows (blue)
        F1.1 --> |video| F1.3
        F1.3 --> |processed| F2.1
      end
```

**Step 5: Model Validation**
```yaml
validation_checklist:
  completeness:
    - all_components_mapped: boolean
    - all_flows_traced: boolean
    - all_functions_assigned: boolean
    
  consistency:
    - energy_conservation: boolean  # Inputs = outputs + losses
    - material_balance: boolean
    - signal_integrity: boolean
    
  verification_needed:
    - hypothesis: string
      test_method: string
      status: enum [verified, unverified, contradicted]
```

**Output Schema**:
```yaml
modeling_report:
  function_structure:
    overall_function: string
    hierarchy: tree
    diagram: uri                  # Mermaid/DOT file
    
  working_principles:
    catalog: list
    novel_solutions: list         # Unexpected/innovative approaches
    trade_offs_revealed: list
    
  design_paradigm_reconstruction:
    stated_goal: string           # What system claims to do
    actual_goal: string           # What it actually optimizes
    key_constraints: list
    design_philosophy: string     # L2 paradigm statement
    
  performance_estimation:
    derived_specifications: list
    confidence_levels: object
    validation_requirements: list
    
  handoff_to_interventionist:
    ready: boolean
    models_validated: list
    uncertainties: list
```

---

### 4. INTERVENTIONIST AGENT

**Role**: Knowledge extraction, application strategy, recommendation generation

**D-M-I-R Phase**: INTERVENTION

**Leverage Points Targeted**:
- L3 (Goals): Define application goals
- L5 (Rules): Design rules for indigenous development
- L7 (Reinforcing Loops): Create capability-building loops

**Trigger from Orchestrator**:
- "extract knowledge for [objective]"
- "develop recommendations for [target_system]"
- "generate counter-system strategy for [threat]"

**MCP Dependencies**:
- `airtable-mcp`: Recommendation tracking, feasibility assessment
- `github-mcp`: Store recommendations, track implementation
- `brave-search-mcp`: Indigenous capability lookup
- `memory-mcp`: Cross-project knowledge transfer

**Skills Invoked**:
- `meadows-leverage-analyzer`: Prioritize interventions by leverage
- `engineering-concept-evaluation-assistant`: VDI 2225 evaluation
- `pahl-beitz-mastery`: Systematic design methodology

**Application Strategies**:

**Strategy A: Functional Replication (Indigenous Alternative)**
```yaml
replication_analysis:
  goal: "Create equivalent capability using available technology"
  
  for_each_function:
    function_id: string
    foreign_working_principle: string
    foreign_form_design: string
    
    indigenous_alternatives:
      - alternative_id: A1
        working_principle: string
        physical_effect: string
        local_availability: enum [available, requires_development, import_needed]
        capability_gap: string
        development_effort: estimate
        
    morphological_matrix:
      subfunctions: [F1, F2, F3...]
      solutions_per_function: [[A1, A2], [B1, B2, B3], ...]
      valid_combinations: list
      
    vdi_2225_evaluation:
      criteria: list
      weighting: list
      scores: matrix
      recommended_combination: string
```

**Strategy B: Counter-System Development**
```yaml
counter_system_analysis:
  goal: "Develop means to defeat or degrade foreign system"
  
  vulnerability_analysis:
    feedback_loops_identified:
      - loop_id: B1
        function: string
        loop_type: enum [reinforcing, balancing]
        critical_to_performance: boolean
        
    information_flows:
      - flow_id: IF1
        from: string
        to: string
        content: string
        disruption_impact: high/medium/low
        
    structural_vulnerabilities:
      - component: string
        failure_mode: string
        exploitation_method: string
        
  counter_measures:
    l6_information_attacks:
      - target_flow: IF1
        method: string
        expected_effect: string
        
    l9_delay_exploitation:
      - target_delay: string
        exploitation: string
        
    l10_structural_attacks:
      - target_component: string
        attack_method: string
        effectiveness: estimate
```

**Strategy C: Technology Insertion**
```yaml
technology_insertion_analysis:
  goal: "Adopt specific working principles to improve indigenous systems"
  
  parallel_comparison:
    foreign_function_structure: uri
    indigenous_function_structure: uri
    
  superior_solutions:
    - function: string
      foreign_solution: string
      indigenous_current: string
      performance_delta: string
      
  insertion_candidates:
    - candidate_id: TI1
      foreign_working_principle: string
      applicable_to: [list of indigenous systems]
      
      feasibility:
        technical: enum [high, medium, low]
        manufacturing: enum [high, medium, low]
        integration: enum [high, medium, low]
        
      adaptation_requirements:
        modifications_needed: list
        development_effort: estimate
        risk_assessment: string
```

**Leverage Point Mapping**:
```yaml
leverage_analysis:
  for_application:
    l2_paradigm:
      foreign_paradigm: string
      applicable_to_vietnam: boolean
      paradigm_conflicts: list
      
    l3_goals:
      foreign_goals: list
      vietnamese_goals: list
      alignment: percentage
      
    l5_rules:
      design_rules_extracted: list
      applicable_rules: list
      adaptation_needed: list
      
    l6_information:
      knowledge_gaps_filled: list
      new_information_sources: list
      
    l7_reinforcing_loops:
      capability_building_loops: list
      knowledge_accumulation_loops: list
```

**Output Schema**:
```yaml
intervention_report:
  executive_summary:
    primary_recommendation: string
    confidence_level: percentage
    expected_impact: string
    
  replication_pathway:
    feasibility: percentage
    recommended_approach: string
    critical_challenges: list
    development_timeline: estimate
    
  counter_system_options:
    vulnerabilities_identified: count
    recommended_countermeasures: list
    effectiveness_estimates: object
    
  technology_insertion:
    candidates_identified: count
    priority_insertions: list
    implementation_roadmap: timeline
    
  leverage_point_summary:
    high_leverage_findings: list    # L2-L6
    actionable_immediately: list
    requires_development: list
    
  handoff_to_reflector:
    recommendations_ready: boolean
    implementation_tracked: boolean
```

---

### 5. REFLECTOR AGENT

**Role**: Meta-learning, paradigm analysis, process improvement, knowledge capture

**D-M-I-R Phase**: REFLECTION

**Leverage Points Targeted**:
- L1 (Transcendence): Question the analysis framework itself
- L2 (Paradigm): Challenge assumptions about reverse engineering
- L4 (Self-organization): Build learning capacity

**Key Questions**:
- What did we learn about learning?
- What assumptions proved wrong?
- How can we improve the process?

**Trigger from Orchestrator**:
- "capture lessons for [project_id]"
- "analyze paradigm for [analysis_id]"
- "improve process based on [experience]"

**MCP Dependencies**:
- `airtable-mcp`: Lessons learned database
- `github-mcp`: Process improvement documentation
- `memory-mcp`: Long-term knowledge persistence
- `obsidian-mcp`: Knowledge base update

**Skills Invoked**:
- `engineering-learning-journal-keeper`: Structured reflection
- `engineering-self-assessment-rubric-generator`: Quality assessment
- `skills-mastery-system`: Capability improvement analysis

**Reflection Process**:

**After-Action Review**:
```yaml
after_action_review:
  what_was_planned:
    original_objective: string
    expected_timeline: string
    expected_outcomes: list
    
  what_actually_happened:
    actual_timeline: string
    actual_outcomes: list
    deviations: list
    
  what_worked_well:
    successes: list
    contributing_factors: list
    
  what_could_improve:
    challenges: list
    root_causes: list
    improvement_actions: list
    
  unexpected_discoveries:
    surprises: list
    paradigm_challenges: list
```

**Paradigm Assessment (L2)**:
```yaml
paradigm_analysis:
  assumptions_entering:
    - assumption: string
      source: string
      validated: boolean
      
  assumptions_challenged:
    - assumption: string
      evidence: string
      new_understanding: string
      
  mental_model_updates:
    - old_model: string
      new_model: string
      implications: list
      
  design_philosophy_insights:
    foreign_paradigm_understood: string
    transferable_principles: list
    cultural_context_factors: list
```

**Capability Building Assessment**:
```yaml
capability_assessment:
  knowledge_gaps_identified:
    - gap: string
      severity: high/medium/low
      remediation: string
      
  skills_developed:
    - skill: string
      level_before: number
      level_after: number
      
  tools_needed:
    - tool: string
      purpose: string
      acquisition_plan: string
      
  process_improvements:
    - current_process: string
      proposed_change: string
      expected_benefit: string
```

**Knowledge Persistence**:
```yaml
knowledge_capture:
  to_airtable:
    component_database_updates: list
    working_principle_additions: list
    design_pattern_catalog: list
    
  to_github:
    documentation_updates: list
    template_improvements: list
    
  to_obsidian:
    knowledge_notes: list
    concept_links: list
    
  to_memory:
    cross_project_insights: list
    team_capability_updates: list
```

**Double-Loop Learning**:
```yaml
double_loop_questions:
  single_loop:
    "Are we doing reverse engineering right?"
    improvements: list
    
  double_loop:
    "Is reverse engineering the right approach?"
    alternatives_considered:
      - approach: "License technology"
        when_better: string
      - approach: "Original design"
        when_better: string
      - approach: "Joint development"
        when_better: string
        
  meta_learning:
    "How do we learn to learn better?"
    organizational_changes: list
```

**Output Schema**:
```yaml
reflection_report:
  after_action_review: object
  
  paradigm_insights:
    assumptions_validated: list
    assumptions_challenged: list
    mental_model_updates: list
    
  capability_development:
    gaps_identified: list
    skills_built: list
    process_improvements: list
    
  knowledge_captured:
    databases_updated: list
    documentation_created: list
    cross_references: list
    
  next_cycle_recommendations:
    focus_areas: list
    methodology_changes: list
    resource_requirements: list
    
  meta_learning:
    about_learning_itself: list
    organizational_improvements: list
```

---

## MCP Server Configuration

### Airtable MCP (Primary Database)
```yaml
server: airtable-mcp
purpose: "Analysis tracking, component database, lessons learned"

bases:
  reverse_engineering_db:
    tables:
      - projects:           # Analysis projects
          fields: [id, system, status, objective, timeline]
          
      - components:         # Component catalog
          fields: [id, project, part_number, material, manufacturer, image]
          
      - functions:          # Function structure
          fields: [id, project, statement, parent, working_principle]
          
      - working_principles: # Working principle catalog
          fields: [id, function, physical_effect, form_features, source]
          
      - lessons_learned:    # Reflection outputs
          fields: [id, project, category, insight, action, status]
          
      - agent_handoffs:     # Workflow state
          fields: [id, project, from_agent, to_agent, data, timestamp]
```

### GitHub MCP (Documentation Repository)
```yaml
server: github-mcp
purpose: "Version-controlled documentation, templates, reports"

repositories:
  reverse-engineering-docs:
    structure:
      /projects/[system-id]/
        - diagnosis-report.md
        - function-structure.mermaid
        - working-principles.yaml
        - intervention-report.md
        - reflection-report.md
        
      /templates/
        - diagnosis-template.md
        - function-structure-template.yaml
        - vdi-2225-template.xlsx
        
      /knowledge-base/
        - design-catalogues/
        - working-principles-library/
        - lessons-learned-index.md
```

### Sequential Thinking MCP
```yaml
server: sequential-thinking-mcp
purpose: "Complex multi-step reasoning for analysis"

use_cases:
  - function_decomposition: "Break overall function into subfunctions"
  - pattern_recognition: "Identify design paradigm from evidence"
  - trade_off_analysis: "Infer designer decisions from form"
  - working_principle_identification: "Map physical effects to forms"
```

### Brave Search MCP
```yaml
server: brave-search-mcp
purpose: "Technical reference lookup"

use_cases:
  - part_number_lookup: "Identify commercial equivalents"
  - mil_spec_search: "Find specification requirements"
  - material_identification: "Look up material properties"
  - manufacturer_research: "Identify supply chain"
```

### Memory MCP
```yaml
server: memory-mcp
purpose: "Cross-session knowledge persistence"

entities:
  - foreign_systems: "Known foreign system characteristics"
  - working_principles: "Validated principle mappings"
  - design_paradigms: "Identified design philosophies"
  - team_capabilities: "Current team skill levels"
```

### Filesystem MCP
```yaml
server: filesystem-mcp
purpose: "Local file access for images, CAD, measurements"

access_patterns:
  - image_analysis: "Read photos for documentation"
  - cad_access: "Process CAD files if available"
  - measurement_data: "Import measurement spreadsheets"
  - report_generation: "Write output documents"
```

### Obsidian MCP (Optional)
```yaml
server: obsidian-mcp
purpose: "Engineering knowledge base integration"

use_cases:
  - cross_reference: "Link to related engineering concepts"
  - knowledge_graph: "Build connections between analyses"
  - search_prior_art: "Find related previous work"
```

---

## Workflow Example

### Example: 12.7mm RCWS Reverse Engineering

**1. User Input**:
```
"Reverse engineer captured 12.7mm Remote Weapon Station. 
Goal: Develop indigenous alternative for naval vessels.
Timeline: 6 months for conceptual design."
```

**2. Orchestrator Response**:
```yaml
project_created:
  id: "RE-RCWS-001"
  system: "12.7mm Remote Weapon Station"
  objective: replicate
  target: "Vietnamese naval vessels"
  
workflow_initiated:
  current_phase: DIAGNOSIS
  assigned_agent: Diagnostician
  next_milestone: "Complete external documentation"
```

**3. Diagnostician Output** (abbreviated):
```yaml
diagnosis_complete:
  documentation_level: external + partial_subsystem
  
  key_findings:
    overall_dimensions: [1200mm, 800mm, 600mm]
    weight: 180kg
    power_requirement: 28VDC, 50A peak
    
  subsystems_identified:
    - sensor_payload: [daylight camera, thermal imager]
    - drive_system: [azimuth, elevation servos]
    - weapon_mount: [12.7mm M2 compatible]
    - fire_control: [embedded computer]
    
  design_paradigm_indicators:
    modularity: HIGH (quick-change sensor pod)
    reliability: MIL-STD-810G environmental
    maintenance: field-replaceable modules
    
  handoff: ready for Modeler
```

**4. Modeler Output** (abbreviated):
```yaml
function_structure:
  overall: "Enable remote engagement of surface/air targets from protected position"
  
  primary_functions:
    F1_acquire: "Sense and process target imagery"
    F2_track: "Calculate and predict target motion"
    F3_point: "Direct weapon to aim point"
    F4_fire: "Execute weapon discharge sequence"
    F5_support: "Provide power, protection, interfaces"
    
working_principles_identified:
  - F3.3_stabilization: "MEMS gyro + brushless servo + PID control"
  - F1.1_thermal_sensing: "Uncooled microbolometer, 640x480"
  - F4.4_firing: "Solenoid-actuated sear release"
  
paradigm_reconstruction:
  stated_goal: "Naval close-in defense"
  actual_goal: "Maximize engagement envelope while minimizing operator exposure"
  key_trade_off: "Stabilization performance vs. cost (chose mid-tier IMU)"
```

**5. Interventionist Output** (abbreviated):
```yaml
replication_assessment:
  feasibility: 75%
  
  critical_path:
    1. stabilization_algorithm: "Can replicate with local expertise"
    2. thermal_sensor: "Must import or license"
    3. servo_drives: "Local manufacturing possible"
    4. fire_control_software: "Indigenous development required"
    
  morphological_alternatives:
    F3.3_stabilization:
      A1: "Same approach (MEMS + BLDC)" - feasible
      A2: "FOG + stepper" - higher cost, better accuracy
      A3: "Optical stabilization" - novel, high risk
      
  vdi_2225_recommendation:
    best_combination: [A1, B2, C1, D1]
    confidence: 80%
    
counter_system_insights:
  vulnerability_1: "GPS/INS sync can be jammed"
  vulnerability_2: "Thermal sensor can be dazzled"
  
technology_insertion:
  candidate_1: "Adopt modular sensor pod architecture for MTB-20"
```

**6. Reflector Output** (abbreviated):
```yaml
lessons_learned:
  - lesson: "Modular sensor architecture enables rapid capability upgrades"
    applicable_to: [MTB-20, future_RCWS, tethered_drone]
    
  - lesson: "Mid-tier IMU sufficient for naval stabilization"
    challenges_assumption: "Previously assumed FOG required"
    
paradigm_insights:
  - "Western design prioritizes operator survivability over system cost"
  - "Modularity serves both logistics and upgrade paths"
  
capability_gaps:
  - gap: "Uncooled thermal imaging manufacturing"
    severity: HIGH
    remediation: "Partnership or import channel"
    
process_improvements:
  - "Add spectrometry to Level 3 analysis equipment"
  - "Create standardized photo documentation checklist"
```

---

## Success Metrics

### Leading Indicators (Within Weeks)
- Documentation completeness: >90% per analysis phase
- Function structure validated: All components mapped
- Working principles identified: >95% of subfunctions

### Lagging Indicators (Within Months)
- Knowledge transfer: Successfully applied to indigenous project
- Replication success: Functional prototype achieved
- Counter-system effectiveness: Demonstrated in testing

### Learning Velocity Indicators
- Time per analysis cycle: Decreasing trend
- Novel principles captured: Growing database
- Cross-project knowledge reuse: Increasing references

---

## Integration with Existing Skills

This agent system integrates with your existing skill portfolio:

| Skill | Integration Point |
|-------|-------------------|
| `pahl-beitz-mastery` | Modeler uses for function structure methodology |
| `meadows-leverage-analyzer` | All agents use for prioritization |
| `feedback-loop-detector` | Modeler uses for control system analysis |
| `stock-flow-mapper` | Diagnostician uses for flow identification |
| `engineering-design-review-mentor` | Interventionist uses for alternative evaluation |
| `engineering-concept-evaluation-assistant` | VDI 2225 evaluation in Interventionist |
| `dmir-defense-systems-mentor` | Overall framework alignment |
| `skills-mastery-system` | Reflector uses for capability development |

---

## Quick Start

1. **Initialize Project**: User provides system identification and objective
2. **Orchestrator Routes**: Automatically enters DIAGNOSIS phase
3. **Diagnostician Executes**: Creates comprehensive documentation
4. **Modeler Reconstructs**: Builds function structure and working principles
5. **Interventionist Extracts**: Generates application recommendations
6. **Reflector Captures**: Documents lessons and improves process

**First Project Recommendation**: Apply to a known system (e.g., commercial drone) to validate workflow before tackling classified foreign equipment.

---

## Files Structure

```
/reverse-engineering-agent-system/
├── SKILL.md                          # This file
├── agents/
│   ├── orchestrator.md               # Orchestrator agent specification
│   ├── diagnostician.md              # Diagnostician agent specification
│   ├── modeler.md                    # Modeler agent specification
│   ├── interventionist.md            # Interventionist agent specification
│   └── reflector.md                  # Reflector agent specification
├── schemas/
│   ├── input-schema.yaml             # Standard input formats
│   ├── output-schema.yaml            # Standard output formats
│   └── handoff-schema.yaml           # Inter-agent communication
├── templates/
│   ├── diagnosis-template.md         # Documentation template
│   ├── function-structure.yaml       # Function structure template
│   ├── working-principles.yaml       # Working principle catalog
│   └── vdi-2225-evaluation.xlsx      # Concept evaluation template
├── references/
│   ├── physical-effects-catalog.md   # Pahl & Beitz effects
│   ├── design-paradigms.md           # Known design philosophies
│   └── mil-spec-reference.md         # Military specification guide
└── examples/
    ├── rcws-analysis/                # Worked example
    └── target-uav-analysis/          # Worked example
```
