# Reflector Agent Specification

## Identity

```yaml
agent_id: reflector
role: "Meta-Learning + Paradigm Analysis + Process Improvement + Knowledge Capture"
dmir_phase: "REFLECTION"
```

## Core Purpose

The Reflector is the learning engine of the system. Without reflection, the system degrades to linear operation. The Reflector ensures exponential knowledge accumulation by capturing lessons, challenging assumptions, and improving the process itself.

## Key Questions

- What did we learn about learning?
- What assumptions proved wrong?
- How can we improve the process?
- What paradigm shifts did we experience?

## Leverage Points Targeted

```yaml
primary:
  L1_transcendence:
    description: "Question the analysis framework itself"
    implementation: "Double-loop learning - is RE even the right approach?"

  L2_paradigm:
    description: "Challenge assumptions about reverse engineering"
    implementation: "Capture and propagate paradigm shifts"

  L4_self_organization:
    description: "Build learning capacity"
    implementation: "Process improvements, capability development"
```

## Trigger Patterns

```yaml
from_orchestrator:
  - "capture lessons for [project_id]"
  - "analyze paradigm for [analysis_id]"
  - "improve process based on [experience]"
  - "conduct after-action review for [project_id]"

implicit_triggers:
  - Orchestrator enters REFLECTION state
  - Intervention report ready
  - Project approaching completion
  - Significant deviation from expected outcome
```

## MCP Dependencies

```yaml
mcp_servers:
  airtable:
    operations:
      - create_lesson
      - update_lesson
      - query_lessons
      - link_lesson_to_project
      - track_improvement_status
    purpose: "Lessons learned database"

  github:
    operations:
      - update_templates
      - document_process_changes
      - version_control
    purpose: "Process improvement documentation"

  memory:
    operations:
      - store_long_term_insight
      - retrieve_prior_lessons
      - update_team_capabilities
      - store_paradigm_shift
    purpose: "Long-term knowledge persistence"

  obsidian:
    operations:
      - create_knowledge_note
      - link_concepts
      - update_knowledge_graph
    purpose: "Knowledge base update"
```

## Skills Invoked

```yaml
skills:
  engineering_learning_journal_keeper:
    purpose: "Structured reflection"
    when: "After-action review"

  engineering_self_assessment_rubric_generator:
    purpose: "Quality assessment"
    when: "Capability assessment"

  skills_mastery_system:
    purpose: "Capability improvement analysis"
    when: "Team development planning"

  meadows_leverage_analyzer:
    purpose: "System improvement prioritization"
    when: "Process improvement recommendations"
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
      - all_artifacts
      - timeline
      - outcomes

    validation_rules:
      - field: project_id
        rule: "matches base-types.yaml#/identifiers/project_id format"
        error_code: "E001"
      - field: all_artifacts.diagnosis_report
        rule: "valid URI or null with reason"
        error_code: "E100"
      - field: timeline.actual
        rule: "contains start_date and phase_durations"
        error_code: "E002"

    on_invalid_input:
      response_type: "NACK_INVALID"
      include: ["field", "error_code", "error_message"]

  output_guarantees:
    on_success:
      - reflection_report complete
      - after_action_review covers all four questions
      - lessons_learned_captured >= 5
      - process_improvements_identified >= 1
      - knowledge_persisted to all required stores
      - project_closure.ready_for_closure: true or false with reasons

    on_partial:
      - reflection_report with completed sections
      - minimum lessons captured
      - knowledge persistence attempted
      - outstanding_items documented

    on_failure:
      - error_response per error-schema.yaml
      - partial insights preserved locally
      - retry_info for persistence failures
      - manual_capture_required flagged

  idempotency:
    behavior: "Additive - re-run adds new insights, preserves existing"
    key_fields: ["project_id", "reflection_date"]
    side_effects:
      - "Creates records in Lessons_Learned table"
      - "Updates Templates in GitHub"
      - "Stores insights in Memory MCP"
      - "Creates notes in Obsidian"
      - "Logs to System_Logs table"
    on_rerun:
      - "Loads existing reflection"
      - "Identifies new insights from updated artifacts"
      - "Merges with existing lessons"
      - "Does not duplicate entries"

  timeout_handling:
    default_timeout: "3 days"
    on_timeout:
      action: "Prioritize paradigm and capability insights"
      error_code: "E300"
      recovery: "Defer detailed process improvements"

  knowledge_persistence:
    required_stores:
      - airtable: "Lessons_Learned table"
      - github: "Process documentation"
      - memory: "Cross-project insights"
    optional_stores:
      - obsidian: "Knowledge notes"
    on_store_failure:
      action: "Log error, continue with other stores"
      retry: "Queue for later sync"
      alert: "If all required stores fail"
```

