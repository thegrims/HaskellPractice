module TypesPractice where

data Result = OK Int | Error
  deriving (Eq,Show)

isOK :: Result -> Bool
isOK (OK _) = True
isOK Error  = False

add :: Int -> Result -> Result
add i (OK j) = OK (i+j)
add _ Error  = Error

-- From the Prelude:
--   map :: (a -> b) -> [a] -> [b]
--   (.) :: (b -> c) -> (a -> b) -> a -> c

-- Write the type of the following expressions,
-- or write "type error" if it is not type correct:

-- Type is OK data structure (Int -> result)
ex1 = OK

-- Type is Result
ex2 = Error

-- Type is Bool, result processed by result -> bool function
ex3 = isOK Error

-- Creates an error, Int type is not type result, cannot be processed by result -> bool function
-- ex4 = isOK 3

-- since there are no parenthesis around OK and 3, isOK is called against OK, which is of int -> result type rather than result type. This creates an error as the input is incorrect
-- ex5 = isOK OK 3

-- Dot operator is like a pipe in haskell, except unlike pipes in bash, piping is done in reverse order. In this case, the OK result of the ok function call is piped into the isOK function.
-- This returns int -> bool, because the OK data structure is int -> result, and the isOk function is result -> bool. Therefore the combination is int -> bool
ex6 = isOK . OK

-- Since the function is only taking 1 value it returns, returns result -> result
ex7 = add 3

-- This pattern matches with Error because the two inputs to the function were the int and result type error. Therefore, the return type is result
ex8 = add 3 Error

-- Type of OK is int -> result, which does not match with any of the function input types, since add is int -> result -> result. This causes an error
-- ex9 = add 3 OK

-- Type of OK is int -> result. Ok function takes 4 and returns result. This correctly matches with the add arguments, returns result
ex10 = add 3 (OK 4)

-- Type of Ok is int -> result. This returns a map function wrapped around the OK function. This results the result of list of ints to list of results, [int] -> [result]
ex11 = map OK

-- Type of isOk is result -> bool. The map function wrapped around the ok function returns [result] -> [bool]
ex12 = map isOK

-- Type of add 3 is result -> result, so the map function wraps around this, returning [result] -> [result]
ex13 = map (add 3)

-- ex16 = (add 3 . OK)
-- Type of Ok is int -> result, which is piped into the add command, which takes an int and a result and returns a result. the result is an int -> result. 
-- This is then wrapped in the mapping function to make it [int] -> [result]
ex14 = map (add 3 . OK)

-- Add 3 is executed first since it is in parenthesis. This returns result -> result, since there is no 2nd argument. This is then wrapped with map, which returns a type of [result] -> [result]
-- Map ok returns an [int] -> [result]. 
-- The dot operator pipes the map ok result to the add 3 mapped result. ([int] -> [result]) -> ([result] -> [result]) = [int] -> [result]
ex15 = map (add 3) . map OK
