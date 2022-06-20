cmake_minimum_required(VERSION 3.17)

include(${CMAKE_SOURCE_DIR}/../../Config/CMake/ArduinoDue.cmake)


#
# Base project settings
#
project(doctest CXX)
set(CMAKE_CXX_STANDARD 17)


#
# generation of include/ sub-directory
#
file(GLOB HEADERS1 ${CMAKE_SOURCE_DIR}/doctest/doctest/*.h)
file(GLOB HEADERS2 ${CMAKE_SOURCE_DIR}/doctest/doctest/extensions/*.h)
file(COPY ${HEADERS1} DESTINATION include/)
file(COPY ${HEADERS2} DESTINATION include/extensions/)


# Build library containing implementation
add_library(DoctestImpl STATIC src/doctest_impl.cc)
include_directories(include/)

