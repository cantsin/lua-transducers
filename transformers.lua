
-- a transformer protocol must have:
--   init (no arity)
--   step (two arity)
--   complete (one arity)

local append = (function()
  return {
    init = {},
    step = function(tbl, result)
      table.insert(tbl, result)
      return tbl
    end,
    complete = function(result) return result end
  }
end)()

local concat = (function()
  return {
    init = '',
    step = function(str, ch)
      str = str .. ch
      return str
    end,
    complete = function(result) return result end
  }
end)()

local sum = (function()
  local accum = 0
  return {
    init = function() return 0 end,
    step = function(tbl, result)
      accum = accum + result
      return tbl
    end,
    complete = function(result) return accum end
  }
end)()

local mult = (function()
  local accum = 1
  return {
    init = function() return 0 end,
    step = function(tbl, result)
      accum = accum * result
      return tbl
    end,
    complete = function(result) return accum end
  }
end)()

return {
  sum = sum,
  mult = mult,
  concat = concat,
  append = append,
}
