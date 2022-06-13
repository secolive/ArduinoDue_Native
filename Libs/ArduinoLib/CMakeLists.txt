cmake_minimum_required(VERSION 3.17)

include(${CMAKE_SOURCE_DIR}/../../Config/CMake/ArduinoDue.cmake)


#
# Base project settings
#
project(ArduinoLib C CXX ASM)
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
include_directories(${ARDUINO_CORE_SRC}/cores/arduino/USB)
include_directories(${ARDUINO_CORE_SRC}/variants/${ARDUINO_VARIANT})
include_directories(${ARDUINO_CORE_SRC}/libraries/HID/src)
include_directories(${ARDUINO_CORE_SRC}/libraries/SPI/src)
include_directories(${ARDUINO_CORE_SRC}/libraries/Wire/src)


#
# Project source files
#
#file(GLOB_RECURSE SOURCES "src/*.c*")
file(GLOB_RECURSE SOURCES
         "${ARDUINO_CORE_SRC}/cores/arduino/*.c*"
         "${ARDUINO_CORE_SRC}/variants/${ARDUINO_VARIANT}/*.c*"
         "${ARDUINO_CORE_SRC}/libraries/*.c*")


#
# Target creation
#
add_library(${PROJECT_NAME} STATIC ${SOURCES})


#
# generation of include/ sub-directory
#
file(COPY ${ARDUINO_CORE_SRC}/cores/arduino/ DESTINATION include/core/ FILES_MATCHING PATTERN "*.h*")
file(COPY ${ARDUINO_CORE_SRC}/variants/${ARDUINO_VARIANT}/ DESTINATION include/core/ FILES_MATCHING PATTERN "*.h*")
file(COPY ${ARDUINO_CORE_SRC}/libraries/HID/src/ DESTINATION include/libraries/HID/ FILES_MATCHING PATTERN "*.h*")
file(COPY ${ARDUINO_CORE_SRC}/libraries/SPI/src/ DESTINATION include/libraries/SPI/ FILES_MATCHING PATTERN "*.h*")
file(COPY ${ARDUINO_CORE_SRC}/libraries/Wire/src/ DESTINATION include/libraries/Wire/ FILES_MATCHING PATTERN "*.h*")
