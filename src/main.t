package.terrapath = package.terrapath .. "src/?.t"

require "c"
require "renderer"
require "state"

terra main()
  var renderer = Renderer {}
  var state = State.new()
  glfw.glfwInit();
  var window = glfw.glfwCreateWindow(800, 600, "Hello", nil, nil)
  glfw.glfwMakeContextCurrent(window)
  while(not [bool](glfw.glfwWindowShouldClose(window))) do
    glfw.glClear(glfw.GL_COLOR_BUFFER_BIT)
    renderer:render(&state)
    glfw.glfwPollEvents();
    glfw.glfwSwapBuffers(window);
  end
  return 0;
end

-- Get glfw linker flags
local handle = io.popen("pkg-config --libs --static dep/glfw/build/src/glfw3.pc")
local res = handle:read("*a")
handle:close()

-- Create args for clang
args = {"-Llib", "-Idep/glfw/include", "-framework", "OpenGL"}
for word in res:gmatch("%S+") do table.insert(args, word) end

-- Create the executable
terralib.saveobj("bin/main", {main=main}, args)
