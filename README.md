# Summer Practice – AMD MIPS Implementation

This project implements a basic 32-bit MIPS processor in Verilog as part of a summer internship at AMD. It covers instruction fetch, decode, execute, memory access, and write-back stages using a five-stage pipeline.

---

## Project Structure

```
├── src/                   # Verilog source files
│   ├── mips.v            # Top-level MIPS module integrating all stages
│   ├── if_stage.v        # Instruction Fetch: PC, instruction memory interface
│   ├── id_stage.v        # Instruction Decode: register file, control signals
│   ├── ex_stage.v        # Execute: ALU operations
│   ├── mem_stage.v       # Memory Access: data memory interface
│   ├── wb_stage.v        # Write-Back: selects register write data
│   ├── control.v         # Main control logic for opcode/function decoding
│   ├── registers.v       # Register file implementation
│   ├── alu.v             # ALU with add, sub, logical, shift operations
│   └── pipeline_regs.v   # Pipeline registers between stages
├── tb/                    # Test benches and simulation scripts
│   ├── mips_tb.v         # Top-level test bench stimulating instruction sequence
│   └── wave.do            # ModelSim DO file for waveform generation
├── instr_mem.txt          # Sample instruction memory contents (hex words)
├── data_mem.txt           # Initial data memory contents (hex words)
├── README.md              # This file
└── LICENSE                # Project license (e.g., MIT)
```

---

## Features

* **Five-Stage Pipeline:** Instruction Fetch (IF), Decode (ID), Execute (EX), Memory (MEM), Write-Back (WB).
* **ALU Operations:** Supports arithmetic (ADD, SUB), logical (AND, OR, XOR), shift (SLL, SRL), and set-less-than.
* **Control Unit:** Decodes opcodes and function codes to generate control signals.
* **Register File:** 32 general-purpose registers with two read ports and one write port.
* **Data & Instruction Memory:** Simple synchronous memories initialized from text files.
* **Hazard Handling (Minimal):** Pipeline registers separate stages; no forwarding or hazard stalling included.

---

## Prerequisites

* **Verilog Simulator:** ModelSim, Vivado Simulator, or any compatible tool.
* **GNU Make (optional):** For running automated simulation scripts.

---

## Simulation & Testing

1. **Compile Verilog Sources**

   ```bash
   # Using ModelSim
   vlog src/*.v tb/mips_tb.v
   ```

2. **Run Test Bench**

   ```bash
   vsim work.mips_tb -do tb/wave.do
   ```

3. **View Waveforms**

   ```tcl
   # In ModelSim transcript
   view wave -autoscale sim:/mips_tb/*
   ```

4. **Check Output**

   * The test bench prints register contents and memory updates to the console.
   * Verify that instructions execute correctly in sequence.

---

## Usage Example

* Initialize `instr_mem.txt` with a sequence of MIPS instructions in hexadecimal.
* Populate `data_mem.txt` with initial data values.
* Run the simulation; observe correct data flow through pipeline stages and final register states.

---

## Potential Improvements

* **Hazard Detection & Forwarding:** Implement pipeline stall logic and data forwarding to handle RAW hazards.
* **Branch Prediction:** Add simple static or dynamic branch prediction to reduce control hazards.
* **Exception Handling:** Incorporate interrupt and exception vectors.
* **Cache Simulation:** Model instruction and data caches.
* **Performance Metrics:** Track CPI and pipeline stall counts.

---

## License

This project is licensed under the MIT License. See `LICENSE` for details.
