> **⚠️ DEPRECATED (2026-08-19)**: This repo's content has been consolidated into `chatapm/rcm-knowledge-base/` (the RAG-backed knowledge source ChatAPM actually queries) as part of a portfolio-wide knowledge base consolidation. Treat this repo as a frozen historical snapshot, not an active source — new reliability/CBM/APM content should go into `chatapm/rcm-knowledge-base/` directly. See `chatapm/rcm-knowledge-base/WORK-QUEUE.md` for what's been migrated so far and what's still pending.

# Reliability and Asset Management Encyclopedia

> **Expert-level research encyclopedia covering the complete landscape of reliability, condition-based maintenance, predictive maintenance, and asset management**

Compiled through comprehensive parallel research from standards bodies, major contributors, technical literature, and industry best practices. Research conducted at AlphaSense/McKinsey partner level across 13 major domains.

---

## 📱 Download as Ebook

**NEW!** The entire encyclopedia is now available as a Kindle-ready ebook:

- **Format:** EPUB (compatible with Kindle 2022+ and all Kindle apps)
- **File:** `ebook-output/Reliability-Asset-Management-Encyclopedia.epub`
- **Size:** 373 KB
- **Content:** All 250,000+ words across 16 documents with full table of contents

### Quick Transfer to Kindle:
1. 📧 **Email method** (easiest): See [QUICK-START.md](./QUICK-START.md) - 2 minutes!
2. 🔌 **USB cable**: Copy EPUB to Kindle's Documents folder
3. 📖 **Full guide**: See [KINDLE-TRANSFER-GUIDE.md](./KINDLE-TRANSFER-GUIDE.md)

### Rebuild Ebook:
```bash
./build-ebook.sh
```

---

## 📖 Table of Contents

### Core Technologies & Methods

1. **[Major Contributors](./major-contributors-encyclopedia.md)** (58,000 words)
   - Key companies: Bently Nevada, SKF, Emerson/AMS, Rockwell, Honeywell, GE Digital, Schneider Electric, PRÜFTECHNIK
   - Thought leaders: John Moubray, Donald Bently, Nowlan & Heap, Anthony Smith, James Reason, Terrence O'Hanlon
   - Professional organizations: Vibration Institute, SMRP, EFNMS, IAM, Mobius Institute, MIMOSA
   - Standards and frameworks: ISO 55000, API 670, ISO 17359

2. **[Reliability Centered Maintenance (RCM)](./reliability-centered-maintenance.md)** (28,000 words)
   - Classical RCM methodology and seven questions framework
   - FMEA/FMECA and logic tree analysis
   - SAE JA1011/JA1012 standards
   - Evolution from aviation (MSG-3) to industrial applications
   - Implementation strategies, ROI analysis, and business case development

3. **[History of Reliability & Asset Management](./History_of_Reliability_and_Asset_Management.md)** (62,000+ words)
   - Complete timeline from pre-1950s breakdown maintenance to 2025 AI/IoT era
   - Key milestones: RCM development, TPM, Six Sigma, ISO 55000, Industry 4.0
   - Geographic variations: European, North American, Asian approaches
   - Industry-specific evolution: Aviation, nuclear, oil & gas, manufacturing
   - Future trends and sustainability integration

### Condition Monitoring Technologies

4. **[Rotating Equipment Condition Monitoring](./rotating-equipment-monitoring.md)** (Comprehensive)
   - Vibration analysis: Time domain, FFT, envelope analysis, order tracking, ODS
   - Oil analysis: Wear particles, contamination, fluid properties
   - Thermography, ultrasound, MCSA/ESA
   - Equipment types: Pumps, compressors, turbines, motors, gearboxes, bearings
   - Failure modes: Unbalance, misalignment, bearing faults, gear wear, resonance, looseness, cavitation

5. **[Static Equipment Condition Monitoring](./Static_Equipment_Condition_Monitoring.md)** (26,000 words)
   - Equipment types: Pressure vessels, heat exchangers, storage tanks, piping, columns, reactors, boilers, furnaces
   - Monitoring technologies: UT, RT, AE, guided wave, corrosion monitoring, thermography
   - Degradation mechanisms: Corrosion, erosion, fatigue, creep, fouling, hydrogen damage
   - Standards: API 510/570/653, RBI, Fitness-for-Service (API 579)

6. **[Electrical Condition Monitoring](./electrical-condition-monitoring.md)** (8,100 words)
   - Technologies: MCSA, MCA, partial discharge, insulation testing, thermography, power quality
   - Equipment: Motors, generators, transformers, switchgear, VFDs, cables, batteries
   - Failure modes: Insulation degradation, winding faults, rotor bars, eccentricity
   - Standards: IEEE 43, IEEE 112/115, IEC 60034, NEMA MG-1

7. **[Instrumentation Condition Monitoring](./Instrumentation_Condition_Monitoring.md)** (18,500 words)
   - Instrument types: Pressure, temperature, flow, level sensors, analytical instruments, control valves
   - Monitoring techniques: Loop diagnostics, valve signature analysis, HART diagnostics, NAMUR NE 107
   - Failure modes: Drift, calibration errors, fouling, erosion, stiction
   - Standards: ISA 5.1/18.2/75.25/84, IEC 61508/61511, NAMUR recommendations
   - Integration with DCS/PLC and CMMS/EAM systems

