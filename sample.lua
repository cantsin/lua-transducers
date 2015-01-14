
local t = require 'transducers'
local f = require 'functional'
local tr = require 'transformers'
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
-- { 4, 6 }

local transducer = f.compose(t.remove(odd), t.map(plus1), t.map(plus1), t.map(plus1))
local result = t.transduce(transducer, push, {}, arr)
print('demonstrating response.', inspect(result))
-- { 5, 7 }

local transducer = f.compose(t.remove(odd), t.map(plus1), t.map(plus1), t.map(plus1))
local result = t.transduce(transducer, tr.sum, {}, arr)
print('demonstrating transformation and then reduction with sum.', inspect(result))
-- 12

local transducer = f.compose(t.remove(odd), t.map(plus1), t.map(plus1), t.map(plus1))
local result = t.transduce(transducer, tr.mult, {}, arr)
print('demonstrating transformation and then reduction with mult.', inspect(result))
-- 35

local transducer = t.map(plus1)
local result = t.transduce(transducer, tr.append, {}, arr)
print('demonstrating that push is equivalent to the append transformer.', inspect(result))
-- { 2, 3, 4, 5 }

local transducer = f.compose(t.drop(2), t.map(plus1))
local result = t.transduce(transducer, tr.append, {}, arr)
print('demonstrating drop.', inspect(result))
-- { 4, 5 }

local transducer = f.compose(t.take(2), t.map(plus1))
local result = t.transduce(transducer, tr.append, {}, arr)
print('demonstrating take.', inspect(result))
-- { 2, 3 }

local transducer = f.compose(t.drop(1), t.take(2), t.drop(1))
local result = t.transduce(transducer, tr.append, {}, arr)
print('demonstrating composition of take and drop.', inspect(result))
-- { 3 }

local transducer = f.compose(t.map(plus1), t.filter(odd))
local result = t.into(transducer, {}, arr)
print('demonstrating into.', inspect(result))
-- { 3, 5 }
