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
include CMakeFiles/Contraction_Profiler_CPP.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/Contraction_Profiler_CPP.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/Contraction_Profiler_CPP.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/Contraction_Profiler_CPP.dir/flags.make

CMakeFiles/Contraction_Profiler_CPP.dir/contraction_creator.cpp.o: CMakeFiles/Contraction_Profiler_CPP.dir/flags.make
CMakeFiles/Contraction_Profiler_CPP.dir/contraction_creator.cpp.o: /Users/srinath/Documents/Github/contraction_profiler_CPP/contraction_creator.cpp
CMakeFiles/Contraction_Profiler_CPP.dir/contraction_creator.cpp.o: CMakeFiles/Contraction_Profiler_CPP.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/Users/srinath/Documents/Github/contraction_profiler_CPP/cmake/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/Contraction_Profiler_CPP.dir/contraction_creator.cpp.o"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -MD -MT CMakeFiles/Contraction_Profiler_CPP.dir/contraction_creator.cpp.o -MF CMakeFiles/Contraction_Profiler_CPP.dir/contraction_creator.cpp.o.d -o CMakeFiles/Contraction_Profiler_CPP.dir/contraction_creator.cpp.o -c /Users/srinath/Documents/Github/contraction_profiler_CPP/contraction_creator.cpp

CMakeFiles/Contraction_Profiler_CPP.dir/contraction_creator.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing CXX source to CMakeFiles/Contraction_Profiler_CPP.dir/contraction_creator.cpp.i"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /Users/srinath/Documents/Github/contraction_profiler_CPP/contraction_creator.cpp > CMakeFiles/Contraction_Profiler_CPP.dir/contraction_creator.cpp.i

CMakeFiles/Contraction_Profiler_CPP.dir/contraction_creator.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling CXX source to assembly CMakeFiles/Contraction_Profiler_CPP.dir/contraction_creator.cpp.s"
	/Library/Developer/CommandLineTools/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /Users/srinath/Documents/Github/contraction_profiler_CPP/contraction_creator.cpp -o CMakeFiles/Contraction_Profiler_CPP.dir/contraction_creator.cpp.s

# Object files for target Contraction_Profiler_CPP
Contraction_Profiler_CPP_OBJECTS = \
"CMakeFiles/Contraction_Profiler_CPP.dir/contraction_creator.cpp.o"

# External object files for target Contraction_Profiler_CPP
Contraction_Profiler_CPP_EXTERNAL_OBJECTS =

Contraction_Profiler_CPP: CMakeFiles/Contraction_Profiler_CPP.dir/contraction_creator.cpp.o
Contraction_Profiler_CPP: CMakeFiles/Contraction_Profiler_CPP.dir/build.make
Contraction_Profiler_CPP: CMakeFiles/Contraction_Profiler_CPP.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/Users/srinath/Documents/Github/contraction_profiler_CPP/cmake/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable Contraction_Profiler_CPP"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/Contraction_Profiler_CPP.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/Contraction_Profiler_CPP.dir/build: Contraction_Profiler_CPP
.PHONY : CMakeFiles/Contraction_Profiler_CPP.dir/build

CMakeFiles/Contraction_Profiler_CPP.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/Contraction_Profiler_CPP.dir/cmake_clean.cmake
.PHONY : CMakeFiles/Contraction_Profiler_CPP.dir/clean

CMakeFiles/Contraction_Profiler_CPP.dir/depend:
	cd /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/srinath/Documents/Github/contraction_profiler_CPP /Users/srinath/Documents/Github/contraction_profiler_CPP /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake /Users/srinath/Documents/Github/contraction_profiler_CPP/cmake/CMakeFiles/Contraction_Profiler_CPP.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/Contraction_Profiler_CPP.dir/depend

