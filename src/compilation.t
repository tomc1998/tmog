DEBUG = true

-- Insert terra code if debug = true
function if_debug(terra_expr)
  if DEBUG then
    return terra_expr
  else
    return quote end
  end
end
