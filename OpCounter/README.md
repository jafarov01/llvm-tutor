# LLVM OpCounter Pass

This is my solution for the Huxelerate homework assignment. The main goal is to create an LLVM pass that can dynamically count how many times each LLVM-IR operation is executed when running a C program.

## How It Works

My solution has two main parts:

1.  **The Pass (at Compile-Time):** I wrote an LLVM pass called `OpCounter`. When compiling a program, this pass goes through the LLVM IR and injects a function call before every single instruction. This process is called instrumentation.
2.  **The Runtime Library (at Execution-Time):** I also wrote a small C++ runtime library. This library has the counter function that the pass injects, which uses a `std::map` to keep track of the opcode counts. This runtime is then linked into the final program. When the program finishes, an `atexit` handler automatically calls a function to print the final report with all the counts.

## What You Need to Build

To build and run this project, you will need:
* A recent version of **LLVM/Clang (version 19 or newer)**.
* **CMake** (version 3.20 or newer).
* **Ninja** build system.

## How to Build and Run

You should run all of the following commands from the project's root folder (`llvm-tutor`).

**Step 1: Set up your LLVM Path**

First, you need to tell the build system where your LLVM installation is located. Please set the `LLVM_INSTALL_PATH` shell variable to point to the root of your LLVM directory.

For example:
```bash
export LLVM_INSTALL_PATH=/path/to/your/llvm

Step 2: Build the Project and Run the Test

Now, you can run the full process from start to finish. The commands below will use the $LLVM_INSTALL_PATH variable you just set.

# Clean up any previous builds to be safe
rm -rf build
mkdir build
cd build

# Configure the project with CMake, using your custom LLVM path
cmake -G Ninja \
  -DLT_LLVM_INSTALL_DIR=$LLVM_INSTALL_PATH \
  -DCMAKE_C_COMPILER=$LLVM_INSTALL_PATH/bin/clang \
  -DCMAKE_CXX_COMPILER=$LLVM_INSTALL_PATH/bin/clang++ \
  ..

# Build the OpCounter pass
ninja OpCounter

# Return to the project root to run the next steps
cd ..

# Create a sample C file to test with
cat > test.c << EOF
int multiply(int a, int b) {
    return a * b;
}
int main() {
    int result = 0;
    for (int i = 0; i < 10; i++) {
        result += multiply(i, i - 1);
    }
    return result;
}
EOF

# Run the full pipeline
# a: Compile test.c to LLVM IR
clang -S -emit-llvm test.c -o test.ll

# b: Use the OpCounter pass to instrument the IR
opt -load-pass-plugin=./build/lib/libOpCounter.dylib -passes="op-counter" -S test.ll -o instrumented.ll

# c: Compile and link the final program with the C++ runtime
clang++ instrumented.ll OpCounter/Runtime.cpp -o test_program

# d: Execute the program to see the dynamic counts!
./test_program

Expected Output
After running the final command, you should see the following report printed in your terminal:

--- Dynamic Opcode Counts ---
add: 20
alloca: 23
br: 32
call: 10
icmp: 11
load: 72
mul: 10
ret: 11
store: 43
sub: 10
==============================
