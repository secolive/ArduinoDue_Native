#
# ArduinoLib
#
add_library(ArduinoSyscalls STATIC IMPORTED)
set_target_properties(ArduinoSyscalls PROPERTIES IMPORTED_LOCATION ${ARDUINO_LIBS}/ArduinoSyscalls/${ARDUINO_LIB_SUBDIR}/libArduinoSyscalls.a)

if(NOT DEFINED ARDUINO_BUILD_FOR_HOST)
# we need to ensure _sbrk from this specific library is used, hence we undefine the toolchain-provided one
add_link_options("SHELL:-u _sbrk")
endif()
