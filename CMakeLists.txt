# set(CMAKE_MACOSX_RPATH TRUE)
# if(POLICY CMP0042)
#   cmake_policy(SET CMP0042 NEW)
# endif()
cmake_minimum_required(VERSION 3.14 FATAL_ERROR)
project(Contraction_Profiler_CPP CXX CUDA)

# Include CPM
include(cmake/CPM.cmake)

find_package(CUDAToolkit REQUIRED)

add_definitions(-DUSE_CUDA)    
include_directories("${CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES}")

# link libraries with target
add_executable(Contraction_Profiler_CPP contraction_creator.cpp)
target_link_libraries(Contraction_Profiler_CPP cudart)
set_target_properties(${PROJECT_NAME} PROPERTIES CUDA_ARCHITECTURES "80")