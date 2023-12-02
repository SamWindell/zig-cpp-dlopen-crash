Linux Fedora 36

Run `zig build run -Dexe_is_cpp=true` and the program will crash when trying to call into the shared library code:
```
running main() from c++ code
dlopen success
found lib_function
run exe: error: the following command terminated unexpectedly:
/home/sam/Projects/test/zig-out/bin/exe /home/sam/Projects/test/zig-cache/o/7a86538c87efc7d48d80a197784b9da6/liblib.so
```

Run `zig build run -Dexe_is_cpp=false` and the program will succeed.

Additionally, compiling the program as C++ but using g++ or clang++ works fine: `./gcc_build.sh`