### Digital Infrastructure

8. **[Communication Protocols](./docs/industrial-communication-protocols.md)** (161 KB suite)
   - Industrial Ethernet: OPC UA, MQTT, Modbus TCP, Ethernet/IP, PROFINET, EtherCAT
   - Legacy/Serial: Modbus RTU, HART, FOUNDATION Fieldbus, DeviceNet, PROFIBUS
   - Wireless: WirelessHART, ISA100.11a, Wi-Fi, BLE, LoRaWAN, 5G
   - IT/Cloud: HTTP/REST, WebSocket, AMQP, Kafka, gRPC, CoAP
   - **Companion documents:**
     - [Protocol Comparison Reference](./docs/protocol-comparison-reference.md)
     - [Implementation Examples](./docs/protocol-implementation-examples.md)
     - [Protocols Documentation Guide](./docs/README.md)

9. **[Network Architecture](./network-architecture-industrial-iot.md)** (19,500 words)
   - Reference models: Purdue/ISA-95, IEC 62443, IIoT architectures, edge-fog-cloud
   - Network layers: Levels 0-5 from field devices to enterprise/cloud
   - Topologies: Star, ring, mesh, redundancy architectures
   - Edge computing: Gateways, local analytics, protocol translation, edge AI/ML
   - Cloud platforms: AWS IoT, Azure IoT, Google Cloud IoT
   - Cybersecurity: Defense in depth, network segmentation, DMZ, zero trust

10. **[Algorithms & Analytics](./predictive-maintenance-algorithms-encyclopedia.md)** (9,300 words)
    - Signal processing: FFT, envelope analysis, wavelets, TSA, order tracking
    - Classical statistics: SPC, regression, PCA, Mahalanobis distance, CUSUM, EWMA
    - Proprietary systems: SmartSignal, Mtell, PRISM
    - Machine learning: Supervised (SVM, random forests, neural nets), unsupervised (clustering, autoencoders), deep learning (CNN, LSTM, transformers)
    - Advanced techniques: Digital twins, PINNs, hybrid models, transfer learning, XAI
    - RUL estimation: Degradation modeling, survival analysis, particle filters, Kalman filtering

### Industry & Standards

11. **[Industry-Specific Advances](./industry-specific-advances.md)** (5,200 words)
    - Oil & Gas: Offshore platforms, pipeline integrity, subsea equipment, FLNG/FPSO
    - Power Generation: Nuclear (EPRI), fossil, CCGT, wind, solar, hydro, BESS
    - Manufacturing: Automotive TPM, semiconductor, pharma, Industry 4.0
    - Aviation, maritime, rail, data centers
    - Recent innovations (2020-2025): AI/ML, digital twins, autonomous inspection, 5G/IoT

12. **[Standards Reference](./reliability-standards-reference.md)** (2,700 words)
    - ISO: 55000 (asset mgmt), 20816 (vibration), 13373/13374 (condition monitoring), 18436 (certification)
    - API: 670 (machinery protection), 610/617 (pumps/compressors), 510/570/653 (inspection)
    - IEC: 60034 (motors), 61508/61511 (safety), 62443 (cybersecurity)
    - IEEE/ANSI, ASME, ASTM, NFPA, SAE, NACE, ISA, VDI, BS/EN
    - 150+ standards in table format

### Learning Resources

13. **[Notable Podcasts & Educational Resources](./Notable_Podcasts_and_Educational_Resources.md)**
    - 20+ podcasts: Rooted in Reliability, Speaking of Reliability, Industrial Talk, Maintenance Mavericks
    - Specialized: Gear Talk (lubrication), Pumps & Systems, Reliability 4.0
    - YouTube channels: Mobius Institute, Fluke Reliability, SKF
    - Conference series: IMC, MaximoWorld, SMRP events, Vibration Institute
    - Organized by topic (vibration, lubrication, RCM, leadership) and professional level

---

## 🎯 Quick Navigation by Role

