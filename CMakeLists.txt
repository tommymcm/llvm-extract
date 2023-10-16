cmake_minimum_required(VERSION 3.13)

# Project
set(tool_name "llvm-excavate")
project(${tool_name} C CXX ASM)

# Get clang
find_program(CLANG_PATH clang)
find_program(CLANGXX_PATH clang++)

# Set the compiler
set(CMAKE_C_COMPILER ${CLANG_PATH})
set(CMAKE_CXX_COMPILER ${CLANGXX_PATH})
set(CMAKE_ASM_COMPILER ${CLANG_PATH})

# Set the output directories
set(CMAKE_STAGING_PREFIX ${CMAKE_BINARY_DIR})
set(CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_SOURCE_DIR}/install)
set(CMAKE_INSTALL_LIBDIR ${CMAKE_INSTALL_PREFIX}/lib)
set(CMAKE_INSTALL_BINDIR ${CMAKE_INSTALL_PREFIX}/bin)
set(CMAKE_INSTALL_INCLUDEDIR ${CMAKE_INSTALL_PREFIX}/include)

# Configure LLVM 
find_package(LLVM 9 REQUIRED CONFIG)

set(LLVM_RUNTIME_OUTPUT_INTDIR ${CMAKE_INSTALL_LIBDIR}/)
set(LLVM_LIBRARY_OUTPUT_INTDIR ${CMAKE_INSTALL_LIBDIR}/)

list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")
include(HandleLLVMOptions)
include(AddLLVM)

include_directories(
  ${LLVM_INCLUDE_DIRS}
  )

message(STATUS "LLVM_DIR IS ${LLVM_CMAKE_DIR}.")

# Collect sources
file(GLOB tool_sources "src/*.cpp")

# Declare the LLVM pass to compile
set(LLVM_LINK_COMPONENTS
  BitWriter
  Core
  IPO
  IRReader
  Support
  )

add_llvm_executable(
  ${tool_name}
  ${tool_sources}
  )

install(TARGETS ${tool_name})
