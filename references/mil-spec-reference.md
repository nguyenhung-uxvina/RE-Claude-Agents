# Military Specification Reference Guide

A quick reference for common military specifications encountered during reverse engineering of foreign and domestic military systems.

---

## 1. US Military Standards (MIL-STD)

### 1.1 Environmental Standards

| Specification | Title | Key Requirements |
|---------------|-------|------------------|
| **MIL-STD-810** | Environmental Engineering Considerations | Temperature, humidity, vibration, shock, altitude, sand/dust |
| **MIL-STD-461** | EMI/EMC Requirements | Electromagnetic interference limits |
| **MIL-STD-464** | Electromagnetic Environmental Effects | System-level EME requirements |
| **MIL-STD-1275** | DC Power Characteristics | 28V DC power quality |
| **MIL-STD-704** | Aircraft Electric Power | Aircraft power quality |

### 1.2 Design Standards

| Specification | Title | Key Requirements |
|---------------|-------|------------------|
| **MIL-STD-1472** | Human Engineering | Ergonomics, displays, controls |
| **MIL-STD-882** | System Safety | Hazard analysis, risk assessment |
| **MIL-STD-785** | Reliability Program | Reliability requirements |
| **MIL-STD-470** | Maintainability | Maintainability requirements |
| **MIL-STD-1388** | LSA | Logistics Support Analysis |

### 1.3 Interface Standards

| Specification | Title | Key Requirements |
|---------------|-------|------------------|
| **MIL-STD-1553** | Digital Data Bus | Aircraft data bus protocol |
| **MIL-STD-1760** | Stores Interface | Weapon/stores electrical interface |
| **MIL-STD-188** | Communications | Tactical communications |
| **MIL-STD-498** | Software Development | Software documentation |

---

## 2. US Military Specifications (MIL-SPEC)

### 2.1 Connector Specifications

| Specification | Connector Type | Typical Use |
|---------------|----------------|-------------|
| **MIL-DTL-5015** | Circular, threaded | General purpose, power |
| **MIL-DTL-26482** | Circular, bayonet | Quick-disconnect, signal |
| **MIL-DTL-38999** | Circular, high-density | Harsh environment, high-density |
| **MIL-DTL-83723** | Circular, miniature | Space-constrained applications |
| **MIL-DTL-24308** | D-subminiature | Data, signal |
| **MIL-DTL-55302** | PCB connectors | Board-to-board |

### 2.2 Cable/Wire Specifications

| Specification | Description | Typical Use |
|---------------|-------------|-------------|
| **MIL-DTL-16878** | Hook-up wire | Internal wiring |
| **MIL-DTL-27500** | Shielded cable | Signal cables |
| **MIL-W-22759** | Aircraft wire | Aerospace wiring |
| **MIL-DTL-17** | RF coaxial cable | RF transmission |

### 2.3 Material Specifications

| Specification | Material | Notes |
|---------------|----------|-------|
| **MIL-A-8625** | Anodizing | Aluminum surface treatment |
| **MIL-DTL-5541** | Chromate conversion | Aluminum corrosion protection |
| **MIL-PRF-46010** | Phosphate coating | Steel corrosion protection |
| **MIL-PRF-23377** | Primer | Epoxy primer |
| **QQ-A-250** | Aluminum sheet | Aluminum alloys |
| **AMS-QQ-A-200** | Aluminum bar/rod | Aluminum stock |

### 2.4 Fastener Specifications

| Specification | Fastener Type | Notes |
|---------------|---------------|-------|
| **MS20995** | Safety wire | Lockwire |
| **NAS1352** | Socket head cap screw | High-strength |
| **AN3-AN20** | Bolts | General purpose |
| **AN960** | Washers | Flat washers |
| **AN310** | Castle nuts | Cotter pin retention |
| **MS21042** | Self-locking nuts | Prevailing torque |

---

## 3. Russian/Soviet Standards (GOST)

### 3.1 Common GOST Standards

| GOST Number | Title/Area | Equivalent |
|-------------|------------|------------|
| **GOST 9.301** | Metallic coatings | Similar to MIL plating specs |
| **GOST 9.303** | Oxide coatings | Similar to MIL-A-8625 |
| **GOST 21.101** | Technical documentation | Drawing standards |
| **GOST 2.109** | Technical drawings | General requirements |
| **GOST 1050** | Carbon steel | Material spec |
| **GOST 4543** | Alloy steel | Material spec |

### 3.2 Connector Identification

Russian connectors often marked:
- **2РМ** series - Circular connectors
- **СНЦ** series - Threaded circular
- **РП** series - Rectangular connectors
- **ГРПМ** series - Miniature rectangular

---

## 4. NATO Standards (STANAG)

### 4.1 Key STANAGs

| STANAG | Title | Purpose |
|--------|-------|---------|
| **STANAG 2895** | Extreme climate conditions | Environmental categories |
| **STANAG 4370** | AECTP testing | Environmental testing |
| **STANAG 4187** | Fuzing systems | Ammunition fuzing |
| **STANAG 4107** | Mutual acceptance | Equipment acceptance |
| **STANAG 2389** | Marking of equipment | Standard markings |
| **STANAG 1059** | National ID letters | Country codes |

### 4.2 NATO Stock Numbers (NSN)

**Format:** XXXX-YY-ZZZ-WWWW
- XXXX = NATO Supply Class
- YY = Country code (00=US, 99=UK, 12=Germany, etc.)
- ZZZ-WWWW = Item identifier

