# Microprocessor 1
This is a repo containing all code and documentation for a DLX microprocessor implementation in Verilog. I am implementing 5 primary modules: Instruction fetch (IF), Instruction decode (ID), Execute (EX), Memory Access (MEM), and Writeback (WB). 


Module Descriptions:

Instruction Fetch:
Based on the program counter, fetches the instruction from memory into instruction register. Adds to program counter. 
Mem[PC] -> Instruction Register
PC + 4  -> Next PC

