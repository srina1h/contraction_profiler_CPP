set(CMAKE_MACOSX_RPATH TRUE)
# if(POLICY CMP0042)
#   cmake_policy(SET CMP0042 NEW)
# endif()
cmake_minimum_required(VERSION 3.14 FATAL_ERROR)
project(Contraction_Profiler_CPP CXX CUDA)

# Include CPM
include(cmake/CPM.cmake)

# link libraries with target
add_executable(Contraction_Profiler_CPP contraction_creator.cpp)
target_link_libraries(Contraction_Profiler_CPP cudart)