# Sets
An adaption of tables that allowes for quick removal.

Note that sets cannot have duplicate objects.


Usage:

```lua
local Set = require("set")


-- Creation
local mySet = Set.new()   -- or simply Set()


-- Adding objects
mySet:add("a") -- Adds object 'a' to the list.
mySet:add("b")
mySet:add("c")
mySet:add( {"hello"} )


-- Iteration
for i = 1, mySet.size do -- 'set.size' holds the length of the set
   local obj = mySet:get(i)
   print(obj) --[[
           'a'
           'b'
           'c'
           {"hello"}
   ]]
end


-- Removal
mySet:remove(a) -- Removes object 'a' from the set


-- Getting
local o = mySet:get(1) -- Gets objects at index 1


-- Checking
mySet:has(o) -- returns true


-- Clearing
mySet:clear() -- Clears the set of all objects


-- Copying
local copySet = mySet:copy()
```


# Advanced Set operations (optional)
Includes operations common in math set theory
```lua

local set_1 = Set()
:add('a')           -- set_1 ->  set{"a", "b"}
:add('b')  
-- Method chaining

local set_2 = Set()
:add('b')           -- set_2 ->  set{"b", "c"}
:add('c')


-- Set union:
local union = set_1:union(set_2)
-- or:
local union = set_1 + set_2
--[[
union ->
set{"a", "b", "c"}
]]


-- Set intersections:
-- returns a set with all elements that are in both sets.
local intersect = set_1:intersection(set_2)
-- or:
local intersect = set_1 * set_2
--[[
intersect ->
set{"b"}
]]


-- Set difference 
-- (returns set w/ all elements unique to either set)
local dif = set_1:difference(set_2)
-- or:
local dif = set_1 % set_2
--[[
dif ->
set{"a", "c"}
]]


-- Set complement
-- (returns a set with all items in set_1, but not set_2)
-- Note that this operation is non-commutative.
local compl = set_1:complement(set_2)
-- or:
local compl = set_1 - set_2
--[[
compl ->
set{"a"}
]]


```
