# My approach
The algorithm I inferred from the [problem](https://adventofcode.com/2025/day/1) was simple, calculating the final position based upon the current value of the dial and the input, then normalising it in the **0-99** range and counting for **zeros**. 
The implementation involves basic arithmetic, addition, modulus etc.

For the verilog simulation, I used a script to convert the inputs according to my needs, as Idk how to "parse strings" in verilog or in actual hardware. 
The script used can be found in the `/scripts/ipScript.cpp` and the generated `tb.txt` can be pasted into the `/verilog/day1p1_tb.v` appropriately for custom input testing!! 

After sucessful verilog solution, I moved on to write the Hardcaml version, (Ik it's usually the other way around) :p !! Hardcaml generates (or **"constructs"**) verilog for the required hardware.

---
# About the Solution Flow
I've written most of the solutions of AoC'25 in C++. Came across the [Jane Street Blog](https://blog.janestreet.com/advent-of-fpga-challenge-2025/) recently and wanted to try out running algorithms on custom hardware for maximum optimizations. So, here is my solution submission for the **Advent of FPGA'25**:

1. Firstly wrote the solutions in `cpp` for an algorithm/psedudo-code overview. The solutions can be found in `/cppSolutions`
2. Then thought about the hardware required for the implementation, adders, hardware to calculate modulo efficiently, comparators, etc.
3. Implemented the hardware design in verilog first, can be found in `/verilog` alongwith the testbenches.
4. Tried to learn Hardcaml (ngl a challenging language, or maybe I'm too comfortable with C-like languages `c, cpp, verilog, dart, etc.`)
5. Implemented the designs one-to-one in Hardcaml - `day1p1.ml` and `day1p2.ml` [in the project root only]!!

> C++ -> Verilog -> Hardcaml
> 
> Tried to be as modular as possible, for my own sanity, so that mapping the Hardcaml isn't too tedious.
> 
> NOTE: Heavy scope of optimization in the `modulo` module (calculates **n mod 100**), would read about it in depth and then implement it.

---
# Scope of optimization(s)
The single biggest scope of optimization is in calculating the modulo. N mod M is expensive if M is not a perfect power of 2! Here, M=100. 
I can think of this to optimize the modulo calculation (would surely implement in future)

```
N = floor(N/100)*100 + N%100

This implies, N%100 = N - floor(N/100)*100
```

N/100 can be calculated optimally by `(N*ceil(2^S/100)) >> S` [Inspired from [Here](https://www.youtube.com/watch?v=ssDBqQ5f5_0)]. Here **S=37** is optimal.

The current implementation (`assign variable = n%100`) is expensive in terms of both area and time and might not be synthesizable in some cases.

---
# Simulating the C++ solutions
1. Navigate to the `/cppSolutions` directory
2. `day1p1.cpp` is the C++ solution of AoC'25 Day-1 **Part-1**
3. `day1p2.cpp` is the C++ solution of AoC'25 Day-1 **Part-1**
4. run with `g++` or any other cpp-compiler

on command prompt:
```
g++ day1p1.cpp
a.exe < ip.txt
```
The `ip.txt` is my set of inputs, rewrite it if you want custom or your own tests!

Answers to my set of inputs: 

**Part-1: 1168**

**Part-2: 7199**

---
# Simulating the Verilog solutions
> My solution uses 32-bits for storing and calculating, I feel that it's a bit too much but just in case!!
1. Navigate to the `/verilog` directory
2. find the verilog codes and testbenches for

   **Day-1 Part-1**

   `day1p1.v` and tb: `day1p1_tb.v`

   **Day-1 Part-2**

   `day1p2.v` and tb: `day1p2_tb.v`
4. Run using `iverilog` or on Vivado etc.    

---
# Hardcaml - Overview
Learned from youtube and the resources provided in the [blog](https://blog.janestreet.com/advent-of-fpga-challenge-2025/) and tried to map the inferred hardware elements.

Though Hardcaml (OCaml) is a **Hardware Construction Language** whose purpose is to generate **HDL** code like verilog for the designer, I obviously went the opposite way. Wrote verilog first then tried to write Hardcaml. 

Ngl OCaml made me a bit uncomfortable and forced me to come out of my comfort zone. ~~OCaml has no curly braces :(~~, Overall the language is accepting, would definitely try out making CPUs/Processors in Hardcaml and attain fluency in it.

Waiting eagerly for AoFPGA'26, wish to see myself implementing some core data structures like trees and graphs in future!!

---
# Final Note
Overall, enjoyed the challenge!!
