require "ecs/index"

struct State {
  ecs: ECS }

State.methods.new = terra()
  return State {
    ecs = ECS.new()
  };
end
