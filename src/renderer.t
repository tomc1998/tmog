require "c"
require "state"

struct Renderer {}

terra setup_proj_mat(w: float, h: float)
  glfw.glMatrixMode(glfw.GL_PROJECTION)
  glfw.glLoadIdentity();
  glfw.glOrtho(0, w, h, 0, -1, 1);
end

Renderer.methods.render = terra(self: &Renderer, state: &State)
  setup_proj_mat(800, 600);
  glfw.glBegin(glfw.GL_QUADS);
  glfw.glVertex2f(  0.0,   0.0);
  glfw.glVertex2f(100.0,   0.0);
  glfw.glVertex2f(100.0, 100.0);
  glfw.glVertex2f(  0.0, 100.0);
  glfw.glEnd()
end
