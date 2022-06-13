cmake_minimum_required(VERSION 3.17)

set(ARDUINO_DEVROOT ${CMAKE_SOURCE_DIR}/../../../Arduino.Dev)
include(${ARDUINO_DEVROOT}/Config/CMake/ArduinoDue.cmake)


#
# Base project settings
#
project(ILI9341_due C CXX ASM)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_C_STANDARD 11)


#
# Build options
#
include(${ARDUINO_CMAKE_DIR}/BuildOptionsStandard.cmake)
include(${ARDUINO_CMAKE_DIR}/BuildPic.cmake)


#
# Libraries
#
include(${ARDUINO_CMAKE_DIR}/libArduinoLib.cmake)
include(${ARDUINO_CMAKE_DIR}/libAdafruit_BusIO.cmake)
include(${ARDUINO_CMAKE_DIR}/libAdafruit_GFX.cmake)


# Include files
include_directories(src/)


#
# Project source files
#

# We need to apply some patch to the source
file(MAKE_DIRECTORY patched_src/)
add_custom_command(
    OUTPUT patched_src/ILI9341_due_patched.cpp
    COMMAND patch -p0 -o patched_src/ILI9341_due_patched.cpp -i ILI9341_due.cpp.patch src/ILI9341_due.cpp
    DEPENDS src/ILI9341_due.cpp
)
set(SOURCES patched_src/ILI9341_due_patched.cpp)


#
# Target creation
#
add_library(${PROJECT_NAME} STATIC ${SOURCES})


# generation of include/ sub-directory
#
file(GLOB HEADERS "src/*.h")
file(GLOB HEADERS2 "src/fonts/*.h")
file(COPY ${HEADERS} DESTINATION include/)
file(COPY ${HEADERS2} DESTINATION include/fonts/)
