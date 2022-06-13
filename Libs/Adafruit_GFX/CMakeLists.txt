cmake_minimum_required(VERSION 3.17)

set(ARDUINO_DEVROOT ${CMAKE_SOURCE_DIR}/../../../Arduino.Dev)
include(${ARDUINO_DEVROOT}/Config/CMake/ArduinoDue.cmake)


#
# Base project settings
#
project(Adafruit_GFX C CXX ASM)
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


# Include files
include_directories(src/)


#
# Project source files
#
file(GLOB SOURCES "src/*.c*")


#
# Target creation
#
add_library(${PROJECT_NAME} STATIC ${SOURCES})


# generation of include/ sub-directory
#
file(GLOB HEADERS "src/*.h")
file(COPY ${HEADERS} DESTINATION include/)
file(GLOB HEADERSFNT "src/Fonts/*.h")
file(COPY ${HEADERSFNT} DESTINATION include/Fonts/)
