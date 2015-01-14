-- generic FP functions.

local function compose(...)
  local fns = {...}
  local n = #fns
  return function(...)
    local state = table.pack(...)
    -- left-to-right
    for index = 1,n do
      state = { fns[index](unpack(state)) }
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

-- allow indexing into strings
getmetatable('').__index = function(str,i)
  if type(i) == 'number' then
    return string.sub(str,i,i)
  else
    return string[i]
  end
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
