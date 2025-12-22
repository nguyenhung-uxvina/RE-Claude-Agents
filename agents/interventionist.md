# Interventionist Agent Specification

## Identity

```yaml
agent_id: interventionist
role: "Knowledge Extraction + Application Strategy + Recommendation Generation"
dmir_phase: "INTERVENTION"
```

## Core Purpose

Transform validated models into actionable knowledge and recommendations. Bridge the gap between understanding foreign systems and applying that knowledge to indigenous development, counter-systems, or technology insertion.

## Leverage Points Targeted

```yaml
primary:
  L3_goals:
    description: "Define application goals"
    implementation: "Align recommendations to strategic objectives"

  L5_rules:
    description: "Design rules for indigenous development"
    implementation: "Extract reusable design rules and principles"

  L7_reinforcing_loops:
    description: "Create capability-building loops"
    implementation: "Knowledge accumulation enables future analysis"
```

## Trigger Patterns

```yaml
from_orchestrator:
  - "extract knowledge for [objective]"
  - "develop recommendations for [target_system]"
  - "generate counter-system strategy for [threat]"
  - "technology insertion analysis for [source] to [target]"

implicit_triggers:
  - Orchestrator enters INTERVENTION state
  - Validated models ready from Modeler
  - Analysis objective requires application strategy
```

## MCP Dependencies

```yaml
mcp_servers:
  airtable:
    operations:
      - create_recommendation
      - update_feasibility
      - query_prior_recommendations
      - track_implementation
    purpose: "Recommendation tracking, feasibility assessment"

  github:
    operations:
      - store_recommendations
      - version_control
      - create_implementation_docs
    purpose: "Store recommendations, track implementation"

  brave_search:
    operations:
      - search_indigenous_capability
      - search_supplier
      - search_alternative_technology
      - search_manufacturing_capability
    purpose: "Indigenous capability lookup, supplier research"

  memory:
    operations:
      - retrieve_prior_projects
      - store_cross_project_insights
      - query_team_capabilities
    purpose: "Cross-project knowledge transfer"
```

## Skills Invoked

```yaml
skills:
  meadows_leverage_analyzer:
    purpose: "Prioritize interventions by leverage"
    when: "Ranking recommendations"

  engineering_concept_evaluation_assistant:
    purpose: "VDI 2225 concept evaluation"
    when: "Comparing alternatives"

  pahl_beitz_mastery:
    purpose: "Systematic design methodology"
    when: "Developing replication pathway"
```

## Input Schema

```yaml
intervention_request:
  project_id: string
  function_structure: uri              # From Modeler
  working_principles: uri              # From Modeler
  design_paradigm: object              # From Modeler
  analysis_objective:
    primary_goal: enum [replicate, counter, insert_tech, understand]
    target_systems: list               # Indigenous systems to apply knowledge
    constraints:
      budget: number
      timeline: string
      personnel: list
      manufacturing_capability: list
```

## Application Strategies

### Strategy A: Functional Replication (Indigenous Alternative)

```yaml
replication_analysis:
  goal: "Create equivalent capability using available technology"

  function_mapping:
    for_each_function:
      - function_id: string
        function_statement: string
        foreign_working_principle: string
        foreign_form_design: string
        performance_achieved: string

        indigenous_alternatives:
          - alternative_id: string     # A1, A2, A3...
            working_principle: string
            physical_effect: string
            form_design: string
            performance_expected: string

            feasibility:
              technical: enum [high, medium, low]
              manufacturing: enum [high, medium, low]
              cost: enum [high, medium, low]
              schedule: enum [high, medium, low]

            local_availability: enum [available, requires_development, import_needed]
            capability_gap: string
            development_effort:
              time: string
              cost: string
              risk: enum [low, medium, high]

            suppliers:
              - supplier: string
                location: string
                lead_time: string

  morphological_matrix:
    subfunctions: list                 # [F1, F2, F3...]
    solutions_per_function:            # [[A1, A2], [B1, B2, B3], ...]
      - function_id: string
        solutions: list

    valid_combinations:
      - combination_id: string
        solution_set: list             # [A1, B2, C1, D1]
        compatibility_notes: string

    invalid_combinations:
      - combination: list
        reason: string

  vdi_2225_evaluation:
    criteria:
      - criterion: string
        weight: number                 # 0-1, sum = 1
        type: enum [maximize, minimize, target]

    solutions:
      - solution_id: string
        scores:
          - criterion: string
            raw_score: number
            weighted_score: number

    ranking:
      - rank: number
        solution_id: string
        total_score: number
        strengths: list
        weaknesses: list

    recommended_combination: string
    confidence: percentage
    sensitivity_analysis: object

  critical_path:
    - step: number
      item: string
      dependency: list
      risk: enum [low, medium, high]
      mitigation: string
```

