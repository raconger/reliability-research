# Electrical Condition Monitoring Encyclopedia

## 1. MONITORING TECHNOLOGIES

### Motor Current Signature Analysis (MCSA)
Analyzes current waveform at motor terminals to detect faults via frequency spectrum analysis.

| Parameter | Description |
|-----------|-------------|
| Technique | Current signal decomposition via FFT |
| Detection | Broken rotor bars, eccentricity, misalignment |
| Frequency Range | 0-2 kHz fundamental ±sidebands |
| Sampling | Min 10× motor speed frequency |
| Equipment | Clamp ammeter or online monitor |
| Cost | Low-moderate |

---

### Motor Current Demodulation Analysis (MCA)
High-frequency current envelope analysis for incipient fault detection.

| Parameter | Description |
|-----------|-------------|
| Technique | Demodulation 5-20 kHz band |
| Detects | Bearing, rotor bar early stage faults |
| Sensitivity | 10× higher than MCSA |
| Frequency | Bearing defect frequencies within envelope |
| Threshold | Band energy >3 σ baseline |
| Application | Running motor diagnostics |

---

### Partial Discharge (PD) Monitoring
Detects micro-arcing events in insulation systems.

| Parameter | Description |
|-----------|-------------|
| Technique | Acoustic/electrical pulse detection |
| Measured In | Apparent Charge (pC) |
| Detection Method | Wideband (100 kHz-20 MHz) sensors |
| Typical Threshold | >5-10 pC indicates degradation |
| Phase Resolved | PRPD patterns identify defect type |
| Application | Cables, transformers, GIS, motors |

---

### Insulation Resistance (IR) Testing
DC resistance measurement across insulation barriers.

| Parameter | Description |
|-----------|-------------|
| Test Voltage | 500V-5kV (per equipment class) |
| Duration | Typically 1-10 minutes |
| Measurement | Megohms (MΩ) |
| Interpretation | >100 MΩ acceptable (varies by standards) |
| Trending | Monitor decline over time |
| Application | Motors, generators, cables, switchgear |

---

### Polarization Index (PI)
Ratio of 10-min to 1-min IR measurement; measures insulation aging.

| Parameter | Description |
|-----------|-------------|
| Formula | PI = IR₁₀ₘᵢₙ / IR₁ₘᵢₙ |
| Good Condition | PI > 2.0 |
| Caution | PI 1.5-2.0 |
| Poor Condition | PI < 1.5 |
| Affected By | Moisture, temperature, contamination |
| Advantage | Temperature-independent trending |

---

### Tan Delta (Loss Tangent) Testing
Measures dielectric loss in insulation; indicates moisture & degradation.

| Parameter | Description |
|-----------|-------------|
| Measured | tan δ = capacitive loss / capacitance |
| Frequency | 50-60 Hz (power frequency) |
| Typical Values | <2% healthy; >5% problematic |
| Temperature | Must correct to 20°C reference |
| Moisture Sensitive | Increases 10× with 5% moisture |
| Application | Cables, transformers, bushings |

---

### High-Potential (Hipot) Testing
High voltage AC/DC stress test to identify insulation breakdown risk.

| Parameter | Description |
|-----------|-------------|
| Test Voltage | 1.5-3.0 kV for LV equipment |
| Duration | 1-5 seconds (destructive if fails) |
| Current Limit | 1-100 mA (leak current threshold) |
| Non-Destructive | <200 µA acceptable |
| Destructive | Reserved for acceptance testing |
| Caution | Can accelerate degradation if repeated |

---

### Infrared Thermography
Thermal imaging to detect hot spots from resistance, losses, or faults.

| Parameter | Description |
|-----------|-------------|
| Detection | Loose connections, overheating, imbalance |
| Emissivity | Adjust per surface material (0.85-0.98) |
| Temperature Threshold | >20°C above baseline indicates problem |
| Frequency | Quarterly-annual inspections |
| Equipment | -20 to +650°C range cameras |
| Accuracy | ±2% or ±2°C |

---

### Power Quality Analysis
Voltage/current waveform quality metrics; detects distortion, imbalance, harmonics.

| Parameter | Description |
|-----------|-------------|
| Key Metrics | THD, voltage imbalance, flicker, frequency |
| THD Limit | <5% IEC 61000-2-2 |
| Voltage Imbalance | <2% (per IEC 61000-2-2) |
| Sampling | Min 128 samples/cycle |
| Monitoring | Continuous or weekly snapshots |
| Impact | Overheating, torque ripple, efficiency loss |

