function(buildAsFlashImage target)
  set_target_properties(${target} PROPERTIES SUFFIX ".elf")
  target_sources(${target} PRIVATE ${ARDUINO_STARTUP_SOURCE})

  setOptionsForFlashImage(${target})
endfunction()

