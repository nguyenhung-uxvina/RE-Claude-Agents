# Worked Examples

This directory contains worked examples demonstrating the Reverse Engineering Agent System in practice.

---

## Available Examples

### 1. RCWS Analysis (`rcws-analysis/`)

**System:** 12.7mm Remote Control Weapon Station
**Objective:** Indigenous replication for naval vessels
**Complexity:** High
**Classification:** Example (sanitized)

Demonstrates:
- Full D-M-I-R cycle
- Military system analysis
- Replication pathway development
- Counter-system identification
- Complete documentation set

**Best for learning:** Overall system workflow, military hardware analysis

---

### 2. Target UAV Analysis (`target-uav-analysis/`)

**System:** Commercial Quadcopter
**Objective:** Technology insertion for tethered drone
**Complexity:** Medium
**Classification:** Unclassified (commercial system)

Demonstrates:
- Commercial system teardown
- Technology insertion strategy
- Adaptation requirements
- Civilian-to-military transfer

**Best for learning:** Technology insertion, commercial analysis, pilot project approach

---

## How to Use These Examples

### For Training

1. **Read each example in D-M-I-R order:**
   - Diagnosis report first
   - Function structure second
   - Intervention report third
   - Reflection report last

2. **Compare against templates:**
   - Note what sections are populated
   - Observe level of detail
   - Study justification patterns

3. **Practice with similar system:**
   - Find analogous commercial item
   - Apply same methodology
   - Compare your outputs to examples

### For Reference During Projects

1. **Stuck on documentation?**
   - Review diagnosis report structure
   - Copy relevant section formats
   - Adapt detail level to your system

2. **Function structure unclear?**
   - Study example decomposition
   - Review Mermaid diagram syntax
   - Match complexity level

3. **Recommendations not flowing?**
   - Review intervention report format
   - Study how trade-offs are presented
   - Examine VDI 2225 application

### For Process Improvement

1. **Review reflection reports:**
   - What lessons were captured?
   - What process improvements identified?
   - How were they implemented?

2. **Compare across examples:**
   - What's common?
   - What's different?
   - What could be standardized?

---

## Creating New Examples

When completing a project, consider contributing it as an example:

### Sanitization Checklist

- [ ] Remove actual part numbers (use XX-XXX format)
- [ ] Remove specific performance values
- [ ] Remove supplier names
- [ ] Remove classification markings
- [ ] Generalize country references
- [ ] Remove personnel names
- [ ] Remove dates if sensitive

### Documentation Checklist

- [ ] README with overview
- [ ] Diagnosis report (or summary)
- [ ] Function structure
- [ ] Function diagram (Mermaid)
- [ ] Working principles (key ones)
- [ ] Intervention summary
- [ ] Lessons learned

### Quality Checklist

- [ ] Demonstrates methodology correctly
- [ ] Shows realistic complexity
- [ ] Includes actual insights
- [ ] Teaches something new
- [ ] Reusable for training

---

## Example Index by Learning Objective

| Learning Objective | Recommended Example |
|-------------------|---------------------|
| First-time user orientation | target-uav-analysis |
| Military system methodology | rcws-analysis |
| Function structure creation | rcws-analysis |
| Technology insertion | target-uav-analysis |
| Complete D-M-I-R cycle | rcws-analysis |
| Pilot project planning | target-uav-analysis |
| Replication assessment | rcws-analysis |
| Lessons learned capture | Both |