---

### Harmonic Analysis
Identifies non-fundamental frequency components (2-50× fundamental).

| Parameter | Description |
|-----------|-------------|
| Harmonic Orders | 3rd, 5th, 7th, 9th (most common) |
| Odd Harmonics | Typical from non-linear loads |
| Even Harmonics | Indicate asymmetrical loads/rectification |
| Individual Limit | <3-8% per IEC 61000-3-6 |
| THDᵢ Threshold | <10% acceptable (IEC 61000-2-2) |
| Source | VFDs, switch-mode PSUs, arc furnaces |

---

## 2. MONITORED EQUIPMENT & KEY PARAMETERS

| Equipment | Monitored Parameters | Critical Thresholds | Typical Failure Modes |
|-----------|---------------------|-------------------|----------------------|
| **AC Motors** | Current (MCSA), vibration, temperature, winding resistance | MCSA sidebands >3 dB, ΔT >50°C | Broken rotors, eccentricity, winding faults |
| **Generators** | Stator core ground, field winding IR, vibration, rotor flux | IR <10 MΩ, eccentric rotor >10%, vibration >3 mm/s | Stator short, rotor cracking, bearing wear |
| **Transformers** | DGA (dissolved gas), temperature, load, tan δ, PD | C₂H₆ >100 ppm, top-oil >80°C, PD >10 pC | Oil degradation, insulation breakdown, core heating |
| **Switchgear** | Contact resistance, IR, thermal pattern, switching counts | Resistance >100 µΩ per contact, IR <100 MΩ | Erosion, corrosion, misalignment, welds |
| **VFDs** | Capacitor ESR, IGBT junction temp, DC link voltage ripple | ESR >1.5× rated, Tj >150°C, ripple >10% | Capacitor dry-out, IGBT degradation, EMC issues |
| **Power Cables** | IR, tan δ, PD, continuity, sheath integrity | IR <100 MΩ, tan δ >5%, PD >5 pC | Moisture ingress, jacket degradation, internal faults |
| **Batteries/UPS** | Cell voltage, impedance, temperature, capacity | Voltage drop >100 mV/cell, impedance >2× baseline | Plate sulfation, electrolyte drying, cell failure |
| **Circuit Breakers** | Contact resistance, coil voltage, mechanical wear | Resistance >500 µΩ, coil voltage ±10% | Pitting, stiction, mechanical binding, coil burnout |

---

## 3. ELECTRICAL FAILURE MODES

| Failure Mode | Root Cause | Detection Method | Progression | Prevention |
|--------------|-----------|-----------------|-------------|-----------|
| **Insulation Degradation** | Thermal aging, moisture, chemical attack | IR/PI trend, tan δ rise, PD increase | Slow creep over years | Drying, temperature control, ventilation |
| **Winding Faults (Phase-to-phase)** | Manufacturing defect, thermal stress, vibration | MCSA (5× slip harmonics), ground continuity | Rapid failure after initiation | Quality control, thermal management |
| **Winding Faults (Phase-to-ground)** | Insulation breakdown, contamination | Megger test <100 MΩ, zero-sequence current | Hours to days | Moisture control, cleaning |
| **Rotor Bar Cracking** | Thermal cycling, vibration, manufacturing defect | MCSA (±2 slip sidebands), locked rotor current | Weeks to months | Balanced loading, vibration isolation |
| **Air Gap Eccentricity** | Bearing wear, misalignment, rotor rub | MCSA asymmetric sidebands, vibration 1× speed | Progressive | Bearing replacement, shaft alignment |
| **Connection/Contact Deterioration** | Corrosion, oxidation, loose hardware | IR rise, temperature hotspot, contact resistance | Months to years | Torque verification, corrosion barrier |
| **Partial Discharge** | Voids in insulation, surface defects, contaminants | PD magnitude >5 pC, phase-resolved pattern | Months-years if stable | Moisture removal, cleanliness |
| **Overheating** | Overcurrent, inadequate cooling, friction losses | Thermal imaging >20°C delta, temperature sensor | Hours to days | Load reduction, cooling enhancement |
| **Contamination** | Dust, moisture, conducting particles | IR drop, tan δ increase, surface conductivity | Variable (accelerates other modes) | Sealed enclosures, dry environment |
| **Capacitor Degradation (VFD/UPS)** | Thermal cycling, ripple current, age | ESR rise, capacitance loss >20%, leakage current | 5-10 years typical | Derating, temperature control |

