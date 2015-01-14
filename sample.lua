
local t = require 'transducers'
local f = require 'functional'
local inspect = require 'inspect'

local function plus1(n)
  return n + 1
end

local function odd(n)
  return n % 2 == 0
end

local function push(tbl, index)
  table.insert(tbl, index)
  return tbl
end

local arr = {1,2,3,4}

-- demonstrating transduce.
local transducer = t.map(plus1)
local result = t.transduce(transducer, push, {}, arr)
print(inspect(result))
-- { 2, 3, 4, 5 }

-- demonstrating compose.
local transducer = f.compose(t.map(plus1), t.map(plus1), t.map(plus1), t.map(plus1))
local result = t.transduce(transducer, push, {}, arr)
print(inspect(result))
-- { 5, 6, 7, 8 }

-- demonstrating filter.
local transducer = f.compose(t.filter(odd), t.map(plus1), t.map(plus1), t.map(plus1))
local result = t.transduce(transducer, push, {}, arr)
print(inspect(result))
-- { 5, 7 }