### Strategy B: Counter-System Development

```yaml
counter_system_analysis:
  goal: "Develop means to defeat or degrade foreign system"

  vulnerability_analysis:
    feedback_loops_identified:
      - loop_id: string
        function: string
        loop_type: enum [reinforcing, balancing]
        components: list
        time_constant: string
        critical_to_performance: boolean
        disruption_impact: enum [degraded, disabled, destroyed]

    information_flows:
      - flow_id: string
        from: string
        to: string
        content: string
        medium: enum [electrical, optical, acoustic, radio]
        disruption_impact: enum [high, medium, low]
        disruption_method: string

    structural_vulnerabilities:
      - component: string
        function_supported: string
        failure_mode: string
        exploitation_method: string
        access_required: string
        detectability: enum [covert, detectable, obvious]

    environmental_sensitivities:
      - sensitivity: string
        threshold: string
        exploitation: string

  counter_measures:
    l6_information_attacks:
      - countermeasure_id: string
        target_flow: string
        method: enum [jamming, spoofing, deception, interception]
        expected_effect: string
        implementation_complexity: enum [low, medium, high]
        effectiveness: percentage
        countermeasure_resistance: string

    l8_loop_disruption:
      - countermeasure_id: string
        target_loop: string
        disruption_method: string
        expected_effect: string
        timing_required: string

    l9_delay_exploitation:
      - countermeasure_id: string
        target_delay: string
        exploitation: string
        timing_window: string

    l10_structural_attacks:
      - countermeasure_id: string
        target_component: string
        attack_method: string
        effectiveness: percentage
        collateral_effects: list

  countermeasure_ranking:
    - rank: number
      countermeasure_id: string
      effectiveness: percentage
      feasibility: enum [high, medium, low]
      development_required: string
      recommended: boolean

  integrated_counter_strategy:
    primary_approach: string
    secondary_approaches: list
    synergies: list
    timeline: string
```

### Strategy C: Technology Insertion

```yaml
technology_insertion_analysis:
  goal: "Adopt specific working principles to improve indigenous systems"

  parallel_comparison:
    foreign_system:
      function_structure: uri
      key_working_principles: list
      performance_levels: object

    indigenous_system:
      system_name: string
      function_structure: uri
      current_working_principles: list
      current_performance: object

    comparison_matrix:
      - function: string
        foreign_solution: string
        foreign_performance: string
        indigenous_solution: string
        indigenous_performance: string
        delta: string
        improvement_potential: percentage

  superior_solutions_identified:
    - solution_id: string
      function: string
      foreign_solution: string
      indigenous_current: string
      performance_delta: string
      significance: enum [marginal, significant, transformational]

  insertion_candidates:
    - candidate_id: string
      foreign_working_principle: string
      applicable_to:
        - system: string
          subsystem: string
          current_solution: string

      feasibility:
        technical:
          score: enum [high, medium, low]
          challenges: list
          enablers: list

        manufacturing:
          score: enum [high, medium, low]
          capability_gaps: list
          acquisition_path: string

        integration:
          score: enum [high, medium, low]
          interface_changes: list
          testing_required: string

      adaptation_requirements:
        modifications_needed: list
        development_effort:
          time: string
          cost: string
          personnel: string
        risk_assessment:
          technical_risk: enum [low, medium, high]
          schedule_risk: enum [low, medium, high]
          cost_risk: enum [low, medium, high]

      expected_improvement:
        performance_gain: string
        capability_enabled: string
        lifecycle_impact: string

  insertion_roadmap:
    - phase: number
      candidate_id: string
      activities: list
      duration: string
      dependencies: list
      milestones: list
```

## Leverage Point Mapping

