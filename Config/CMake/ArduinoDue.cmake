#
# Paths to various resources
#
include(${CMAKE_CURRENT_LIST_DIR}/arduino-base.cmake)


#
# Toolchain setup
#
include(${ARDUINO_CMAKE_DIR}/toolchain-arm-gcc_atmel-6.3.1.cmake)
include(${ARDUINO_CMAKE_DIR}/build-base-options.cmake)
include(${ARDUINO_CMAKE_DIR}/build-project-structure.cmake)


#
# Platform-specific arguments and definitions
#
set(ARDUINO_VARIANT arduino_due_x)
add_definitions(-D__SAM3X8E__ -DF_CPU=84000000L -DARDUINO=108019 -DARDUINO_SAM_DUE -DARDUINO_ARCH_SAM
    -DUSB_VID=0x2341 -DUSB_PID=0x003e "-DUSB_PRODUCT=\"Arduino Due\"" "-DUSB_MANUFACTURER=\"Arduino LLC\"" -DUSBCON)

add_link_options(--specs=nano.specs --specs=nosys.specs)
include(${ARDUINO_CMAKE_DIR}/sam3x8e.cmake)
include(${ARDUINO_CMAKE_DIR}/libSam.cmake)
