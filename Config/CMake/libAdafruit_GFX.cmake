#
# Adafruit_GFX
#
add_library(Adafruit_GFX STATIC IMPORTED)
set_target_properties(Adafruit_GFX PROPERTIES IMPORTED_LOCATION ${ARDUINO_LIBS}/Adafruit_GFX/out.${ARDUINO_LIBS_BUILD}/libAdafruit_GFX.a)
include_directories(${ARDUINO_LIBS}/Adafruit_GFX/include)

