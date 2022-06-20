#
# Fundamentals
#
set(ARDUINO_PLATFORM due)
set(ARDUINO_VARIANT arduino_due_x)


#
# Paths to various resources
#
include(${CMAKE_CURRENT_LIST_DIR}/arduino-base.cmake)
include(${ARDUINO_CMAKE_DIR}/arduino-project-structure.cmake)
include(${ARDUINO_CMAKE_DIR}/arduino-outputs.cmake)

include(${CMAKE_CURRENT_LIST_DIR}/arduino-sam-specific.cmake)


#
# Toolchain setup
#
if(NOT DEFINED ARDUINO_BUILD_FOR_HOST)
  include(${ARDUINO_CMAKE_DIR}/toolchain-arm-gcc_atmel-6.3.1.cmake)
  include(${ARDUINO_CMAKE_DIR}/build-gcc-base-options.cmake)
  include(${ARDUINO_CMAKE_DIR}/build-gcc-sam3x8e.cmake)
endif()
include(${ARDUINO_CMAKE_DIR}/build-gcc-flash.cmake)


#
# Platform-specific arguments and definitions
#
add_definitions(-D__SAM3X8E__ -DF_CPU=84000000L -DARDUINO=108019 -DARDUINO_SAM_DUE -DARDUINO_ARCH_SAM
    -DUSB_VID=0x2341 -DUSB_PID=0x003e "-DUSB_PRODUCT=\"Arduino Due\"" "-DUSB_MANUFACTURER=\"Arduino LLC\"" -DUSBCON)

include(${ARDUINO_CMAKE_DIR}/build-due-libSam.cmake)
