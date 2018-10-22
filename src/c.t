C = terralib.includecstring [[
  #include <stdio.h>
  #include <stdlib.h>
  #include <stdlib.h>
]]

glfw = terralib.includecstring ([[
#include <GLFW/glfw3.h>
]], {"-Idep/glfw/include"})

