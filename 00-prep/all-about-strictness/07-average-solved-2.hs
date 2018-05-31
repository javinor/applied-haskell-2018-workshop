#!/usr/bin/env stack
-- stack --resolver lts-11.10 --install-ghc runghc
{-# LANGUAGE BangPatterns #-}

data RunningTotal = RunningTotal
  { sum :: Int
  , count :: Int
  }

printAverage :: RunningTotal -> IO ()
printAverage (RunningTotal sum count)
  | count == 0 = error "Need at least one value!"
  | otherwise = print (fromIntegral sum / fromIntegral count :: Double)

-- | A fold would be nicer... we'll see that later
printListAverage :: [Int] -> IO ()
printListAverage =
  go (RunningTotal 0 0)
  where
    go rt [] = printAverage rt
    go (RunningTotal sum count) (x:xs) =
      let !sum' = sum + x
          !count' = count + 1
          rt = RunningTotal sum' count'
      in go rt xs

main :: IO ()
main = printListAverage [1..1000000]