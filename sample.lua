
local t = require 'transducers'
local f = require 'functional'
local inspect = require 'inspect'

local function plus1(n)
  return n + 1
end

local function odd(n)
  return n % 2 == 0
end

local function push(tbl, result)
  table.insert(tbl, result)
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

-- demonstrating remove.
local transducer = f.compose(t.remove(odd), t.map(plus1), t.map(plus1), t.map(plus1))
local result = t.transduce(transducer, push, {}, arr)
print(inspect(result))
-- { 4, 6 }

-- demonstrating filter and reduce (via sum transducer).
local transducer = f.compose(t.remove(odd), t.map(plus1), t.map(plus1), t.map(plus1))
local result = t.transduce(transducer, t.sum, {}, arr)
print(inspect(result))
-- 10

-- demonstrating that push is equivalent to the append transducer.
local transducer = t.map(plus1)
local result = t.transduce(transducer, t.append, {}, arr)
print(inspect(result))
-- { 2, 3, 4, 5 }

-- demonstrating drop.
local transducer = f.compose(t.drop(2), t.map(plus1))
local result = t.transduce(transducer, t.append, {}, arr)
print(inspect(result))
-- { 4, 5 }
