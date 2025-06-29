# This is the build script for my OpCounter pass.

# I give this sub-project a unique name to avoid conflicts.
project(llvm-tutor-op-counter)

# Here, I define my pass as a shared library.
# Its name is "OpCounter", and it's built from my OpCounter.cpp file.
# Note: My Runtime.cpp file is not included here because it's not part of the pass library.
# It gets compiled and linked later with the final test program.
add_library(OpCounter SHARED
  OpCounter.cpp
)

# This linker flag is needed for macOS to make sure the pass can be loaded correctly as a plugin.
target_link_libraries(OpCounter
  "$<$<PLATFORM_ID:Darwin>:-undefined dynamic_lookup>"
)
