local List = require("asdl").List
require "c"

function Vec(comp_type)
  local Vec = terralib.types.newstruct()
  Vec.metamethods.__getentries = function(self)
    return List{{"data", &comp_type}}
  end
  return Vec
end

Vec = terralib.memoize(Vec)
