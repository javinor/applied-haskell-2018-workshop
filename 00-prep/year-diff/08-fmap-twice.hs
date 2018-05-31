#!/usr/bin/env stack
-- stack --resolver lts-11.10 --install-ghc runghc

import Text.Read (readMaybe)

displayAge maybeAge =
  case maybeAge of
      Nothing -> putStrLn "You provided invalid input"
      Just age -> putStrLn $ "In that year, you will be: " ++ show age

yearDiff futureYear birthYear = futureYear - birthYear

main = do
  putStrLn "Please enter your birth year"
  birthYearString <- getLine
  putStrLn "Please enter some year in the future"
  futureYearString <- getLine
  let maybeAge = do
          yearToAge <- fmap yearDiff (readMaybe futureYearString)
          fmap yearToAge $ readMaybe birthYearString
  displayAge maybeAge