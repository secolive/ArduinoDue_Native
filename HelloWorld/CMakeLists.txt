cmake_minimum_required(VERSION 3.17)

include(${CMAKE_SOURCE_DIR}/../Config/CMake/ArduinoDue.cmake)


#
# Base project settings
#
project(HelloWorld C CXX ASM)
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
include(${ARDUINO_CMAKE_DIR}/libArduinoSyscalls.cmake)
include(${ARDUINO_CMAKE_DIR}/libAdafruit_BusIO.cmake)
include(${ARDUINO_CMAKE_DIR}/libAdafruit_GFX.cmake)
include(${ARDUINO_CMAKE_DIR}/libAdafruit_ILI9341.cmake)
include(${ARDUINO_CMAKE_DIR}/libILI9341_due.cmake)


#
# Project source files
#
file(GLOB_RECURSE SOURCES "src/*.c*")


#
# Target creation
#
add_executable(${PROJECT_NAME}.elf ${SOURCES} ${LINKER_SCRIPT_DIR}/${LINKER_SCRIPT}
               ${ARDUINO_MAIN_SOURCE} ${ARDUINO_HANDLER_SOURCE} ${ARDUINO_STARTUP_SOURCE})

target_link_libraries(${PROJECT_NAME}.elf ILI9341_due)
target_link_libraries(${PROJECT_NAME}.elf Adafruit_ILI9341)
target_link_libraries(${PROJECT_NAME}.elf Adafruit_GFX)
target_link_libraries(${PROJECT_NAME}.elf Adafruit_BusIO)
target_link_libraries(${PROJECT_NAME}.elf ArduinoLib)
target_link_libraries(${PROJECT_NAME}.elf ArduinoSyscalls)
target_link_libraries(${PROJECT_NAME}.elf ${ARDUINO_LIB_PLATFORM})

buildAsFlashImage(${PROJECT_NAME}.elf)
generateHexFiles(${PROJECT_NAME}.elf)

