set(CMAKE_MACOSX_RPATH TRUE)
# if(POLICY CMP0042)
#   cmake_policy(SET CMP0042 NEW)
# endif()
cmake_minimum_required(VERSION 3.14 FATAL_ERROR)
project(Contraction_Profiler_CPP)

# Include CPM
include(cmake/CPM.cmake)

# Link xlsxio with your target
add_executable(Contraction_Profiler_CPP contraction_creator.cpp)