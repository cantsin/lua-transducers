
local f = require 'functional'

-- canonical uri: http://clojure.org/transducers
--
-- a transformer 'step' is a reducing function:
--   type Reducer a r = r -> a -> r
--   or loosely, r -> a -> r
-- a transducer is a transformation from one reducing function to another:
--   type Transducer a b = forall r . Reducer a r -> Reducer b r
--   or loosely, (r -> a -> r) -> (r -> a -> r)

local function wrap(xf)
  return {
    init = function() error("no init function.") end,
    step = xf or error("no step function."),
    complete = function(result) return result end
  }
end

local function map(f)
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

local function filter(predicate)
  return function(xf)
    return {
      init = xf.init,
      step = function(value, item)
        local allow = predicate(item)
        if allow then
          value = xf.step(value, item)
        end
        return value
      end,
      complete = xf.complete
    }
  end
end

local function remove(predicate)
  local not_ = function(pred)
    return function(x)
      return not pred(x)
    end
  end
  return filter(not_(predicate))
end

local function drop(n)
  return function(xf)
    local left = n
    return {
      init = xf.init,
      step = function(value, item)
        if(left > 0) then
          left = left - 1
        else
          value = xf.step(value, item)
        end
        return value
      end,
      complete = xf.complete
    }
  end
end

local function reduce(xf, init, input)
  local result = f.reduce(xf.step, input, init)
  return xf.complete(result)
end

local function transduce(transducer, f, init, seq)
  local transformer = f
  if type(transformer) == 'function' then
     -- we have a function; convert to a transformer
    transformer = wrap(transformer)
  end
  local xf = transducer(transformer)
  return reduce(xf, init, seq)
end

return {
  map = map,
  drop = drop,
  remove = remove,
  filter = filter,
  reduce = reduce,
  transduce = transduce,
}
