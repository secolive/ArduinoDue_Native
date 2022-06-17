#
# Adafruit_BusIO
#
add_library(Adafruit_BusIO STATIC IMPORTED)
set_target_properties(Adafruit_BusIO PROPERTIES IMPORTED_LOCATION ${ARDUINO_LIBS}/Adafruit_BusIO/${ARDUINO_LIB_SUBDIR}/libAdafruit_BusIO.a)
include_directories(${ARDUINO_LIBS}/Adafruit_BusIO/include)

