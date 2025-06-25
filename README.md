# 🧠 SystemVerilog Projects – RTL Design & Verification

Welcome to my SystemVerilog project repository! This space showcases my hands-on journey into the world of digital design and verification using **SystemVerilog**, a hardware description and verification language that powers modern ASIC and FPGA development.

---

## 🚀 Overview

This repository contains a collection of **RTL design modules**, **testbenches**, and **verification environments** built using **SystemVerilog**. Each project is crafted with a strong focus on clean code, modular structure, and real-world relevance.

Topics covered range from basic combinational and sequential logic to more advanced concepts like assertions, interfaces, and UVM-style verification.

---

## 🎯 Why SystemVerilog?

SystemVerilog was developed to address the growing complexity of digital circuits. It enhances Verilog by introducing:

- ✅ Object-oriented verification features  
- ✅ Assertions for formal and functional checking (SVA)  
- ✅ Constrained random stimulus generation  
- ✅ Reusable testbench architectures  
- ✅ Better modularity and abstraction for complex designs

It is standardized by **IEEE 1800** and is widely used across the **semiconductor industry** in both ASIC and FPGA development workflows.

---

---

## 🚀 What’s Inside

This repo includes:
- ✅ RTL modules designed using `always_comb` and `always_ff`
- ✅ Modular and reusable testbenches
- ✅ SystemVerilog Assertions (SVA) for functional correctness
- ✅ Interfaces and packages to structure and scale design
- ✅ Structured directory layout for simulation and documentation

---

## ⚒️ Tools Used

- 🧪 **ModelSim / QuestaSim** – For simulation and waveform analysis  
- 📝 **VS Code** – Coding with SystemVerilog extensions  
- 📊 **GTKWave** – Viewing simulation outputs  
- 🔧 *Simulation* **Vivado** – For future FPGA synthesis and implementation

---

## 📖 Current Learning Goals

Here’s how each part of the repo ties into my current learning path:

### 🔹 RTL Design  
📁 `RTL/counter.sv`  
Basic 4-bit counter using `always_ff` with `en` and `rst`.

### 🔹 Testbench Writing  
📁 `Testbenches/tb_counter.sv`  
Testbench with clock generation, control signal stimulus, and result observation.

### 🔹 SystemVerilog Assertions  
📁 `Verification/assert_counter.sv`  
Assertion to check correct counter behavior only when `en = 1`.

### 🔹 Interfaces & Modularity  
📁 `Verification/counter_if.sv`  
Interface definition to bundle related signals and promote reuse.

---

## 📁 Folder Structure

```bash

Topic Wise Data
