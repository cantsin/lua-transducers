
-- use underscore.lua for this?
-- http://lua-users.org/wiki/CurriedLua

function map(func)
  return function(array)
    local new_array = {}
    for i,v in ipairs(array) do
      new_array[i] = func(v)
    end
    return new_array
  end
end

function iter(l)
  return coroutine.wrap(function()
      for i=1,#l do
        coroutine.yield(l[i])
      end
  end)
end

function reduce(l, accum, func)
  for i in iter(l) do
    accum = func(accum, i)
  end
  return accum
end

function transduce(transform, f, init, seq)
  local reducer = function(accum, i)
    return transform(seq, f(accum, i))
  end
  return reduce(seq, init, reducer)
end

return {
  map=map,
  transduce=transduce
}
