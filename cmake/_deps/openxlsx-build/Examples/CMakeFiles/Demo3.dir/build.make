# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.30

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/homebrew/Cellar/cmake/3.30.4/bin/cmake

# The command to remove a file.
RM = /opt/homebrew/Cellar/cmake/3.30.4/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/srinath/Documents/Github/contraction_profiler_CPP

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake

# Include any dependencies generated for this target.
include _deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include _deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/compiler_depend.make

# Include the progress variables for this target.
include _deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/progress.make

# Include the compile flags for this target's objects.
include _deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/flags.make

_deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/Demo3.cpp.o: _deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/flags.make
_deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/Demo3.cpp.o: _deps/openxlsx-src/Examples/Demo3.cpp
_deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/Demo3.cpp.o: _deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/srinath/Documents/Github/contraction_profiler_CPP/cmake/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object _deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/Demo3.cpp.o"
	cd /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake/_deps/openxlsx-build/Examples && /Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT _deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/Demo3.cpp.o -MF CMakeFiles/Demo3.dir/Demo3.cpp.o.d -o CMakeFiles/Demo3.dir/Demo3.cpp.o -c /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake/_deps/openxlsx-src/Examples/Demo3.cpp

_deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/Demo3.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/Demo3.dir/Demo3.cpp.i"
	cd /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake/_deps/openxlsx-build/Examples && /Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake/_deps/openxlsx-src/Examples/Demo3.cpp > CMakeFiles/Demo3.dir/Demo3.cpp.i

_deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/Demo3.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/Demo3.dir/Demo3.cpp.s"
	cd /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake/_deps/openxlsx-build/Examples && /Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake/_deps/openxlsx-src/Examples/Demo3.cpp -o CMakeFiles/Demo3.dir/Demo3.cpp.s

# Object files for target Demo3
Demo3_OBJECTS = \
"CMakeFiles/Demo3.dir/Demo3.cpp.o"

# External object files for target Demo3
Demo3_EXTERNAL_OBJECTS =

output/Demo3: _deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/Demo3.cpp.o
output/Demo3: _deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/build.make
output/Demo3: output/libOpenXLSX.a
output/Demo3: _deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/Users/srinath/Documents/Github/contraction_profiler_CPP/cmake/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ../../../output/Demo3"
	cd /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake/_deps/openxlsx-build/Examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Demo3.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
_deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/build: output/Demo3
.PHONY : _deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/build

_deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/clean:
	cd /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake/_deps/openxlsx-build/Examples && $(CMAKE_COMMAND) -P CMakeFiles/Demo3.dir/cmake_clean.cmake
.PHONY : _deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/clean

_deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/depend:
	cd /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/srinath/Documents/Github/contraction_profiler_CPP /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake/_deps/openxlsx-src/Examples /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake/_deps/openxlsx-build/Examples /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake/_deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : _deps/openxlsx-build/Examples/CMakeFiles/Demo3.dir/depend