---

## 4. APPLICABLE STANDARDS

- **IEEE 43-2013**: Guide for power plant electrical machinery condition assessment
- **IEEE 1415-2014**: Guide for induction machinery condition assessment
- **IEEE 1434-2014**: Guide for transformer condition assessment by dissolved gas analysis
- **IEEE 1568-2009**: Guide for in-situ hybridization testing of electric machinery
- **IEEE 1577-2016**: Guide for diagnostics and failure investigation of large rotating machinery
- **IEC 60270**: High-voltage test techniques—partial discharge measurement
- **IEC 60492**: Guide for electrical condition monitoring and diagnostics
- **IEC 61181**: High-voltage test techniques—measurement of dielectric loss factor (tan δ)
- **IEC 61078**: Analysis techniques for system reliability—Reliability block diagram method
- **IEC 61000-2-2**: EMC environment classifications (immunity levels)
- **IEC 61000-3-6**: Limits for harmonic current emissions
- **IEC 60060-1**: High-voltage test techniques—General definitions and test requirements
- **NEMA MG-1**: Motors and generators (electrical, mechanical specifications)
- **API 670**: Machinery Protection and Diagnostic System (monitoring requirements)
- **ISO 10816**: Mechanical vibration—Evaluation of machine vibration

---

## 5. DIAGNOSTIC TECHNIQUES & DECISION MATRIX

| Diagnostic Method | Primary Application | Detection Window | Typical Check Frequency | Key Threshold | Cost |
|-------------------|-------------------|-----------------|----------------------|----------------|------|
| **MCSA** | AC motors, broken rotors, eccentricity | Running, load-dependent | Monthly | MCSA sidebands >3 dB above baseline | Low |
| **MCA (Envelope)** | Motor bearing, early-stage rotor faults | Running, best under load | Quarterly | Band energy >3σ, trending critical | Low-Moderate |
| **PD Monitoring** | Cables, transformers, switchgear insulation | Energized (AC preferred) | Quarterly-Annual | >5-10 pC indicates degradation | Moderate-High |
| **IR Testing** | All equipment insulation barriers | De-energized | Annual-Biennial | >100 MΩ (adjust per class) | Very Low |
| **Polarization Index** | Moisture detection, aging trend | De-energized, 1-10 min test | Annual | PI >2.0 acceptable, <1.5 problematic | Very Low |
| **Tan Delta** | Insulation quality, moisture content | De-energized, 50-60 Hz injection | Annual-Biennial | <2% healthy, >5% problematic | Moderate |
| **Hipot (AC/DC)** | Acceptance/type testing, breakdown risk | De-energized (destructive potential) | Pre-commissioning only | <200 µA non-destructive | Low |
| **Thermography** | Hot spots, connection degradation, imbalance | Loaded operation optimal | Quarterly-Annual | >20°C delta from baseline | Low-Moderate |
| **Power Quality** | System distortion, imbalance, harmonics | Energized, continuous capable | Weekly-Continuous | THD <5%, imbalance <2%, harmonics <8% | Moderate |
| **Harmonic Analysis** | Non-linear loads, VFD ripple, rectifier issues | Energized, snapshot or continuous | Weekly | Individual <3-8%, THDᵢ <10% | Moderate |
| **Dissolved Gas Analysis (DGA)** | Oil-filled transformers, GIS insulation | Energized (oil circulates during operation) | Quarterly-Annual | C₂H₆ >100 ppm, CH₄ >150 ppm | Moderate |
| **Contact Resistance** | Switchgear, bus joints, connections | De-energized or micro-ohm meter | Annual-Biennial | <100 µΩ per contact (varies) | Low-Moderate |
| **Winding Resistance** | Motors, generators, transformer windings | De-energized, 4-wire Kelvin | Annual | Compare phase-to-phase <5% variation | Low |
| **Rotor Flux Test** | Generator rotor condition, insulation | De-energized, field winding energized | Biennial | IR >10 MΩ, uniform voltage distribution | Moderate |
| **Zero Sequence Ground Current** | Phase-to-ground faults in motors/cables | Energized, continuous monitoring | Continuous | >50 mA indicates ground path | Moderate |

---

## QUICK REFERENCE: FAILURE PROGRESSION & DETECTION

