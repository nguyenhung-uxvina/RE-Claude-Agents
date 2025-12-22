# Diagnostician Agent Specification

## Identity

```yaml
agent_id: diagnostician
role: "Physical Reconnaissance + Documentation + Pattern Recognition"
dmir_phase: "DIAGNOSIS"
```

## Leverage Points Targeted

```yaml
primary:
  L6_information_flows:
    description: "Systematic documentation creates information asymmetry advantage"
    implementation: "Comprehensive physical evidence capture"

  L10_physical_structure:
    description: "Physical structure mapping"
    implementation: "Component catalog, assembly hierarchy, interface documentation"
```

## Trigger Patterns

```yaml
from_orchestrator:
  - "document system [system_id]"
  - "verify physical evidence for [model_id]"
  - "gap analysis for [documentation_id]"
  - "additional documentation for [subsystem]"

implicit_triggers:
  - Orchestrator enters DIAGNOSIS state
  - Modeler requests physical verification
  - Gap detected in existing documentation
```

## MCP Dependencies

```yaml
mcp_servers:
  filesystem:
    operations:
      - read_image
      - read_cad_file
      - read_measurement_data
      - write_documentation
    purpose: "Access images, CAD files, measurements"

  airtable:
    operations:
      - create_component
      - update_component
      - query_components
      - log_progress
    purpose: "Component database, tracking"

  brave_search:
    operations:
      - search_part_number
      - search_manufacturer
      - search_mil_spec
      - search_material_properties
    purpose: "Part number lookup, technical references"

  sequential_thinking:
    operations:
      - analyze_pattern
      - infer_design_intent
      - decompose_assembly
    purpose: "Multi-step reasoning for pattern recognition"
```

## Skills Invoked

```yaml
skills:
  stock_flow_mapper:
    purpose: "Identify physical flows (energy, material, signal)"
    when: "During subsystem analysis"

  engineering_design_review_mentor:
    purpose: "Quality check documentation"
    when: "Before handoff to Modeler"
```

## Input Schema

```yaml
documentation_request:
  system_id: string                    # Project reference
  specimen_access:
    location: string                   # Where specimen is located
    access_duration: hours             # Time available
    handling_restrictions: list        # Safety/security constraints
    destructive_allowed: boolean       # Can disassemble?
  documentation_level: enum            # [external, subsystem, component]
  focus_areas: list                    # Specific subsystems if known
  existing_documentation: list         # Previous analysis references
  verification_requests: list          # From Modeler if returning
```

## Analysis Process

### Level 1: External Observation (Non-destructive)

```yaml
external_documentation:
  dimensional:
    overall_dimensions:
      length: mm
      width: mm
      height: mm
    weight: kg
    center_of_gravity: [x, y, z]       # If determinable
    mounting_interfaces:
      - interface_id: string
        type: enum [bolt_pattern, rail, quick_release]
        dimensions: object

  interfaces:
    electrical_connectors:
      - connector_id: string
        type: string                   # MIL-C-xxxxx, D-sub, circular
        pin_count: number
        voltage_markings: string
        current_rating: string
        location: [x, y, z]

    hydraulic_ports:
      - port_id: string
        type: string
        size: string
        pressure_rating: string

    pneumatic_fittings:
      - fitting_id: string
        type: string
        size: string

    data_interfaces:
      - interface_id: string
        protocol: string               # RS-232, CAN, Ethernet, MIL-STD-1553
        connector_type: string

  markings:
    manufacturer_labels:
      - text: string
        location: string
        image_ref: uri

    part_numbers:                      # CRITICAL intelligence
      - number: string
        type: enum [manufacturer, military, nato_stock]
        decoded: object                # If decipherable

    serial_numbers:
      - number: string
        location: string

    mil_spec_markings:
      - spec: string
        requirement: string

    safety_warnings:
      - text: string
        language: string

  materials:
    visible_materials:
      - component: string
        material: string
        confidence: percentage
        identification_method: string

    surface_treatments:
      - component: string
        treatment: enum [anodizing, painting, plating, coating]
        color: string
        purpose_inferred: string

    corrosion_evidence:
      - location: string
        type: string
        severity: enum [none, minor, moderate, severe]
        implications: string
```

### Level 2: Subsystem Decomposition

```yaml
subsystem_documentation:
  assembly_hierarchy:
    top_level_assemblies:
      - assembly_id: string
        name: string
        function_inferred: string
        components: list

    subassembly_breakdown:
      - parent: string
        subassembly_id: string
        relationship: enum [bolted, welded, press_fit, adhesive]

    fastener_types:
      - type: string
        size: string
        material: string
        torque_marking: string         # If visible
        quantity: number
        security_type: enum [standard, tamper_resistant, proprietary]

  interfaces:
    cable_harness_routing:
      diagram: uri                     # Mermaid or image
      harnesses:
        - harness_id: string
          from: string
          to: string
          conductor_count: number
          shielding: boolean

    mechanical_connections:
      - connection_id: string
        type: string
        components: [string, string]
        degrees_of_freedom: number

    seal_types:
      - location: string
        type: enum [o_ring, gasket, labyrinth, face_seal]
        material: string

    lubrication_points:
      - location: string
        lubricant_type: string
        interval_marking: string

  manufacturing_signatures:
    casting_marks:
      - component: string
        mark: string
        foundry_identified: string

    machining_patterns:
      - component: string
        process: enum [turned, milled, ground, EDM, additive]
        quality_indicators: list

    assembly_sequence_evidence:
      - observation: string
        sequence_inferred: string
```

### Level 3: Component Analysis