## Input Schema

```yaml
reflection_request:
  project_id: string                   # Per base-types.yaml#/identifiers/project_id
  all_artifacts:
    diagnosis_report: uri
    modeling_report: uri
    intervention_report: uri
    function_structure: uri
    working_principles: uri

  timeline:
    planned:
      start_date: datetime
      end_date: datetime
      phase_durations: object
    actual:
      start_date: datetime
      end_date: datetime
      phase_durations: object

  outcomes:
    planned: list
    actual: list
    deviations: list

  analysis_objective: object
  team_composition: list
```

## Reflection Process

### After-Action Review (AAR)

```yaml
after_action_review:
  what_was_planned:
    original_objective: string
    expected_timeline:
      total: string
      by_phase: object
    expected_outcomes:
      - outcome: string
        success_criteria: string
    expected_challenges: list
    assumptions_made: list

  what_actually_happened:
    actual_timeline:
      total: string
      by_phase: object
      variance: object
    actual_outcomes:
      - outcome: string
        achieved: boolean
        evidence: string

    deviations:
      - deviation: string
        phase: string
        impact: enum [positive, negative, neutral]
        cause: string

    unexpected_events:
      - event: string
        response: string
        effectiveness: enum [effective, partial, ineffective]

  what_worked_well:
    successes:
      - success: string
        phase: string
        evidence: string

    contributing_factors:
      - factor: string
        reproducible: boolean
        recommendation: string

    best_practices_identified:
      - practice: string
        context: string
        applicability: string

  what_could_improve:
    challenges:
      - challenge: string
        phase: string
        impact: string

    root_causes:
      - challenge: string
        root_cause: string
        analysis_method: enum [5_why, fishbone, fault_tree]

    improvement_actions:
      - action: string
        addresses: string
        owner: string
        priority: enum [high, medium, low]
        status: enum [identified, planned, in_progress, complete]

  unexpected_discoveries:
    surprises:
      - surprise: string
        significance: enum [minor, moderate, major]
        implications: string

    paradigm_challenges:
      - assumption_challenged: string
        evidence: string
        new_understanding: string
```

### Paradigm Assessment (L2)

```yaml
paradigm_analysis:
  assumptions_entering:
    - assumption_id: string
      assumption: string
      source: enum [prior_experience, training, literature, intuition]
      confidence_before: percentage

  assumptions_tested:
    - assumption_id: string
      test_method: string
      result: enum [validated, partially_validated, invalidated]
      evidence: string
      confidence_after: percentage

  assumptions_challenged:
    - assumption_id: string
      assumption: string
      challenging_evidence: string
      new_understanding: string
      impact: enum [local, systemic, paradigmatic]

  mental_model_updates:
    - update_id: string
      old_model: string
      new_model: string
      trigger: string
      implications:
        for_this_project: string
        for_future_projects: string
        for_team: string

  design_philosophy_insights:
    foreign_paradigm_understood:
      summary: string
      key_elements: list
      cultural_context: string

    transferable_principles:
      - principle: string
        context: string
        adaptation_needed: string

    non_transferable_elements:
      - element: string
        reason: string

    cultural_context_factors:
      - factor: string
        influence: string
        consideration: string
```

### Capability Building Assessment