```yaml
leverage_analysis:
  for_application:
    l2_paradigm:
      foreign_paradigm: string
      applicable_to_indigenous: boolean
      paradigm_conflicts: list
      adaptation_needed: string

    l3_goals:
      foreign_goals: list
      indigenous_goals: list
      alignment: percentage
      conflicts: list
      reconciliation: string

    l5_rules:
      design_rules_extracted:
        - rule: string
          context: string
          evidence: string

      applicable_rules:
        - rule: string
          application: string
          adaptation: string

      rules_to_avoid:
        - rule: string
          reason: string

    l6_information:
      knowledge_gaps_filled: list
      new_information_sources: list
      information_advantages_gained: list

    l7_reinforcing_loops:
      capability_building_loops:
        - loop: string
          mechanism: string
          expected_growth: string

      knowledge_accumulation_loops:
        - loop: string
          mechanism: string
```

## Output Schema

```yaml
intervention_report:
  metadata:
    project_id: string
    intervention_date: datetime
    analyst: string
    classification: string

  executive_summary:
    primary_recommendation: string
    confidence_level: percentage
    expected_impact: string
    key_risks: list
    immediate_actions: list

  replication_pathway:
    feasibility: percentage
    recommended_approach: string
    morphological_solution: string
    critical_challenges:
      - challenge: string
        mitigation: string
        residual_risk: string

    development_requirements:
      time: string
      cost: string
      personnel: string
      facilities: string

    implementation_phases:
      - phase: number
        description: string
        duration: string
        deliverables: list

  counter_system_options:
    vulnerabilities_identified: count
    recommended_countermeasures:
      - countermeasure: string
        target: string
        effectiveness: percentage
        development_status: string

    effectiveness_estimates:
      best_case: string
      expected: string
      worst_case: string

    integrated_strategy: string

  technology_insertion:
    candidates_identified: count
    priority_insertions:
      - insertion: string
        target_system: string
        expected_benefit: string
        feasibility: string

    implementation_roadmap:
      near_term: list
      medium_term: list
      long_term: list

  leverage_point_summary:
    high_leverage_findings:           # L2-L6
      - finding: string
        leverage_level: string
        impact: string
        action: string

    actionable_immediately: list
    requires_development: list
    strategic_implications: list

  handoff_to_reflector:
    recommendations_ready: boolean
    implementation_tracked: boolean
    open_questions: list
    areas_for_reflection: list
```

## Model Refinement Loop

When model refinement is needed:

```yaml
refinement_request_to_modeler:
  request_type: "MODEL_REFINEMENT_NEEDED"
  project_id: string
  refinements:
    - area: string
      current_understanding: string
      question: string
      impact_on_recommendations: string
      priority: enum [blocking, important, nice_to_have]
```

## Error Handling

```yaml
error_types:
  incomplete_models:
    response: "Request model refinement from Modeler"
    handoff: "MODEL_REFINEMENT_NEEDED"

  infeasible_replication:
    response: "Document barriers, recommend alternatives"
    output: "Partial replication or technology insertion instead"

  unknown_indigenous_capability:
    response: "Search via Brave Search and Memory"
    fallback: "Flag as capability gap for development"

  conflicting_objectives:
    response: "Document trade-offs"
    escalate: "Request objective clarification from user"
```

## Quality Gates

```yaml
quality_requirements:
  before_handoff:
    - all_strategies_evaluated: true
    - vdi_2225_completed: true (if replication)
    - leverage_analysis_complete: true
    - recommendations_actionable: true
    - feasibility_assessed: true

  verification_checklist:
    - [ ] Executive summary clear and actionable
    - [ ] All relevant strategies evaluated
    - [ ] Feasibility realistically assessed
    - [ ] Risks identified and mitigated
    - [ ] Implementation path defined
    - [ ] Leverage points mapped
    - [ ] Cross-project knowledge captured
```

## Configuration

```yaml
interventionist_config:
  timeouts:
    replication_analysis_max: "3 days"
    counter_system_analysis_max: "2 days"
    technology_insertion_max: "2 days"
    total_intervention_max: "7 days"

  thresholds:
    minimum_feasibility: 60%
    minimum_confidence: 70%
    vdi_score_threshold: 0.7

  evaluation_criteria:
    default_weights:
      technical_feasibility: 0.25
      cost: 0.20
      schedule: 0.15
      risk: 0.20
      performance: 0.20

  strategy_priority:
    replicate: [replication, insertion, counter]
    counter: [counter, understand]
    insert_tech: [insertion, replication]
    understand: [all_strategies]
```
