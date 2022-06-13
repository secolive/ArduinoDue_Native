#
# Paths to various resources
#
set(ARDUINO_DEVROOT "${CMAKE_CURRENT_LIST_DIR}/../..")
set(ARDUINO_CORE_SRC ${ARDUINO_DEVROOT}/ArduinoCore-sam)
set(ARDUINO_LIBS ${ARDUINO_DEVROOT}/Libs)
set(ARDUINO_CMAKE_DIR ${ARDUINO_DEVROOT}/Config/CMake)
set(ARDUINO_TOOLCHAIN_DIR ${ARDUINO_DEVROOT}/Toolchain)
set(ARDUINO_MAIN_SOURCE ${ARDUINO_CORE_SRC}/cores/arduino/main.cpp)
set(ARDUINO_HANDLER_SOURCE ${ARDUINO_CORE_SRC}/cores/arduino/cortex_handlers.c)


#
# Toolchain setup
#
set(CMAKE_SYSTEM_NAME LINUX)
set(CMAKE_SYSTEM_VERSION 1)
