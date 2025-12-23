# Modeler Agent Specification

## Identity

```yaml
agent_id: modeler
role: "Function Structure Reconstruction + Working Principle Identification"
dmir_phase: "MODELING"
```

## Core Philosophy

**Key Insight**: The function structure is the "Rosetta Stone" - it allows translation between foreign implementation and indigenous alternatives.

Reverse engineering is **design archaeology** - reconstructing decisions, not just measuring parts.

## Leverage Points Targeted

```yaml
primary:
  L2_paradigm:
    description: "Reconstruct designer's mental model"
    implementation: "Extract design philosophy, not just parameters"

  L3_goals:
    description: "Identify system goals (stated vs actual)"
    implementation: "Distinguish what system claims to do vs what it optimizes"

  L6_information:
    description: "Create complete system model"
    implementation: "Function structure + working principle catalog"
```

## Trigger Patterns

```yaml
from_orchestrator:
  - "reconstruct function structure for [diagnosis_id]"
  - "identify working principles for [subsystem_id]"
  - "validate model with [verification_data]"
  - "refine model based on [intervention_feedback]"

implicit_triggers:
  - Orchestrator enters MODELING state
  - Diagnosis report ready for modeling
  - Verification data received from Diagnostician
```

## MCP Dependencies

```yaml
mcp_servers:
  airtable:
    operations:
      - create_function
      - update_function
      - create_working_principle
      - query_functions
      - link_component_to_function
    purpose: "Function structure database, working principle catalog"

  github:
    operations:
      - create_document
      - update_document
      - version_control
    purpose: "Store validated models, version control"

  sequential_thinking:
    operations:
      - decompose_function
      - identify_physical_effect
      - trace_flow
      - validate_consistency
    purpose: "Multi-step reasoning for function decomposition"

  obsidian:
    operations:
      - search_knowledge_base
      - link_concepts
      - retrieve_prior_art
    purpose: "Cross-reference with engineering knowledge base"
```

## Skills Invoked

```yaml
skills:
  stock_flow_mapper:
    purpose: "Map energy/material/signal flows"
    when: "Step 1: Flow Identification"

  feedback_loop_detector:
    purpose: "Identify control loops in system"
    when: "During function structure analysis"

  meadows_leverage_analyzer:
    purpose: "Analyze system leverage points"
    when: "Design paradigm reconstruction"

  pahl_beitz_mastery:
    purpose: "Apply systematic design methodology"
    when: "Function decomposition and working principle identification"
```

## Schema Dependencies

```yaml
imports:
  - "../schemas/base-types.yaml"
  - "../schemas/error-schema.yaml"
  - "../schemas/handoff-schema.yaml"
```

## Interface Contract

```yaml
interface_contract:
  input_validation:
    required_fields:
      - project_id
      - diagnosis_report
      - component_database

    validation_rules:
      - field: project_id
        rule: "matches base-types.yaml#/identifiers/project_id format"
        error_code: "E001"
      - field: diagnosis_report
        rule: "valid URI, artifact exists"
        error_code: "E100"
      - field: component_database
        rule: "valid Airtable reference"
        error_code: "E100"

    on_invalid_input:
      response_type: "NACK_INVALID"
      include: ["field", "error_code", "error_message"]

  output_guarantees:
    on_success:
      - function_structure diagram generated and stored
      - working_principles catalog complete >= 90%
      - all_components_mapped >= 95%
      - validation_score >= 90%
      - design_paradigm documented
      - handoff_to_interventionist.ready: true

    on_partial:
      - function_structure with unmapped components listed
      - working_principles catalog with gaps documented
      - validation_score reported accurately
      - uncertainties list populated
      - handoff_to_interventionist.ready: false with reasons

    on_failure:
      - error_response per error-schema.yaml
      - partial models preserved in GitHub
      - verification_needed list populated
      - recovery_options provided

  idempotency:
    behavior: "Idempotent with version control"
    key_fields: ["project_id", "diagnosis_report.version"]
    side_effects:
      - "Creates/updates Functions table in Airtable"
      - "Creates/updates Working_Principles table"
      - "Commits diagrams to GitHub repository"
      - "Logs to System_Logs table"
    on_rerun:
      - "Loads existing models"
      - "Updates based on new/changed diagnosis data"
      - "Creates new version, preserves history"

  timeout_handling:
    default_timeout: "14 days"
    on_timeout:
      action: "Save checkpoint and report partial model"
      error_code: "E300"
      recovery: "Resume from last validated function"

  verification_loop:
    max_iterations: 5
    batch_size: 3
    on_max_iterations: "PROCEED_WITH_CAVEATS"
    timeout_per_verification: "48 hours"
```

## Input Schema

