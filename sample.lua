require 'transducers'

local arr = {1,2,3,4}
local push = function(tbl, index)
  table.insert(tbl, index)
  return tbl
end
local result = transduce(map(function(x) return x + 1 end), push, {}, arr)
for i=1,#result do
  print(result[i])
end
-- {2,3,4,5}
