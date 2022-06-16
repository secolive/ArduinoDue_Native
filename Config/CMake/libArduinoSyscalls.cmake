#
# ArduinoLib
#
add_library(ArduinoSyscalls STATIC IMPORTED)
set_target_properties(ArduinoSyscalls PROPERTIES IMPORTED_LOCATION ${ARDUINO_LIBS}/ArduinoSyscalls/out.${ARDUINO_LIBS_BUILD}/libArduinoSyscalls.a)

# we need to ensure _sbrk from this specific library is used, hence we undefine the toolchain-provided one
add_link_options("SHELL:-u _sbrk")