### **For Technicians**
- [Rotating Equipment Monitoring](./rotating-equipment-monitoring.md) - Vibration data collection
- [Oil Analysis Basics](./rotating-equipment-monitoring.md#22-oil-analysis)
- [Electrical Testing](./electrical-condition-monitoring.md)
- [Podcasts for Technicians](./Notable_Podcasts_and_Educational_Resources.md#professional-level-recommendations)

### **For Engineers**
- [RCM Methodology](./reliability-centered-maintenance.md)
- [Failure Mode Analysis](./rotating-equipment-monitoring.md#4-failure-modes-and-diagnostic-signatures)
- [Algorithms & Analytics](./predictive-maintenance-algorithms-encyclopedia.md)
- [Standards Reference](./reliability-standards-reference.md)
- [Network Architecture](./network-architecture-industrial-iot.md)

### **For Managers**
- [Major Contributors](./major-contributors-encyclopedia.md) - Industry landscape
- [RCM Implementation](./reliability-centered-maintenance.md#4-implementation)
- [ROI & Business Case](./reliability-centered-maintenance.md#462-roi-analysis)
- [Industry Advances](./industry-specific-advances.md)
- [Communication Protocols Overview](./docs/README.md)

### **For Executives**
- [History & Evolution](./History_of_Reliability_and_Asset_Management.md)
- [Digital Transformation](./network-architecture-industrial-iot.md)
- [Industry Benchmarks](./industry-specific-advances.md)
- [Standards Compliance](./reliability-standards-reference.md)

---

## 📊 Encyclopedia Statistics

- **Total Documents:** 16 files
- **Total Content:** ~250,000+ words
- **Research Depth:** Expert/consultant level
- **Coverage Areas:** 13 major domains
- **Standards Referenced:** 150+
- **Companies/Contributors:** 50+
- **Technologies Covered:** 100+

---

## 🔍 Research Methodology

This encyclopedia was compiled through:

1. **Standards Review:** ISO, API, IEC, IEEE, ANSI, ASME, ASTM, NFPA, SAE, NACE, ISA standards
2. **Industry Publications:** Vibrations Magazine, Uptime Magazine, technical journals
3. **Professional Organizations:** Vibration Institute, SMRP, EFNMS, Mobius Institute, Reliabilityweb
4. **Vendor Documentation:** Bently Nevada, SKF, Emerson, Rockwell, Honeywell, GE Digital
5. **Academic Literature:** Foundational research papers and textbooks
6. **Web Research:** Industry websites, technical forums, conference proceedings
7. **Best Practices:** Real-world implementations and case studies

Research conducted at the depth and breadth of:
- AlphaSense professional intelligence platform
- McKinsey partner-level industry analysis
- Subject matter expert consultation

---

## 🚀 How to Use This Encyclopedia

### For Learning
1. Start with [History](./History_of_Reliability_and_Asset_Management.md) for context
2. Deep dive into [RCM](./reliability-centered-maintenance.md) for methodology
3. Explore technology-specific docs for your equipment type
4. Reference [Standards](./reliability-standards-reference.md) for compliance

### For Implementation
1. Review [Major Contributors](./major-contributors-encyclopedia.md) for vendor selection
2. Study [RCM Implementation](./reliability-centered-maintenance.md#4-implementation)
3. Design infrastructure using [Network Architecture](./network-architecture-industrial-iot.md)
4. Select tools from [Algorithms](./predictive-maintenance-algorithms-encyclopedia.md)

### For Reference
1. Quick lookup: [Standards](./reliability-standards-reference.md) tables
2. Technology specs: Equipment-specific monitoring documents
3. Industry trends: [Industry Advances](./industry-specific-advances.md)
4. Learning resources: [Podcasts](./Notable_Podcasts_and_Educational_Resources.md)

---

## 📝 Document Formats

- **Comprehensive Guides:** 20K-60K words with full technical depth
- **Reference Documents:** Table-based, 3K-10K words for quick lookup
- **Multi-Document Suites:** Organized collections (protocols)
- **All Documents:** Markdown format with extensive cross-referencing

---

## 🔄 Continuous Updates

This encyclopedia represents a snapshot as of **November 2025**. Key areas for ongoing updates:
- AI/ML algorithm advancements
- New IIoT protocols and standards
- Industry 4.0/5.0 implementations
- Sustainability and ESG integration
- Emerging sensor technologies
- Digital twin maturity evolution

---

## 📧 Contributing & Feedback

This encyclopedia is designed as a living document. Areas for expansion:
- Additional case studies and ROI examples
- Specific vendor implementation guides
- More detailed calculation examples
- Regional regulatory variations
- Industry-specific deep dives

---

## 📚 Citation

When referencing this encyclopedia:

```
Reliability and Asset Management Encyclopedia (2025)
Comprehensive Research Compilation on Condition-Based Maintenance,
Predictive Maintenance, and Asset Management
Repository: reliability-research
```

---

## ⚖️ Legal & Disclaimers

This encyclopedia is compiled from publicly available information, standards, and industry best practices. It is intended for:
- Educational purposes
- Professional reference
- Implementation guidance
- Strategic planning

Always consult:
- Official standards documents for compliance
- Qualified engineers for safety-critical systems
- Equipment manufacturers for specific recommendations
- Legal counsel for regulatory requirements

---

## 🌟 Acknowledgments

This encyclopedia builds upon decades of research and practice by:
- Standards organizations (ISO, API, IEC, IEEE, ASME)
- Professional societies (Vibration Institute, SMRP, EFNMS)
- Industry pioneers (Moubray, Bently, Nowlan & Heap, Smith, Reason)
- Equipment manufacturers and technology providers
- Countless reliability professionals sharing knowledge worldwide

---

**Last Updated:** November 17, 2025
**Repository:** `/reliability-research`
**Branch:** `claude/setup-sub-agents-01C5jwN6Q5sFwimbCxeuMgsU`

---

*This encyclopedia represents the collective knowledge of the reliability and asset management community, compiled to advance the profession and improve industrial asset performance worldwide.*
