
# Transducers in Lua

[Transducers](http://clojure.org/transducers) are "composable algorithmic transformations." If you don't know yet what transducers are, there are a few good explanations in this [Stack Overflow question](http://stackoverflow.com/questions/26317325/can-someone-explain-clojure-transducers-to-me-in-simple-terms).

This is a fairly straightforward implementation of transducers in Lua, but the implementation is not comprehensive. There are many more transducers and transformers that could be implemented. In addition, I only generalize transducers for tables and strings.

I follow, roughly, the transformer protocol outlined in [transducers-js](https://github.com/cognitect-labs/transducers-js).

To run the examples, simply run `lua sample.lua` -- I used Lua 5.2.3, but any other Lua implementation should work as well.
