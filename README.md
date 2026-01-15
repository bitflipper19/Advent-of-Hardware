# Introduction about the Solution Flow
I've written most of the solutions of AoC'25 in C++. Came across the [Jane Street Blog](https://blog.janestreet.com/advent-of-fpga-challenge-2025/) recently and wanted to try out running algorithms on custom hardware for maximum optimizations. So, here is my solution submission for the **Advent of FPGA**:

1. Firstly wrote the solutions in `cpp` for an algorithm/psedudo-code overview. The solutions can be found in `/cppSolutions`
2. Then thought about the hardware required for the implementation, adders, hardware to calculate modulo efficiently, comparators, etc.
3. Implemented the hardware design in verilog first, can be found in `/verilog` alongwith the testbenches.
4. Tried to learn Hardcaml (ngl a challenging language, or maybe I'm too comfortable with C-like languages `c, cpp, verilog, dart, etc.`)
5. Implemented the designs one-to-one in Hardcaml - `day1p1.ml` and `day1p2.ml`!!

---
# Simulating the C++ solutions

---
# Simulating the Verilog solutions

---
# Hardcaml - Overview
