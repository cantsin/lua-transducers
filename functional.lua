-- generic FP functions.

local function compose(...)
  local fns = {...}
  local n = #fns
  return function(...)
    local state = table.pack(...)
    -- right-to-left
    local index = n
    while index > 0 do
      state = { fns[index](unpack(state)) }
      index = index - 1
    end
    return unpack(state)
  end
end

local function iter(l)
  return coroutine.wrap(function()
      for i=1,#l do
        coroutine.yield(l[i])
      end
  end)
end

local function reduce(func, l, accum)
  for i in iter(l) do
    accum = func(accum, i)
  end
  return accum
end

return {
  compose = compose,
  reduce = reduce,
  iter = iter
}