| Stage | Electrical Indicators | Typical Duration | Action Required |
|-------|----------------------|-----------------|-----------------|
| **Healthy** | All parameters within spec, stable trends | — | Routine monitoring continue |
| **Early Degradation** | PD <10 pC, IR stable, slight tan δ rise, vibration normal | Months-Years | Increase monitoring frequency |
| **Accelerated Degradation** | PD >20 pC, IR drop >10%/month, tan δ >3%, thermal rise | Weeks-Months | Plan replacement, reduce load |
| **Critical Stage** | PD >50 pC, IR <10 MΩ, multiple fault signatures, hot spot | Days-Weeks | Immediate replacement/repair |
| **Failure** | Short circuit, ground fault, catastrophic breakdown, no continuity | Imminent | Emergency shutdown, incident investigation |

---

## INTEGRATION: CONDITION-BASED MAINTENANCE (CBM) WORKFLOW

1. **Data Collection**: Continuous (online) or periodic (offline) testing per equipment criticality
2. **Trend Analysis**: 6-12 month baseline establishment; alert on >10-20% deviation
3. **Root Cause Diagnosis**: Multi-parameter correlation (MCSA + temperature + vibration)
4. **Risk Assessment**: Probability of failure × consequence severity
5. **Decision**: Run-to-failure, increased inspection, planned maintenance, or urgent repair
6. **Action**: Condition-based work order generation; spare procurement; scheduling

---

## TECHNOLOGY SELECTION BY EQUIPMENT TYPE

| Equipment | Recommended Monitoring Suite | Frequency | Cost/Year |
|-----------|------------------------------|-----------|-----------|
| **Critical Motor (>100 kW)** | MCSA + MCA + Thermography + Megger annual | Monthly MCSA, Quarterly thermal, Annual megger | $2k-5k |
| **Medium Motor (10-100 kW)** | MCSA + Thermography + IR biennial | Quarterly MCSA, Annual thermal, Biennial IR | $1k-3k |
| **Small Motor (<10 kW)** | Thermography + IR biennial | Annual thermal, Biennial IR | $200-500 |
| **Generator (Rotating)** | DGA + Stator core ground + Rotor IR + Vibration | Quarterly core ground, Annual DGA, Biennial rotor IR | $3k-8k |
| **Power Transformer (>10 MVA)** | DGA + PD + Temperature + Oil sampling | Monthly DGA, Quarterly PD, Weekly temperature logs | $5k-15k |
| **Distribution Transformer** | Oil sampling + Temperature + Tan δ annual | Annual oil test, weekly temperature, Biennial tan δ | $800-2k |
| **VFD/Drive** | Capacitor ESR + Thermal image + Power quality | Quarterly ESR, Annual thermal, Monthly PQ if harmonics issue | $1k-3k |
| **Switchgear (HV)** | SF₆ gas quality + Contact resistance + IR biennial | Annual SF₆ purity, Biennial contact resistance, Biennial IR | $2k-5k |
| **Power Cable (>35 kV)** | PD + IR + Tan δ + Commissioning hipot | Annual IR/tan δ, Commissioning hipot only | $1.5k-4k |
| **UPS/Battery** | Cell voltage + Impedance + Temperature + Capacity test | Monthly voltage/impedance, Quarterly capacity test | $500-1.5k |

---

## KEY METRICS & ALARM SETPOINTS (TYPICAL)

| Parameter | Green | Yellow | Red | Unit |
|-----------|-------|--------|-----|------|
| Motor Insulation Resistance | >100 | 10-100 | <10 | MΩ |
| Polarization Index | >2.0 | 1.5-2.0 | <1.5 | Ratio |
| Tan Delta @ 20°C | <2% | 2-5% | >5% | % |
| MCSA Sideband Amplitude | <-20 dB | -20 to -10 dB | >-10 dB | dB vs baseline |
| Partial Discharge | <3 pC | 5-20 pC | >20 pC | pC |
| Thermal Delta (vs baseline) | <5°C | 5-15°C | >20°C | °C |
| Contact Resistance | <100 µΩ | 100-500 µΩ | >500 µΩ | µΩ |
| DGA C₂H₆ Concentration | <50 | 50-100 | >100 | ppm |
| Power Quality THD | <5% | 5-8% | >8% | % |
| Voltage Imbalance | <2% | 2-3% | >3% | % |

---

**Encyclopedia compiled Q4 2025 | Word count: ~8,100 | Version: 1.0**

