



local SSet = {}


--- Creates a new SSet.
-- @return A new list
function SSet.new()
   return setmetatable({
      objects  = {},
      pointers = {},
      size     = 0,
   }, SSet)
end

--- Clears the SSet completely.
-- @return self
function SSet:clear()
   self.objects  = {}
   self.pointers = {}
   self.size     = 0

   return self
end

--- Adds an object to the SSet.
-- @param obj The object to add
-- @return self
function SSet:add(obj)
   if self:has(obj) then
      return self
   end

   local size = self.size + 1

   self.objects[size] = obj
   self.pointers[obj] = size
   self.size          = size

   return self
end

--- Removes an object from the SSet. If the object isn't in the SSet, returns nil.
-- @param obj The object to remove
-- @param index The known index
-- @return self
function SSet:remove(obj, index)

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
function SSet:get(index)
   return self.objects[index]
end

--- Gets if the SSet has the object.
-- @param obj The object to search for
-- @param true if the list has the object, false otherwise
function SSet:has(obj)
   return self.pointers[obj] and true
end


--- Gets a table of the SSet's objects
-- @return table
function SSet:getObjects()
   return self.objects
end






--[[

Advanced functions here.


If you don't care about the advanced functions and are only here for the O(1)
removal, feel free to delete the below code.

Make sure you keep t

]]

do
      --- Returns a memory-unique copy of another SSet
      -- @param out A set for values to be pushed to. <optional>
      -- @return copied SSet
      function SSet:copy(out)
         local new
         if out then
            new = out:clear()
         else
            new = SSet()
         end
         for i=1,self.size do
            new:add(self.objects[i])
         end
         return new
      end



      --- Returns a new SSet that is the intersection of two sets.
      -- @param other Another SSet that an intersection will be made with
      -- @param out A set for values to be pushed to. <optional>
      -- @return an intersection SSet
      function SSet:intersection(other, out)
         local new
         if out then
            new = out:clear()
         else
            new = SSet()
         end

         for i=1,other.size do
            local each = other.objects[i]
            if self:has(each) then
               new:add(each)
            end
         end
         return new
      end


      --- Returns a new SSet that is the union of two sets. (Combined elements)
      -- @param other Another SSet that the union will be made with
      -- @param out A set for values to be pushed to. <optional>
      -- @return a union SSet
      function SSet:union(other, out)
         local new
         if out then
            new = out:clear()
         else
            new = SSet()
         end

         for i=1, other.size do
            new:add(other.objects[i])
         end
         for i=1, self.size do
            new:add(self.objects[i])
         end
         return new
      end



      --- Returns a new SSet that includes all elements of original, except those found in other SSet.
      -- @param other The SSet that includes the elements to be excluded.
      -- @param out Output set that objects are pushed to <optional>
      -- @return a SSet including elements in SSet 1, but NOT in SSet 2.
      function SSet:complement(other, out)
         local new
         if out then
            new = self:copy(out)
         else
            new = self:copy()
         end

         for i=1, other.size do
            new:remove(other.objects[i])
         end
         return new
      end


      --- Returns a new SSet that includes all elements that are unique to either SSet.
      -- @param other The SSet other
      -- @param out A set for values to be pushed to. <optional>
      -- @return SSet The SSet of all unique elements of both sets
      function SSet:difference(other, out)
         local new
         if out then
            new = out:clear()
         else
            new = SSet()
         end

         for _, obj in ipairs(self.objects) do
            if not other.pointers[obj] then
               -- `other` set does not have object! Go ahead
               new:add(obj)
            end
         end
         for _, obj in ipairs(other.objects) do
            if not self.pointers[obj] then
               -- `self` set does not have object! Go ahead
               new:add(obj)
            end
         end

         return new
      end



      SSet.__add = SSet.union

      SSet.__sub = SSet.complement

      SSet.__mul = SSet.intersection

      SSet.__mod = SSet.difference

      SSet.__concat = SSet.union
end


--[[




End of advanced functions.

The above block can be deleted if user does not need advanced functions



]]







SSet.__newindex = function(t, _, v)
   t:add(v)
end


SSet.__index = SSet


SSet.__metatable = "Defended, sorry!"


return setmetatable(SSet, {
   __call = function(_) return SSet.new() end,
})