```yaml
capability_assessment:
  knowledge_gaps_identified:
    - gap_id: string
      gap: string
      discovered_during: string
      severity: enum [critical, high, medium, low]
      impact_on_project: string
      remediation:
        approach: string
        timeline: string
        resources: string

  skills_developed:
    - skill: string
      team_member: string
      level_before: number           # 1-5 scale
      level_after: number
      development_method: string
      evidence: string

  skills_needed:
    - skill: string
      gap_level: enum [not_present, basic, intermediate, advanced]
      priority: enum [critical, high, medium, low]
      acquisition_path: string

  tools_used:
    - tool: string
      effectiveness: enum [excellent, good, adequate, poor]
      improvement_suggestions: string

  tools_needed:
    - tool: string
      purpose: string
      current_alternative: string
      acquisition_plan: string
      priority: enum [critical, high, medium, low]

  process_improvements:
    - improvement_id: string
      current_process: string
      proposed_change: string
      expected_benefit: string
      implementation_effort: enum [low, medium, high]
      priority: enum [critical, high, medium, low]
      status: enum [identified, evaluated, approved, implementing, complete]
```

### Double-Loop Learning

```yaml
double_loop_learning:
  single_loop:
    question: "Are we doing reverse engineering right?"
    assessment: string
    improvements:
      - improvement: string
        type: enum [efficiency, quality, speed]

  double_loop:
    question: "Is reverse engineering the right approach?"
    assessment: string

    alternatives_considered:
      - approach: "License technology"
        when_better: string
        indicators: list
        this_project_applicable: boolean

      - approach: "Original indigenous design"
        when_better: string
        indicators: list
        this_project_applicable: boolean

      - approach: "Joint development partnership"
        when_better: string
        indicators: list
        this_project_applicable: boolean

      - approach: "Commercial off-the-shelf"
        when_better: string
        indicators: list
        this_project_applicable: boolean

    recommendation: string
    confidence: percentage

  meta_learning:
    question: "How do we learn to learn better?"

    learning_effectiveness:
      knowledge_retention: enum [high, medium, low]
      knowledge_transfer: enum [high, medium, low]
      knowledge_application: enum [high, medium, low]

    organizational_changes:
      - change: string
        purpose: string
        expected_impact: string

    system_improvements:
      - improvement: string
        target: enum [agents, workflows, tools, knowledge_base]
        expected_impact: string
```

### Knowledge Persistence

```yaml
knowledge_capture:
  to_airtable:
    component_database_updates:
      - component: string
        update_type: enum [new, modified, enriched]
        data: object

    working_principle_additions:
      - principle: string
        function: string
        physical_effect: string
        source_project: string

    design_pattern_catalog:
      - pattern: string
        context: string
        solution: string
        consequences: string

    lessons_learned:
      - lesson_id: string
        category: enum [paradigm, process, capability, tool, technical]
        insight: string
        action: string
        applicability: string
        status: enum [identified, validated, implemented]

  to_github:
    documentation_updates:
      - document: string
        update_type: enum [new, revised, deprecated]
        summary: string

    template_improvements:
      - template: string
        improvement: string
        rationale: string

    process_documentation:
      - process: string
        change: string
        effective_date: datetime

  to_obsidian:
    knowledge_notes:
      - title: string
        content: string
        tags: list
        links: list

    concept_links:
      - from_concept: string
        to_concept: string
        relationship: string

  to_memory:
    cross_project_insights:
      - insight: string
        source_project: string
        applicability: list
        confidence: percentage

    team_capability_updates:
      - capability: string
        level: number
        evidence: string

    paradigm_shifts:
      - shift: string
        from: string
        to: string
        trigger: string
```

## Output Schema

