require 'transducers'

local function print_arr(seq)
  for i=1,#seq do
    io.write(seq[i], ' ')
  end
  print()
end

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
local transducer = map(plus1)
local result = transduce(transducer, push, {}, arr)
print_arr(result)
-- {2,3,4,5}

-- demonstrating compose.
local transducer = compose(map(plus1), map(plus1), map(plus1), map(plus1))
local result = transduce(transducer, push, {}, arr)
print_arr(result)
-- {5,6,7,8}

-- demonstrating filter.
local transducer = compose(filter(odd), map(plus1), map(plus1), map(plus1))
local result = transduce(transducer, push, {}, arr)
print_arr(result)
-- {5,7}
