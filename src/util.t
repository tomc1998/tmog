require "c"

-- Exit program with error if expr == false
terra assert(expr : bool, err : &uint8)
  if expr == false then
    --C.printf("Assertion error, expr false: %s\n", err);
    --C.exit(1)
  end
end

return { assert = assert }
