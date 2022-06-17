function(doNotBuildForHost target)
  if(DEFINED ARDUINO_BUILD_FOR_HOST)
    set_target_properties(${target} PROPERTIES EXCLUDE_FROM_ALL True)
  endif()
endfunction()

function(buildOnlyForHost target)
  if(NOT DEFINED ARDUINO_BUILD_FOR_HOST)
    set_target_properties(${target} PROPERTIES EXCLUDE_FROM_ALL True)
  endif()
endfunction()

function(buildAsFlashImage target)
  set_target_properties(${target} PROPERTIES SUFFIX ".elf")
  target_sources(${target} PRIVATE ${ARDUINO_STARTUP_SOURCE})

  setOptionsForFlashImage(${target})
  doNotBuildForHost(${target})
endfunction()
