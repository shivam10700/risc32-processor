# 32-bit Pipelined RISC Processor (Verilog)

## Overview
This project implements a 32-bit RISC processor using a 5-stage pipeline architecture:

- Instruction Fetch (IF)
- Instruction Decode (ID)
- Execute (EX)
- Memory (MEM)
- Write Back (WB)

Designed and simulated using Verilog HDL on EDA Playground.

---

## Features
- 32-bit architecture
- 5-stage pipelining
- ALU operations (ADD, SUB, AND, OR, XOR)
- Register file (32 registers)
- Instruction & Data Memory
- Functional testbench

---

## Architecture

![Pipeline Diagram]
<img width="1361" height="172" alt="pipeline_waveform" src="https://github.com/user-attachments/assets/97886122-e540-4fe3-955f-1054e409faa8" />


---

## Simulation Results

### Waveform Output
<img width="1353" height="136" alt="waveform_basic" src="https://github.com/user-attachments/assets/81430ac8-da7b-4bba-82c7-e30ea4f4cc2c" />



---

##  Tools Used
- Verilog HDL
- EDA Playground
- GTKWave

---

##  How to Run
1. Open EDA Playground
2. Copy design files and testbench
3. Run simulation
4. View waveform in GTKWave

---

##  Future Improvements
- Hazard Detection Unit
- Forwarding Unit
- Branch Prediction
- RISC-V ISA support
