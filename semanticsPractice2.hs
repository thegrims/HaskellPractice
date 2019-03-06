type Hour = Int
type Minutes = Int

data Time = Midnight
          | Noon
          | AM Hour
          | PM Hour
          | Before Minutes Time  
          | After Minutes Time

time :: Time -> Int
time Midnight = 0
time Noon = 60 * 12
time (AM h) = 60 * h
time (PM h) = 60 * (h + 12)
time (Before m t) = (time t) - m
time (After m t) = (time t) + m