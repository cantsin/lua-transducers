require 'transducers'

local function plus1(n)
  return n + 1
end

local function push(tbl, index)
  table.insert(tbl, index)
  return tbl
end

local arr = {1,2,3,4}

-- demonstrating transduce.
local transducer = map(plus1)
local result = transduce(transducer, push, {}, arr)
for i=1,#result do
  print(result[i])
end
-- {2,3,4,5}

-- demonstrating compose.
local transducer = compose(map(plus1), map(plus1), map(plus1), map(plus1))
local result = transduce(transducer, push, {}, arr)
for i=1,#result do
  print(result[i])
end
-- {5,6,7,8}
