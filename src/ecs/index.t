local List = require("asdl").List
require "compilation"
require "c"
local assert = require "util".assert

-- Array storage with a fixed size
struct LinBufStorageTypeSpec { size: uint32 }

-- A fixed size non-resizeable linear-search buffer.
STORAGE_TYPE_LINEAR_BUFFER = 0

-- spec : LinBufStorageTypeSpec
function LinBufStorage(CompType, spec)
  local Storage = struct {
    data: &CompType,
    cap: uint32,
    len: uint32,
  }
  Storage.methods.new = terra()
    return {
      data = C.malloc(sizeof(CompType) * [int](spec.size)),
      cap = spec.size, len = 0
    }
  end
  Storage.methods.push = terra(self: &Storage, x: CompType)
    [ if_debug(quote assert (self.len < self.cap, "LinBuf storage overflow") end)]
      self.data[self.len] = x
      self.len = self.len + 1
  end
  Storage.methods.pop = terra(self: &Storage, x: CompType)
    [if_debug(quote assert (self.len > 0, "LinBuf storage empty pop") end)]
      self.len = self.len - 1
      return self.data[self.len]
  end
  Storage.methods.is_empty = terra(self: &Storage) return self.len == 0 end
  return Storage
end

LinBufStorage = terralib.memoize(LinBufStorage)

struct Pos { x: float, y: float }
Pos.Storage = LinBufStorage(Pos, { size = 128 })

struct ECS {pos: Pos.Storage}

ECS.methods.new = terra()
  return ECS {
    pos = Pos.Storage.new()
  }
end
