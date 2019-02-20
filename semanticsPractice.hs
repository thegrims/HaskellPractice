
module SemanticsPractice where
    -- i ::= (any integer)
-- s ::= inc i
--    |  reset
-- p ::= s ; p
--    |  ε

-- type I = Int

-- type P = [S]

-- data S = Inc I
--     |   Reset
--     deriving(Eq,Show)

-- s :: S -> I -> I
-- s (Inc int) int2 = (int + int2)
-- s (Reset) _ = 0


-- p :: P -> I -> I
-- p [] n2 = 0
-- p ((Inc n):cs) n2 = (p cs n2) + (s (Inc n) n2) 
-- p ((Reset):cs) n2 = (p cs n2) + (s Reset n2)





data Cmd = Gas | Brake | Turn
        deriving (Eq, Show)

type Prog = [Cmd]

type Pos   = Int
type Speed = Int
data Dir   = Forward | Backward
        deriving (Eq, Show)

data Robot = Crashed Pos
        | OK Pos Speed Dir
        deriving (Eq, Show)


cmd :: Cmd -> Robot -> Robot
cmd Gas (OK pos speed Forward) = OK (speed+pos) (speed+1) Forward
cmd Gas (OK pos speed Backward) = OK (pos-speed) (speed+1) Backward
cmd Brake (OK pos speed Forward) = OK (pos+speed) (speed-1) Forward
cmd Brake (OK pos speed Backward) = OK (pos-speed) (speed-1) Forward
cmd Turn (OK pos 0 Forward) = OK pos 0 Backward
cmd Turn (OK pos 0 Backward) = OK pos 0 Forward
cmd Turn (OK pos _ _) = Crashed pos
cmd _ (Crashed pos) = Crashed pos

prog :: Prog -> Robot -> Robot
prog [] robot = robot 
prog (c:cs) robot = prog cs (cmd c robot)

-- | Semantics of programs.
--
--   >>> prog [Gas, Gas, Gas, Brake] (0 0 Forward)
--   OK 6 2 Forward
--
--   >>> prog [Gas, Brake, Gas, Brake] (0 0 Backward)
--   OK -2 0 Backward
--
--   >>> prog [Gas, Gas, Brake, Turn, Gas, Gas] (0 0 Forward)
--   Crashed 3
--
--   >>> prog [Gas, Gas, Brake, Turn] (0 0 Forward)
--   Crashed 3
--
--   >>> prog [Gas, Gas, Brake, Brake, Turn, Gas, Gas] (0 0 Forward)
--   OK 3 2 Backward