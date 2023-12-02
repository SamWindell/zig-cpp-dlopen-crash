#!/bin/bash
# compiles correctly with either of the C++ compilers on my machine: g++ 12.2.1 or clang++ 14.0.5
mkdir -p gcc-out
g++ src/exe_main.cpp -o gcc-out/exe
g++ -shared -fPIC src/lib.cpp -o gcc-out/lib.so
./gcc-out/exe $PWD/gcc-out/lib.so
