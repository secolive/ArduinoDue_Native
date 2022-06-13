#
# ArduinoLib
#
add_library(ArduinoLib STATIC IMPORTED)
set_target_properties(ArduinoLib PROPERTIES IMPORTED_LOCATION ${ARDUINO_LIBS}/ArduinoLib/out.${ARDUINO_LIBS_BUILD}/libArduinoLib.a)
include_directories(${ARDUINO_LIBS}/ArduinoLib/include/core)
include_directories(${ARDUINO_LIBS}/ArduinoLib/include/core/USB)
include_directories(${ARDUINO_LIBS}/ArduinoLib/include/libraries/SPI)
include_directories(${ARDUINO_LIBS}/ArduinoLib/include/libraries/HID)
include_directories(${ARDUINO_LIBS}/ArduinoLib/include/libraries/Wire)

