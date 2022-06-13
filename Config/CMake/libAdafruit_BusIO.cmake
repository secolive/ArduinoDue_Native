#
# Adafruit_BusIO
#
add_library(Adafruit_BusIO STATIC IMPORTED)
set_target_properties(Adafruit_BusIO PROPERTIES IMPORTED_LOCATION ${ARDUINO_LIBS}/Adafruit_BusIO/out.${ARDUINO_LIBS_BUILD}/libAdafruit_BusIO.a)
include_directories(${ARDUINO_LIBS}/Adafruit_BusIO/include)

