#!/usr/bin/env stack
-- stack --resolver lts-11.10 --install-ghc runghc
import Text.Read (readMaybe)
import Control.Applicative ((<$>), (<*>))

displayAge maybeAge =
    case maybeAge of
        Nothing -> putStrLn "You provided invalid input"
        Just age -> putStrLn $ "In that year, you will be: " ++ show age

yearDiff futureYear birthYear
      | futureYear > birthYear = futureYear - birthYear
      | otherwise = birthYear - futureYear

-- main =
--   | yearDiff 5 6 == 1 = putStrLn "Correct!"
--   | otherwise = putStrLn "Please try again"

main = do
  putStrLn "Please enter your birth year"
  birthYearString <- getLine
  putStrLn "Please enter some year in the future"
  futureYearString <- getLine
  let maybeAge = 
          yearDiff <$> readMaybe futureYearString
                   <*> readMaybe birthYearString
  displayAge maybeAge