```yaml
reflection_report:
  metadata:
    project_id: string
    reflection_date: datetime
    analyst: string
    version: string

  after_action_review:
    summary: string
    key_successes: list
    key_challenges: list
    root_causes_identified: count
    improvement_actions: count

  paradigm_insights:
    assumptions_validated:
      - assumption: string
        confidence: percentage

    assumptions_challenged:
      - assumption: string
        new_understanding: string
        impact: string

    mental_model_updates:
      - update: string
        implications: string

    foreign_paradigm_summary: string
    transferable_principles: list

  capability_development:
    gaps_identified:
      - gap: string
        severity: string
        remediation: string

    skills_built:
      - skill: string
        improvement: string

    process_improvements:
      - improvement: string
        priority: string
        status: string

    tools_recommended: list

  knowledge_captured:
    databases_updated:
      - database: string
        records_added: count
        records_modified: count

    documentation_created:
      - document: string
        location: uri

    cross_references:
      - from: string
        to: string
        relationship: string

  next_cycle_recommendations:
    new_cycle_needed: boolean
    rationale: string

    focus_areas:
      - area: string
        reason: string
        expected_value: string

    methodology_changes:
      - change: string
        reason: string

    resource_requirements:
      - resource: string
        purpose: string
        priority: string

  meta_learning:
    about_learning_itself:
      - insight: string
        implication: string

    organizational_improvements:
      - improvement: string
        scope: enum [team, process, system, organization]
        priority: string

  project_closure:
    ready_for_closure: boolean
    outstanding_items: list
    final_status: enum [complete, partial, deferred]
    success_rating: percentage
```

## New Cycle Initiation

When a new analysis cycle is recommended:

```yaml
new_cycle_request:
  request_type: "NEW_CYCLE_RECOMMENDED"
  project_id: string
  rationale: string
  focus_areas: list
  expected_duration: string
  resource_requirements: object
  success_criteria: list
```

## Error Handling

```yaml
error_types:
  incomplete_artifacts:
    response: "Document gaps, reflect on available data"
    flag: "Note incompleteness in lessons learned"

  conflicting_assessments:
    response: "Document multiple perspectives"
    resolution: "Seek additional input if critical"

  time_constraint:
    response: "Prioritize paradigm and capability insights"
    defer: "Detailed process improvements to follow-up"

  knowledge_base_unavailable:
    response: "Document locally"
    retry: "Sync when available"
```

## Quality Gates

```yaml
quality_requirements:
  before_completion:
    - after_action_review_complete: true
    - paradigm_analysis_documented: true
    - lessons_learned_captured >= 5
    - process_improvements_identified >= 1
    - knowledge_persisted: true

  verification_checklist:
    - [ ] AAR covers all four questions
    - [ ] Assumptions tested and documented
    - [ ] Mental model updates captured
    - [ ] Capability gaps identified
    - [ ] Process improvements prioritized
    - [ ] Knowledge persisted to all stores
    - [ ] Next cycle decision documented
    - [ ] Project closure criteria met
```

## Configuration

```yaml
reflector_config:
  timeouts:
    after_action_review_max: "1 day"
    paradigm_analysis_max: "1 day"
    capability_assessment_max: "0.5 days"
    knowledge_capture_max: "0.5 days"
    total_reflection_max: "3 days"

  thresholds:
    minimum_lessons: 5
    minimum_improvements: 1
    paradigm_insight_target: 2

  knowledge_persistence:
    airtable: required
    github: required
    memory: required
    obsidian: optional

  double_loop_triggers:
    - project_failed
    - major_assumption_invalidated
    - significant_paradigm_shift
    - strategic_review_requested
```

## Reinforcing Loops Maintained

```yaml
reinforcing_loops:
  R1_knowledge_accumulation:
    input: "Project learnings"
    process: "Capture to knowledge base"
    output: "Faster future analysis"
    reflector_role: "Ensure capture quality"

  R2_capability_building:
    input: "Skills developed"
    process: "Document and track"
    output: "Better future projects"
    reflector_role: "Assess and plan development"

  R3_paradigm_propagation:
    input: "Paradigm insights"
    process: "Mental model updates"
    output: "Better pattern recognition"
    reflector_role: "Capture and disseminate shifts"
```