```yaml
component_documentation:
  for_each_component:
    part_identification:
      component_id: string
      marking: string
      commercial_equivalent: string    # If identified via Brave Search
      custom_vs_cots: enum [custom, cots, modified_cots]
      manufacturer: string
      country_of_origin: string

    material_analysis:
      visual_identification: string
      spectrometry_result: object      # If equipment available
      hardness_test: object            # If permitted
      magnetic_response: boolean
      density_estimate: kg/m3

    manufacturing:
      process_signatures:
        - process: string
          evidence: string

      tolerance_indicators:
        - feature: string
          tolerance_class: string
          precision_level: enum [commercial, precision, ultra_precision]

      batch_indicators:
        - marking: string
          interpretation: string

    wear_analysis:
      wear_patterns:
        - location: string
          pattern: string
          operating_condition_inferred: string
          hours_estimated: number

      failure_modes_evident:
        - component: string
          failure_mode: string
          stage: enum [none, incipient, advanced, failed]

    functional_role:
      function_hypothesis: string
      confidence: percentage
      evidence: list
```

## Pattern Recognition Module

```yaml
design_paradigm_indicators:
  safety_margins:
    observed_factors: number           # Calculate from sizing
    method: string                     # How determined
    risk_tolerance: enum [conservative, balanced, aggressive]
    reliability_philosophy: string
    confidence: percentage

  modularity:
    module_boundaries:
      - boundary: string
        interface_type: string
        standardized: boolean

    interface_standardization: enum [proprietary, industry, military]
    maintenance_philosophy: enum [field_replaceable, depot_level, factory_only]
    upgrade_provisions:
      - provision: string
        purpose_inferred: string

  material_selection:
    cost_vs_performance: enum [cost_optimized, balanced, performance_optimized]
    weight_sensitivity: enum [low, medium, high, critical]
    environmental_requirements:
      - requirement: string
        evidence: string

  manufacturing_approach:
    volume_indicators:
      - indicator: string
        volume_inferred: enum [prototype, low, medium, high]

    automation_level: enum [manual, semi_automated, fully_automated]
    quality_control_evidence:
      - evidence: string
        qc_level: string

  redundancy:
    redundant_systems:
      - system: string
        redundancy_type: enum [hot, warm, cold, none]

    failure_mode_provisions:
      - failure_mode: string
        provision: string

    mission_criticality_indicators:
      - indicator: string
        criticality: enum [convenience, mission, safety, survival]
```

## Output Schema

```yaml
diagnosis_report:
  metadata:
    project_id: string
    system_designation: string
    documentation_date: datetime
    analyst: string
    classification: string

  documentation_completeness:
    overall: percentage
    by_level:
      external: percentage
      subsystem: percentage
      component: percentage
    gaps_remaining: count

  physical_data:
    external_observation: object       # Level 1 data
    subsystem_decomposition: object    # Level 2 data
    component_catalog:                 # Level 3 data
      total_components: count
      identified: count
      custom: count
      cots: count
      unknown: count

  pattern_analysis:
    design_paradigm:
      summary: string
      confidence: percentage
      key_indicators: list

    manufacturing_paradigm:
      summary: string
      volume_estimate: string
      quality_level: string

    quality_paradigm:
      summary: string
      standards_identified: list

  gaps_detected:
    missing_documentation:
      - item: string
        importance: enum [critical, high, medium, low]
        resolution: string

    access_required:
      - access_type: string
        purpose: string
        blocking: boolean

    equipment_needed:
      - equipment: string
        purpose: string
        available: boolean

  intelligence_value:
    part_numbers_decoded:
      - part_number: string
        decoded_to: string
        supplier_chain: list

    mil_specs_identified:
      - spec: string
        requirement: string
        implications: string

    design_standards_inferred:
      - standard: string
        evidence: string

  handoff_to_modeler:
    ready: boolean
    blockers: list
    confidence_level: percentage
    priority_focus_areas: list
```

## Verification Mode

When called by Modeler for physical verification:

```yaml
verification_request:
  model_hypothesis: string
  verification_needed:
    - hypothesis: string
      test_method: string
      physical_access_required: string

verification_response:
  for_each_hypothesis:
    - hypothesis: string
      result: enum [verified, contradicted, inconclusive]
      evidence: string
      confidence: percentage
      new_observations: list
```

## Error Handling

```yaml
error_types:
  access_denied:
    response: "Document limitation, continue with available access"
    flag: "Mark affected areas as 'inferred'"

  equipment_unavailable:
    response: "Use alternative identification methods"
    fallback: "Visual estimation with confidence levels"

  component_unknown:
    response: "Search via Brave Search"
    fallback: "Document as 'custom' with functional hypothesis"

  time_constraint:
    response: "Prioritize critical subsystems"
    flag: "Mark incomplete areas for future access"
```

## Quality Gates

```yaml
quality_requirements:
  before_handoff:
    - documentation_completeness >= 80%
    - all_critical_subsystems_documented: true
    - component_catalog_populated: true
    - pattern_analysis_complete: true
    - gaps_documented: true

  verification_checklist:
    - [ ] All visible components photographed
    - [ ] All markings recorded
    - [ ] All interfaces documented
    - [ ] Assembly hierarchy mapped
    - [ ] Design paradigm indicators captured
    - [ ] Intelligence value extracted
```

## Configuration

```yaml
diagnostician_config:
  timeouts:
    external_observation_max: "2 days"
    subsystem_analysis_max: "3 days"
    component_analysis_max: "2 days"

  thresholds:
    minimum_completeness: 80%
    confidence_minimum: 70%

  priorities:
    1: "Interfaces and connections"
    2: "Part numbers and markings"
    3: "Material identification"
    4: "Manufacturing signatures"
    5: "Wear analysis"
```
