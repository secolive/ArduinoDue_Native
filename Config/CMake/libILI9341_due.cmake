#
# ILI9341_due
#
add_library(ILI9341_due STATIC IMPORTED)
set_target_properties(ILI9341_due PROPERTIES IMPORTED_LOCATION ${ARDUINO_LIBS}/ILI9341_due/${ARDUINO_LIB_SUBDIR}/libILI9341_due.a)
include_directories(${ARDUINO_LIBS}/ILI9341_due/include)