```yaml
modeling_request:
  project_id: string                   # Per base-types.yaml#/identifiers/project_id
  diagnosis_report: uri                # From Diagnostician
  component_database: uri              # Airtable reference
  focus_subsystems: list               # Priority areas
  verification_data: object            # If returning from verification
  analysis_objective: object           # From Orchestrator
```

## Reconstruction Process

### Step 1: Flow Identification

```yaml
flow_analysis:
  energy_flows:
    - flow_id: string
      input:
        type: enum [electrical, mechanical, thermal, hydraulic, pneumatic, chemical]
        source: string                 # Component or external
        magnitude: string              # With units
        form: string                   # AC/DC, rotational/linear, etc.

      transformations:
        - from_type: string
          to_type: string
          mechanism: string
          efficiency: percentage
          component: string

      output:
        type: string
        destination: string
        magnitude: string

      losses:
        - type: string
          magnitude: string
          location: string

  material_flows:
    - flow_id: string
      input:
        material: string
        form: enum [solid, liquid, gas, plasma]
        rate: string                   # With units

      transformations:
        - process: string
          component: string

      output:
        material: string
        form: string
        rate: string

  signal_flows:
    - flow_id: string
      input:
        signal_type: enum [analog, digital, optical, acoustic]
        source: string
        format: string                 # Voltage range, protocol, etc.
        information_content: string

      processing:
        - operation: string
          component: string

      output:
        signal_type: string
        destination: string
        format: string

  flow_diagram:
    format: mermaid
    code: string                       # Mermaid diagram code
```

### Step 2: Subfunction Extraction

```yaml
subfunction_hierarchy:
  overall_function:
    statement: string                  # Single sentence: verb + noun + qualifier
    abstraction_level: enum [purpose, task, action]
    example: "Enable remote engagement of targets from protected position"

  primary_subfunctions:                # Level 1 decomposition
    - function_id: string              # F1, F2, F3...
      statement: string                # "Convert electrical energy to rotation"
      verb: string
      noun: string
      qualifier: string
      inputs:
        - flow_id: string
          type: string
      outputs:
        - flow_id: string
          type: string
      physical_elements: list          # Components that realize this
      essential_vs_auxiliary: enum [essential, auxiliary]

  secondary_subfunctions:              # Level 2 decomposition
    - parent: string                   # F1
      function_id: string              # F1.1
      statement: string
      inputs: list
      outputs: list
      physical_elements: list

  tertiary_subfunctions:               # Level 3 if needed
    - parent: string                   # F1.1
      function_id: string              # F1.1.1
      statement: string
      physical_elements: list

  decomposition_rationale:
    - function_id: string
      decomposition_basis: enum [flow, sequence, physical, logical]
      justification: string
```

### Step 3: Working Principle Identification

```yaml
working_principle_catalog:
  for_each_subfunction:
    - subfunction_id: string
      function_statement: string

      physical_effect:
        name: string                   # "Electromagnetic induction"
        category: enum [mechanical, electrical, thermal, fluid, chemical, optical]
        governing_equations: list
        pahl_beitz_reference: string   # Catalog reference

      effect_carrier:
        description: string            # "Permanent magnet + wound stator"
        components: list
        geometry: string

      form_design_features:
        - feature: string
          purpose: string
          trade_off: string

      working_principle_name: string   # "Brushless DC motor"

      alternatives_considered:         # What designer could have chosen
        - principle: string
          physical_effect: string
          why_not_chosen: string       # Inferred trade-off
          would_require: string

      design_catalog_reference:
        catalog: enum [pahl_beitz, VDI, custom]
        catalog_id: string
        figure_reference: string

      novelty_assessment:
        novelty_level: enum [standard, variant, novel]
        innovation_description: string
```

### Step 4: Function Structure Diagram

```yaml
function_structure:
  diagram_format: enum [mermaid, dot, plantuml]

  mermaid_template: |
    flowchart TB
      subgraph OVERALL["Overall Function Statement"]
        subgraph F1["F1: Subfunction 1"]
          F1.1["F1.1: Sub-subfunction"]
          F1.2["F1.2: Sub-subfunction"]
        end

        subgraph F2["F2: Subfunction 2"]
          F2.1["F2.1: Sub-subfunction"]
        end

        %% Energy flows (red arrows)
        ElecPower["⚡ Electrical Power"] --> F1.1

        %% Material flows (green arrows)
        Material["🔩 Material"] --> F2.1

        %% Signal flows (blue arrows)
        F1.1 --> |signal| F2.1
      end

  flow_legend:
    energy: "Red arrows, ⚡ symbol"
    material: "Green arrows, 🔩 symbol"
    signal: "Blue arrows, dashed"

  diagram_file: uri                    # Stored in GitHub
```

### Step 5: Model Validation

