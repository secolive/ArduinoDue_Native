#
# Adafruit_ILI9341
#
add_library(Adafruit_ILI9341 STATIC IMPORTED)
set_target_properties(Adafruit_ILI9341 PROPERTIES IMPORTED_LOCATION ${ARDUINO_LIBS}/Adafruit_ILI9341/out.${ARDUINO_LIBS_BUILD}/libAdafruit_ILI9341.a)
include_directories(${ARDUINO_LIBS}/Adafruit_ILI9341/include)

