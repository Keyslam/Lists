

local Set = {}


--- Creates a new Set.
-- @return A new list
function Set.new()
   return setmetatable({
      objects  = {},
      pointers = {},
      size     = 0,
   }, Set)
end

--- Clears the Set completely.
-- @return self
function Set:clear()
   self.objects  = {}
   self.pointers = {}
   self.size     = 0

   return self
end

--- Adds an object to the Set.
-- @param obj The object to add
-- @return self
function Set:add(obj)
   if self:has(obj) then
      return self
   end

   local size = self.size + 1

   self.objects[size] = obj
   self.pointers[obj] = size
   self.size          = size

   return self
end

--- Removes an object from the Set. If the object isn't in the Set, returns nil.
-- @param obj The object to remove
-- @param index The known index
-- @return self
function Set:remove(obj, index)

   if not self.pointers[obj] then
      return nil
   end

   index = index or self.pointers[obj]
   local size  = self.size

   if index == size then
      self.objects[size] = nil
   else
      local other = self.objects[size]

      self.objects[index]  = other
      self.pointers[other] = index

      self.objects[size] = nil
   end

   self.pointers[obj] = nil
   self.size = size - 1

   return self
end

--- Gets an object by numerical index.
-- @param index The index to look at
-- @return The object at the index
function Set:get(index)
   return self.objects[index]
end

--- Gets if the Set has the object.
-- @param obj The object to search for
-- @param true if the list has the object, false otherwise
function Set:has(obj)
   return self.pointers[obj] and true
end


--- Gets a table of the Set's objects
-- @return table
function Set:getObjects()
   return self.objects
end


--- Returns a memory-unique copy of another Set
-- @return copied Set
function Set:copy()
   local new = Set()
   for i=1,self.size do
      new:add(self.objects[i])
   end
   return new
end



--- Returns a new Set that is the intersection of two sets.
-- @param other Another Set that an intersection will be made with
-- @return an intersection Set
function Set:intersection(other)
   local new = Set()

   for i=1,other.size do
      local each = other.objects[i]
      if self:has(each) then
         new:add(each)
      end
   end
   return new
end


--- Returns a new Set that is the union of two sets. (Combined elements)
-- @param other Another Set that the union will be made with
-- @return a union Set
function Set:union(other)
   local new = Set()
   for i=1, other.size do
      new:add(other.objects[i])
   end
   for i=1, self.size do
      new:add(self.objects[i])
   end
   return new
end


--- Returns a new Set that includes all elements of original, except those found in other Set.
-- @param other The Set that includes the elements to be excluded.
-- @return a Set including elements in Set 1, but NOT in Set 2.
function Set:complement(other)
   local new = self:copy()

   for i=1, other.size do
      new:remove(other.objects[i])
   end
   return new
end


--- Returns a new Set that includes all elements that are unique to either Set.
-- @param other The Set other
-- @return Set The Set of all unique elements of both sets
function Set:difference(other)
   return self:complement(other):union(other:complement(self))
end



Set.__index = Set

Set.__call = function(set_)
   return set_.objects
end

Set.__add = Set.union

Set.__sub = Set.complement

Set.__mul = Set.intersection

Set.__div = Set.difference

Set.__concat = Set.union


return setmetatable(Set, {
   __call = function(_) return Set.new() end,
})

