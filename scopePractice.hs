let x = 2 in
let y = 3 in
-- foo = Int -> Int+5
let foo = (\z -> x + y + z) in
-- Static foo is same, dynamic foo becomes Int -> Int+7
let x = 4 in
-- Static result = 15, dynamic result = 17
let result = foo 10 in
-- Static result = 15, dynamic result = 17
-- result is an integer, not a function, so it is unchanged
let y = 5 in
result

-- (a) What is the result of evaluating this expression (i.e. what is the value of result if the semantics implements static scoping?
-- 15 

-- (b) What is the result of evaluating this expression (i.e. what is the value of result if the semantics implements dynamic scoping?
-- 17

let x = 3 in
let y = 4 in
-- foo = Int -> Int+7
let foo = (\z -> x + y + z) in
-- Static foo is same, dynamic foo becomes Int -> Int+7
let x = 5 in
-- Static result = 17, dynamic result = 19
let result = foo 10 in
-- Static result = 17, dynamic result = 19
let y = 6 in
result


-- | This function doesn’t terminate.
loop :: Int -> Int

-- | This function takes one minute to return a value.
slow :: Int -> Int

-- | This is the function you have to think about.
go :: Bool -> Int -> Int -> Int
go b x y = if b then x else y + y + y

-- Consider the evaluation of each expression using each of the following three parameter passing schemes: call-by-value, call-by-name, and call-by-need. 
-- For each parameter passing scheme, write an ‘X’ if the evaluation does not terminate (because the loop function is evaluated). 
-- If the evaluation does terminate, write the number of minutes you would wait for a response. Thus, the answer for each parameter passing scheme should be an integer or ‘X’.


-- (a) go True (slow 2) (slow 3)

-- Since call by value evaluates values before passing them, it evaluate slow 2 and slow 3 before executing. Since slow takes 1 minute to to finish, the total time is 2 mins
-- i. call-by-value: 2

-- Call by name evaluates values if they are used. Since b is true, x is evaluated by slow, but not y
-- ii. call-by-name: 1
-- iii. call-by-need: 1


-- (b) go False (slow 2) (slow 3)

-- i. call-by-value: 2

-- Call by name evaluates values if they are used, and each time they are used. Since y is referenced 3 times, slow is called 3 times
-- ii. call-by-name: 3

-- Call by need caches previous evaluations of values, so slow only needs to be called once
-- iii. call-by-need: 1


-- (c) go True (loop 2) (slow 3)

-- This function doesn't terminate since loop has to be finished for the execution to proceed for call by name
-- i. call-by-value: X

-- These functions doesn't terminate, since loop is called in both cases inside the go function since True is passed in
-- ii. call-by-name: X
-- iii. call-by-need: X


-- (d) go False (loop 2) (slow 3)

-- i. call-by-value: X
-- ii. call-by-name: 3
-- iii. call-by-need: 1