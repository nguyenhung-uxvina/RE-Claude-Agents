# Diagnosis Report Template

## Project Information

| Field | Value |
|-------|-------|
| **Project ID** | RE-XXX-001 |
| **System Designation** | [Foreign system name] |
| **Origin Country** | [Country] |
| **Documentation Date** | YYYY-MM-DD |
| **Analyst** | [Name] |
| **Classification** | [UNCLASSIFIED/RESTRICTED/SECRET] |
| **Documentation Level** | [External/Subsystem/Component] |

---

## 1. Executive Summary

### 1.1 Overall Assessment
[2-3 sentence summary of the system and key findings]

### 1.2 Documentation Completeness

| Level | Completeness | Notes |
|-------|--------------|-------|
| External | __% | |
| Subsystem | __% | |
| Component | __% | |
| **Overall** | **__%** | |

### 1.3 Key Intelligence Value
- [ ] Part numbers decoded: [count]
- [ ] MIL-SPECs identified: [count]
- [ ] Design standards inferred: [count]

---

## 2. External Observation (Level 1)

### 2.1 Dimensional Data

| Parameter | Value | Notes |
|-----------|-------|-------|
| Length | ___ mm | |
| Width | ___ mm | |
| Height | ___ mm | |
| Weight | ___ kg | |
| Center of Gravity | [x, y, z] | If determinable |

### 2.2 Mounting Interfaces

| Interface ID | Type | Dimensions | Notes |
|--------------|------|------------|-------|
| MI-001 | | | |
| MI-002 | | | |

### 2.3 Electrical Connectors

| Connector ID | Type | Pin Count | Voltage | Location | Image Ref |
|--------------|------|-----------|---------|----------|-----------|
| EC-001 | | | | | |
| EC-002 | | | | | |

### 2.4 Hydraulic/Pneumatic Ports

| Port ID | Type | Size | Pressure Rating | Location |
|---------|------|------|-----------------|----------|
| HP-001 | | | | |

### 2.5 Data Interfaces

| Interface ID | Protocol | Connector Type | Notes |
|--------------|----------|----------------|-------|
| DI-001 | | | |

### 2.6 Markings and Labels

#### 2.6.1 Manufacturer Labels
| Text | Location | Image Ref | Interpretation |
|------|----------|-----------|----------------|
| | | | |

#### 2.6.2 Part Numbers (CRITICAL)
| Part Number | Type | Decoded To | Supplier Chain |
|-------------|------|------------|----------------|
| | manufacturer/military/nato | | |

#### 2.6.3 Serial Numbers
| Number | Location | Interpretation |
|--------|----------|----------------|
| | | |

#### 2.6.4 MIL-SPEC Markings
| Specification | Requirement | Implications |
|---------------|-------------|--------------|
| | | |

#### 2.6.5 Safety Warnings
| Text | Language | Implications |
|------|----------|--------------|
| | | |

### 2.7 Materials Identification

| Component | Material | Confidence | Method | Surface Treatment |
|-----------|----------|------------|--------|-------------------|
| | | __% | Visual/Spectrometry | |

### 2.8 Corrosion Evidence

| Location | Type | Severity | Implications |
|----------|------|----------|--------------|
| | | None/Minor/Moderate/Severe | |

---

## 3. Subsystem Decomposition (Level 2)

### 3.1 Assembly Hierarchy

```
[SYSTEM NAME]
├── [Top-Level Assembly 1]
│   ├── [Subassembly 1.1]
│   └── [Subassembly 1.2]
├── [Top-Level Assembly 2]
│   ├── [Subassembly 2.1]
│   └── [Subassembly 2.2]
└── [Top-Level Assembly 3]
```

### 3.2 Top-Level Assemblies

| Assembly ID | Name | Function (Inferred) | Component Count |
|-------------|------|---------------------|-----------------|
| TLA-001 | | | |
| TLA-002 | | | |

### 3.3 Fastener Types

| Type | Size | Material | Torque Marking | Quantity | Security |
|------|------|----------|----------------|----------|----------|
| | | | | | Standard/Tamper-Resistant |

### 3.4 Cable Harness Routing

[Insert diagram or reference to diagram file]

| Harness ID | From | To | Conductor Count | Shielded |
|------------|------|-----|-----------------|----------|
| CH-001 | | | | Yes/No |

### 3.5 Mechanical Connections

| Connection ID | Type | Components | DOF |
|---------------|------|------------|-----|
| MC-001 | | [A] ↔ [B] | |

### 3.6 Seal Types

| Location | Type | Material | Purpose |
|----------|------|----------|---------|
| | O-ring/Gasket/Labyrinth/Face | | |

### 3.7 Lubrication Points

| Location | Lubricant Type | Interval Marking |
|----------|----------------|------------------|
| | | |

### 3.8 Manufacturing Signatures

#### 3.8.1 Casting Marks
| Component | Mark | Foundry Identified |
|-----------|------|--------------------|
| | | |