**Common Supply Classes:**
| Class | Category |
|-------|----------|
| 1005 | Guns, 30mm and under |
| 1010 | Guns, over 30mm to 75mm |
| 1015 | Guns, over 75mm |
| 1240 | Optical sighting equipment |
| 1270 | Aircraft gunnery equipment |
| 5820 | Radio equipment |
| 5840 | Radar equipment |
| 5895 | Countermeasure equipment |
| 5999 | Electronics, misc |

---

## 5. IP (Ingress Protection) Ratings

### 5.1 IP Rating Decode

**Format:** IP XY
- X = Solid particle protection (0-6)
- Y = Liquid ingress protection (0-9K)

| First Digit | Solid Protection |
|-------------|------------------|
| 0 | No protection |
| 1 | >50mm objects |
| 2 | >12.5mm objects |
| 3 | >2.5mm objects |
| 4 | >1mm objects |
| 5 | Dust protected |
| 6 | Dust tight |

| Second Digit | Liquid Protection |
|--------------|-------------------|
| 0 | No protection |
| 1 | Vertical dripping |
| 2 | Dripping (15° tilted) |
| 3 | Spraying water |
| 4 | Splashing water |
| 5 | Water jets |
| 6 | Powerful water jets |
| 7 | Temporary immersion |
| 8 | Continuous immersion |
| 9K | High-pressure steam |

**Common Military Ratings:**
- IP65 - Dust tight, water jets
- IP67 - Dust tight, immersion to 1m
- IP68 - Dust tight, continuous immersion

---

## 6. MIL-STD-810 Environmental Categories

### 6.1 Temperature Categories

| Category | Low Temp | High Temp | Application |
|----------|----------|-----------|-------------|
| Basic Hot | - | 33°C | Controlled environment |
| Hot | - | 43°C | Worldwide hot |
| Basic Cold | -21°C | - | Controlled environment |
| Cold | -37°C | - | Cold climate |
| Severe Cold | -46°C | - | Arctic |
| Extreme Cold | -57°C | - | Extreme arctic |

### 6.2 Climatic Categories

| Category | Description |
|----------|-------------|
| A1 | Hot dry |
| A2 | Hot humid |
| A3 | Hot coastal desert |
| B1 | Intermediate |
| B2 | Mid-latitude |
| B3 | Cold |
| C1 | Cold polar |
| C2 | Extreme cold |

---

## 7. Common Part Number Decoding

### 7.1 MS (Military Standard) Numbers

Format varies by item type:
- **MS20XXX** - Fasteners
- **MS27XXX** - Electrical
- **MS33XXX** - Seals/O-rings
- **MS35XXX** - Fasteners

### 7.2 AN (Army-Navy) Numbers

Legacy designation, many still in use:
- **AN3-AN20** - Bolts
- **AN73-AN81** - Drilled head bolts
- **AN100-AN102** - Thimbles
- **AN310** - Castle nuts
- **AN315** - Plain nuts
- **AN960** - Washers

### 7.3 NAS (National Aerospace Standard) Numbers

- **NAS1XXX** - Fasteners
- **NAS4XXX** - Structural
- **NAS6XXX** - Hose/fittings

---

## 8. Quick Identification Tables

### 8.1 Connector Quick ID

| If You See | Likely Specification |
|------------|---------------------|
| Threaded coupling, 3-4 pins | MIL-DTL-5015 |
| Bayonet coupling, small | MIL-DTL-26482 |
| Bayonet, triple-start thread | MIL-DTL-38999 |
| D-shaped, small pins | MIL-DTL-24308 |
| Circular, filtered | MIL-DTL-38999 filtered variant |

### 8.2 Material Quick ID

| If You See | Likely Material/Spec |
|------------|---------------------|
| Black oxide on steel | MIL-DTL-13924 |
| Gray on aluminum | Anodize MIL-A-8625 Type II |
| Gold/clear on aluminum | Chromate MIL-DTL-5541 |
| Green primer | MIL-PRF-23377 |
| Zinc plating on steel | MIL-DTL-12298 |

### 8.3 Marking Quick ID

| Marking Pattern | Meaning |
|-----------------|---------|
| Part Number + Cage Code | US military item |
| NSN Format | NATO tracked item |
| Cyrillic + GOST | Russian/Soviet origin |
| CE Mark | European compliance |
| Chinese characters + numbers | Chinese origin |

---

## 9. Reference Resources

### 9.1 Online Resources

- **ASSIST QuickSearch**: https://quicksearch.dla.mil
- **CAGE Code Lookup**: https://cage.dla.mil
- **NSN Lookup**: https://www.iso-group.com/NSN/

### 9.2 Key Documents

- MIL-HDBK-5: Metallic Materials and Elements for Aerospace
- MIL-HDBK-17: Composite Materials
- MIL-HDBK-454: General Guidelines for Electronic Equipment
- NAVAIR 01-1A-8: Structural Hardware

---

## 10. Using This Reference

### During Documentation (Diagnostician)
1. Record all visible markings exactly as shown
2. Cross-reference with tables above
3. Search ASSIST/CAGE for US items
4. Note specification for material/process identification

### During Modeling (Modeler)
1. Use specifications to understand design requirements
2. Identify performance envelopes from environmental specs
3. Understand interface requirements from connector specs

### During Intervention (Interventionist)
1. Identify equivalent indigenous specifications
2. Determine if COTS alternatives meet requirements
3. Plan for specification compliance in replication
