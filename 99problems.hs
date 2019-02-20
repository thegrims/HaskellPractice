-- | Find the last element of a list.
--
--   >>> myLast [1,2,3,4]
--   4
--   >>> myLast ['x','y','z']
--  'z'

myLast :: [a] -> Maybe a
myLast [] = Nothing
myLast [current] = Just current
myLast (current:next) = myLast next

-- Prelude> myButLast [1,2,3,4]
-- 3
-- Prelude> myButLast ['a'..'z']
-- 'y'

myButLast :: [a] -> a
myButLast [current,next] = current
myButLast (current:next) = myButLast next

-- Prelude> elementAt [1,2,3] 2
-- 2
-- Prelude> elementAt "haskell" 5
-- 'e'

elementAt :: [a] -> Int -> a
elementAt list i = list !! (i-1)

-- Prelude> myLength [123, 456, 789]
-- 3
-- Prelude> myLength "Hello, world!"
-- 13

myLength :: [a] -> Int
myLength [] = 0 
myLength (current:next) = (myLength next) + 1 

