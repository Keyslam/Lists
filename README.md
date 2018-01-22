# Lists
An adaption of tables that allowes for quick removal

Usage:

```lua
-- Creation
local List = require("list")
local myList = List.new()

-- Adding objects
local a = {name = "obj_a"}
local b = {name = "obj_b"}
local c = {name = "obj_c"}

myList:add(a) -- Adds object 'a' to the list
myList:add(b)
myList:add(c)

-- Iteration
for i = 1, list.size do -- 'list.size' holds the length of the list
   local obj = list:get(i)
   print(obj.name) --[[
                       obj_a
                       obj_b
                       obj_c
                     ]]
end

-- Removal
myList:remove(a) -- Removes object 'a' from the list
myList:remove(c)

-- Clearing
myList:clear() -- Clears the list of all objects

-- Getting
myList:get(index) -- Gets objects at index 'index'
myList:getIndex(obj) -- Gets the index of object 'obj'
```
