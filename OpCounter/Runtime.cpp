#include <iostream>
#include <string>
#include <map>

// I use this global map to store the counts for each opcode.
std::map<std::string, long long> OpcodeCounts;

// This is the function that the instrumented code will call from the pass.
// I use extern "C" so the linker can find it easily by its exact name, "op_counter".
extern "C" void op_counter(const char* opcode) {
    OpcodeCounts[opcode]++;
}

// This function just prints the final results from the map.
void print_results() {
    std::cout << "--- Dynamic Opcode Counts ---\n";
    for (auto const& [opcode, count] : OpcodeCounts) {
        std::cout << opcode << ": " << count << "\n";
    }
    std::cout << "==============================\n";
}

// This is a small C++ trick I used to make sure my print_results() function
// runs automatically when the program is about to exit.
static class AtExitRunner {
public:
    AtExitRunner() {
        atexit(print_results);
    }
} runner;
