cmake_minimum_required(VERSION 3.17)

include(${CMAKE_SOURCE_DIR}/../../Config/CMake/ArduinoDue.cmake)


#
# Base project settings
#
project(ArduinoSyscalls C CXX ASM)
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
#<none>


# Include files
include_directories(${ARDUINO_CORE_SRC}/cores/arduino/)
include_directories(${ARDUINO_CORE_SRC}/variants/${ARDUINO_VARIANT})


#
# Project source files
#
file(GLOB SOURCES
         "${ARDUINO_CORE_SRC}/cores/arduino/iar_calls_sam3.c*"
         "${ARDUINO_CORE_SRC}/cores/arduino/syscalls_sam3.c*"
         "${ARDUINO_CORE_SRC}/cores/arduino/abi.c*"
         "${ARDUINO_CORE_SRC}/cores/arduino/new.c*"
    )


#
# Target creation
#
add_library(${PROJECT_NAME} STATIC ${SOURCES})