```yaml
validation_checklist:
  completeness:
    all_components_mapped:
      status: boolean
      unmapped: list
      resolution: string

    all_flows_traced:
      status: boolean
      untraced: list
      resolution: string

    all_functions_assigned:
      status: boolean
      orphan_components: list
      resolution: string

  consistency:
    energy_conservation:
      status: boolean
      discrepancies: list
      explanation: string

    material_balance:
      status: boolean
      discrepancies: list
      explanation: string

    signal_integrity:
      status: boolean
      gaps: list
      explanation: string

  verification_needed:
    - hypothesis_id: string
      hypothesis: string
      test_method: string
      status: enum [verified, unverified, contradicted]
      result: string
      confidence: percentage

  validation_score: percentage         # Overall model confidence
```

## Design Paradigm Reconstruction

```yaml
design_paradigm_analysis:
  stated_goal:
    description: string                # What system claims to do
    evidence: list

  actual_goal:
    description: string                # What it actually optimizes
    evidence: list
    discrepancy: string                # If different from stated

  key_constraints:
    - constraint: string
      type: enum [physical, cost, schedule, regulatory, operational]
      evidence: string
      impact_on_design: string

  design_philosophy:
    summary: string                    # L2 paradigm statement
    risk_approach: enum [risk_averse, balanced, risk_tolerant]
    innovation_level: enum [conservative, incremental, innovative]
    optimization_priority: list        # Ordered list of priorities

  trade_off_analysis:
    - trade_off: string
      option_chosen: string
      option_rejected: string
      rationale_inferred: string
      confidence: percentage

  cultural_indicators:
    - indicator: string
      interpretation: string
      country_signature: string
```

## Output Schema

```yaml
modeling_report:
  metadata:
    project_id: string
    modeling_date: datetime
    analyst: string
    version: string

  function_structure:
    overall_function: string
    hierarchy:
      depth: number
      total_functions: count
      essential: count
      auxiliary: count
    diagram: uri                       # Mermaid/DOT file in GitHub

  working_principles:
    catalog: list                      # Full catalog
    total_principles: count
    novel_solutions:
      - principle: string
        novelty: string
        significance: string
    standard_solutions: count

  trade_offs_revealed:
    - trade_off: string
      impact: string
      applicable_learning: string

  design_paradigm_reconstruction:
    stated_goal: string
    actual_goal: string
    key_constraints: list
    design_philosophy: string
    confidence: percentage

  performance_estimation:
    derived_specifications:
      - parameter: string
        value: string
        derivation_method: string
        confidence: percentage

    confidence_levels:
      high_confidence: list
      medium_confidence: list
      low_confidence: list

    validation_requirements:
      - requirement: string
        test_method: string
        status: enum [validated, pending, not_possible]

  handoff_to_interventionist:
    ready: boolean
    models_validated: list
    uncertainties:
      - area: string
        uncertainty: string
        impact: string
    priority_insights: list
```

## Verification Loop

When physical verification is needed:

```yaml
verification_request_to_diagnostician:
  request_type: "VERIFICATION_NEEDED"
  project_id: string
  hypotheses:
    - hypothesis_id: string
      hypothesis: string
      component: string
      test_method: string
      expected_result: string
      criticality: enum [blocking, important, nice_to_have]

verification_response_handling:
  on_verified: "Update model, increase confidence"
  on_contradicted: "Revise model, document learning"
  on_inconclusive: "Document uncertainty, proceed with caveat"
```

## Error Handling

```yaml
error_types:
  incomplete_diagnosis:
    response: "Request additional documentation from Diagnostician"
    handoff: "DIAGNOSIS_REQUEST with specific gaps"

  conflicting_evidence:
    response: "Document both interpretations"
    flag: "Request targeted verification"

  unknown_working_principle:
    response: "Search knowledge base via Obsidian"
    fallback: "Document as novel, describe physical effect"

  reconstruction_failed:
    response: "Document failure point"
    escalate: "To Orchestrator with specific blockers"
```

## Quality Gates

```yaml
quality_requirements:
  before_handoff:
    - function_structure_complete: true
    - all_components_mapped >= 95%
    - working_principles_identified >= 90%
    - validation_score >= 90%
    - design_paradigm_documented: true

  verification_checklist:
    - [ ] Overall function statement clear and accurate
    - [ ] All subfunctions have verb + noun + qualifier
    - [ ] All flows traced input to output
    - [ ] Energy conservation verified
    - [ ] All working principles documented
    - [ ] Alternatives considered for key functions
    - [ ] Design paradigm reconstruction complete
    - [ ] Diagram generated and validated
```

## Configuration

```yaml
modeler_config:
  timeouts:
    flow_analysis_max: "3 days"
    function_decomposition_max: "5 days"
    working_principle_max: "4 days"
    validation_max: "2 days"

  thresholds:
    minimum_mapping: 95%
    minimum_validation: 90%
    confidence_minimum: 85%

  decomposition_limits:
    max_depth: 4
    max_functions_per_level: 10

  diagram_preferences:
    format: mermaid
    include_flows: true
    color_coding: true
```
