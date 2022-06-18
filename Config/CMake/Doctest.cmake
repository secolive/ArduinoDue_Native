#
# Doctest
#
include_directories(${ARDUINO_FRAMEWORKS}/doctest/include)

add_library(DoctestImpl STATIC IMPORTED)
set_target_properties(DoctestImpl PROPERTIES IMPORTED_LOCATION ${ARDUINO_FRAMEWORKS}/doctest/${ARDUINO_LIB_SUBDIR}/libDoctestImpl.a)

set(ARDUINO_DOCTEST_MAIN_SIMPLE ${ARDUINO_FRAMEWORKS}/doctest/src/doctest_main_simple.cc)
set(ARDUINO_DOCTEST_BOOTSRAP_ARDUINO ${ARDUINO_FRAMEWORKS}/doctest/src/doctest_bootstrap_arduino.cc)

function(buildAsDoctest target)
  if(DEFINED ARDUINO_BUILD_FOR_HOST)
    target_sources(${target} PRIVATE ${ARDUINO_DOCTEST_MAIN_SIMPLE})
    target_link_libraries(${target} DoctestImpl)
  else()
    target_sources(${target} PRIVATE ${ARDUINO_MAIN_SOURCE} ${ARDUINO_HANDLER_SOURCE} 
        ${ARDUINO_DOCTEST_BOOTSRAP_ARDUINO})

    target_link_libraries(${target} DoctestImpl)
    target_link_libraries(${target} ArduinoLib)
    target_link_libraries(${target} ArduinoSyscalls)
    target_link_libraries(${target} ${ARDUINO_LIB_PLATFORM})

    buildAsFlashImage(${target})
    generateHexFiles(${target})
  endif()
endfunction()
