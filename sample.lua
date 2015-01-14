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

local function plus1(n) return n + 1 end

local transducer = compose(map(plus1), map(plus1), map(plus1), map(plus1))
local result = transduce(transducer, push, {}, arr)
for i=1,#result do
  print(result[i])
end
-- {5,6,7,8}
