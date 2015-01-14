
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

local transducer = t.map(plus1)
local result = t.transduce(transducer, push, {}, arr)
print('demonstrating transduce.', inspect(result))
-- { 2, 3, 4, 5 }

local transducer = f.compose(t.map(plus1), t.map(plus1), t.map(plus1), t.map(plus1))
local result = t.transduce(transducer, push, {}, arr)
print('demonstrating compose.', inspect(result))
-- { 5, 6, 7, 8 }

local transducer = f.compose(t.filter(odd), t.map(plus1), t.map(plus1), t.map(plus1))
local result = t.transduce(transducer, push, {}, arr)
print('demonstrating filter.', inspect(result))
-- { 5, 7 }

local transducer = f.compose(t.remove(odd), t.map(plus1), t.map(plus1), t.map(plus1))
local result = t.transduce(transducer, push, {}, arr)
print('demonstrating response.', inspect(result))
-- { 4, 6 }

local transducer = f.compose(t.remove(odd), t.map(plus1), t.map(plus1), t.map(plus1))
local result = t.transduce(transducer, t.sum, {}, arr)
print('demonstrating transformation and then reduction.', inspect(result))
-- 10

local transducer = t.map(plus1)
local result = t.transduce(transducer, t.append, {}, arr)
print('demonstrating that push is equivalent to the append transducer.', inspect(result))
-- { 2, 3, 4, 5 }

local transducer = f.compose(t.drop(2), t.map(plus1))
local result = t.transduce(transducer, t.append, {}, arr)
print('demonstrating drop.', inspect(result))
-- { 4, 5 }
