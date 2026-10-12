# 8086 Assembly Stackless Calculator

A basic arithmetic calculator written in x86/8086 Assembly language. This project demonstrates foundational low-level programming concepts by implementing addition, subtraction, multiplication, and division for numbers up to 3 digits. 

The primary challenge and focus of this project is its strict memory management: it operates **without the use of arrays or processor flags for flow control**, relying entirely on direct variable manipulation and careful memory addressing.

## 🚀 Key Features

*   **Four Basic Operations:** Supports addition, subtraction, multiplication, and division.
*   **Validated Input:** Handles user input up to 3 digits (0-999) and rejects invalid characters.
*   **Stackless Architecture:** The logic is implemented without utilizing the stack for data storage or subroutine parameters.
*   **Zero Arrays:** All operations, including complex multi-digit multiplication, are performed using individual byte and word variables.
*   **Direct Memory Management:** Demonstrates efficient use of memory segments, registers (`AX`, `BX`, `CX`, `DX`), and manual carry/borrow logic instead of relying on built-in flags.

## 🧠 Memory Management & How It Works

Instead of using arrays to store multi-digit numbers or intermediate results, this calculator defines specific variables in the `.DATA` segment for every stage of the calculation.

1.  **Input Parsing:** When a user enters a number, it is captured digit by digit (up to 3). Each digit is converted from ASCII to its numerical value and stored in distinct variables (`centenas1`, `decenas1`, `unidades1`).
2.  **Manual Carry/Borrow:** For addition and subtraction, the code manually checks if a digit exceeds 9 (or goes below 0) and propagates the carry/borrow to the next variable (e.g., using an `aux` variable for addition).
3.  **Multiplication Logic:** The multiplication operation is broken down into partial products, simulating how it's done on paper. Individual variables (`cero`, `uno`, `dos`, ..., `once`) hold the result of multiplying specific positional digits. The `AAM` (ASCII Adjust for Multiply) instruction is heavily used to separate results into tens and units for further addition.
4.  **Division Logic:** Multi-digit inputs are reconstructed into single `word` values (`dividend`, `divisor`) by multiplying the hundreds and tens variables. The `DIV` instruction handles the operation, and the quotient is broken back down into digits for display.

## 🛠️ Requirements & Usage

To run this code, you will need an MS-DOS emulator (like DOSBox) and an assembler (like MASM or TASM).

1.  Assemble the code: `TASM OperMacros.asm` (or equivalent).
2.  Link the object file: `TLINK OperMacros.obj`.
3.  Run the executable: `OperMacros.exe`.
4.  Follow the on-screen menu to select an operation and input your numbers.

---
*This project is part of my continuous learning in low-level programming and system architecture.*
