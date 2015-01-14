
local f = require 'functional'

-- formalize, a la http://clojure.org/transducers

function wrap(xf)
  return {
    init = function() error("no init function.") end,
    step = xf or error("no step function."),
    complete = function(result) return result end
  }
end

function map(f)
  return function(xf)
    return {
      init = xf.init,
      step = function(result, item)
        local mapped = f(item)
        return xf.step(result, mapped)
      end,
      complete = xf.complete
    }
  end
end

function iter(l)
  return coroutine.wrap(function()
      for i=1,#l do
        coroutine.yield(l[i])
      end
  end)
end

function reduce(xf, init, input)
  local result = f.reduce(xf.step, input, init)
  return xf.complete(result)
end

function transduce(transform, f, init, seq)
  if type(f) == 'function' then
    f = wrap(f)
  end
  local xf = transform(f)
  return reduce(xf, init, seq)
end

return {
  transduce = transduce
}
