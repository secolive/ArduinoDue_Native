function(buildAsFlashImage target)
  set_target_properties(${target} PROPERTIES SUFFIX ".elf")
  setOptionsForFlashImage(${target})
endfunction()