#### 3.8.2 Machining Patterns
| Component | Process | Quality Indicators |
|-----------|---------|-------------------|
| | Turned/Milled/Ground/EDM/Additive | |

#### 3.8.3 Assembly Sequence Evidence
| Observation | Sequence Inferred |
|-------------|-------------------|
| | |

---

## 4. Component Analysis (Level 3)

### 4.1 Component Catalog Summary

| Category | Count |
|----------|-------|
| Total Components | |
| Identified (COTS) | |
| Custom | |
| Modified COTS | |
| Unknown | |

### 4.2 Component Details

#### Component: [Component ID]

| Field | Value |
|-------|-------|
| **Part Number** | |
| **Commercial Equivalent** | |
| **Type** | Custom/COTS/Modified COTS |
| **Manufacturer** | |
| **Country of Origin** | |

**Material Analysis:**
| Property | Value | Method |
|----------|-------|--------|
| Material | | Visual/Spectrometry |
| Hardness | | |
| Magnetic Response | Yes/No | |

**Manufacturing Signatures:**
- Process: [Casting/Forging/Machining/etc.]
- Tolerance Class: [Commercial/Precision/Ultra-precision]
- Quality Indicators: [List]

**Wear Analysis:**
| Location | Pattern | Operating Condition Inferred | Hours Est. |
|----------|---------|------------------------------|------------|
| | | | |

**Functional Role:**
- Function Hypothesis: [Statement]
- Confidence: ___%
- Evidence: [List]

[Repeat for each significant component]

---

## 5. Design Paradigm Indicators

### 5.1 Safety Margins

| Indicator | Observation | Inferred Factor |
|-----------|-------------|-----------------|
| Structural sizing | | |
| Material selection | | |
| Redundancy level | | |

**Risk Tolerance:** [ ] Conservative  [ ] Balanced  [ ] Aggressive

**Reliability Philosophy:** [Description]

### 5.2 Modularity Assessment

| Indicator | Observation |
|-----------|-------------|
| Module boundaries | |
| Interface standardization | Proprietary/Industry/Military |
| Maintenance philosophy | Field-replaceable/Depot/Factory |
| Upgrade provisions | |

**Modularity Level:** [ ] Low  [ ] Medium  [ ] High

### 5.3 Material Selection Philosophy

| Factor | Assessment |
|--------|------------|
| Cost vs Performance | Cost-optimized/Balanced/Performance-optimized |
| Weight Sensitivity | Low/Medium/High/Critical |
| Environmental Requirements | |

### 5.4 Manufacturing Approach

| Indicator | Observation | Volume Inferred |
|-----------|-------------|-----------------|
| Casting vs Machining | | Prototype/Low/Medium/High |
| Automation evidence | | Manual/Semi/Full |
| QC evidence | | |

### 5.5 Redundancy Analysis

| System | Redundancy Type | Mission Criticality |
|--------|-----------------|---------------------|
| | Hot/Warm/Cold/None | Convenience/Mission/Safety/Survival |

---

## 6. Gaps Detected

### 6.1 Missing Documentation

| Item | Importance | Resolution Path |
|------|------------|-----------------|
| | Critical/High/Medium/Low | |

### 6.2 Access Required

| Access Type | Purpose | Blocking? |
|-------------|---------|-----------|
| | | Yes/No |

### 6.3 Equipment Needed

| Equipment | Purpose | Available? |
|-----------|---------|------------|
| | | Yes/No |

---

## 7. Intelligence Value Summary

### 7.1 Part Numbers Decoded

| Part Number | Decoded To | Supplier | Supply Chain Notes |
|-------------|------------|----------|-------------------|
| | | | |

### 7.2 MIL-SPECs Identified

| Specification | Requirement | Design Implications |
|---------------|-------------|---------------------|
| | | |

### 7.3 Design Standards Inferred

| Standard | Evidence | Confidence |
|----------|----------|------------|
| | | __% |

---

## 8. Handoff Assessment

### 8.1 Readiness for Modeling

| Criterion | Status | Notes |
|-----------|--------|-------|
| Documentation ≥ 80% | [ ] Yes [ ] No | |
| Critical subsystems documented | [ ] Yes [ ] No | |
| Component catalog populated | [ ] Yes [ ] No | |
| Pattern analysis complete | [ ] Yes [ ] No | |
| Gaps documented | [ ] Yes [ ] No | |

**Ready for Handoff:** [ ] Yes  [ ] No

### 8.2 Blockers

| Blocker | Resolution Required |
|---------|---------------------|
| | |

### 8.3 Priority Focus Areas for Modeler

1. [Area 1]
2. [Area 2]
3. [Area 3]

---

## 9. Appendices

### Appendix A: Photo Documentation Index
| Photo ID | Subject | Location | Notes |
|----------|---------|----------|-------|
| | | | |

### Appendix B: Measurement Data
[Reference to measurement files]

### Appendix C: Spectrometry Results
[Reference to analysis files]

---

## Document Control

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0 | | | Initial documentation |
