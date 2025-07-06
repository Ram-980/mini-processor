 MIPS Processor

A 32-bit processor implementation supporting basic MIPS instructions with a 5-stage pipeline and memory subsystem.

Instruction Fetching:
Retrieves instructions from instruction memory using the Program Counter (PC).Supports branch and jump instructions for controlling program flow.

Instruction Decoding & Control Signals:
The Control Unit interprets opcode and function codes from instructions. Generates control signals for ALU operations, memory access, and register updates.

Arithmetic & Logic Operations
The Arithmetic Logic Unit (ALU) performs fundamental operations: Uses flags like the zero flag for branch decisions.

Register Access & Updates
The Register File stores 32 registers of 32 bits each. Supports dual-read and single-write operations for efficient data handling.

Data Memory Access
Handles memory read and write operations synchronously. Separates instruction memory and data memory for better performance.

Branch Prediction & Flow Control
Supports conditional branching based on ALU calculations.
Ensures efficient execution by predicting branch outcomes.

1. Program Counter (PC)
   - Manages instruction address flow
   - Implements jumps/branches

2. Control Unit
   - Decodes opcode
   - Generates 11 control signals including:
     - `ALU_Con` (4-bit ALU opcode)
     - `MemtoReg` (memory → register mux)
     - `RegWrite` (register file enable)
4. Register File
   32×32 bit storage
    Dual-read/single-write ports

5. Memory System
   - 1024×32 bit instruction memory
   - 1024×32 bit data memory
   - Synchronous write/async read



Processor Top Module 
- Manages program counter updates
- Handles instruction fetching and data memory access
- Implements pipeline registers and hazard detection
- Connects all major components:
  - Program Counter (PC)
  - Register File
  - ALU
  - Control Unit
  - Memory Subsystem

