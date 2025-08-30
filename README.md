# Microprocessor 1
This is a repo containing all code and documentation for a DLX microprocessor implementation in Verilog. I am implementing 5 primary modules: Instruction fetch (IF), Instruction decode (ID), Execute (EX), Memory Access (MEM), and Writeback (WB). 

FEATURES:
NO cache (for now)
16 8 bit registers (for storing data)
16 bit long instructions:
    4 bit instruction (16 different instructions)
    12 bits decoded based on instruction type (immediates, load/store, arithmatic, etc.)


MODULE DESCRIPTIONS:

Instruction Fetch:
    Based on the program counter, fetches the instruction from memory into instruction register. Adds to program counter. 
    Mem[PC] -> Instruction Register
    PC + 4  -> Next PC

