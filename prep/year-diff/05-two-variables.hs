#!/usr/bin/env stack
-- stack --resolver lts-11.10 --install-ghc runghc

import Text.Read (readMaybe)

displayAge maybeAge =
  case maybeAge of
      Nothing -> putStrLn "You provided invalid input"
      Just age -> putStrLn $ "In that year, you will be: " ++ show age

main = do
  putStrLn "Please enter your birth year"
  birthYearString <- getLine
  putStrLn "Please enter some year in the future"
  futureYearString <- getLine
  let maybeAge =
          case readMaybe birthYearString of
              Nothing -> Nothing
              Just birthYear ->
                  case readMaybe futureYearString of
                      Nothing -> Nothing
                      Just futureYear -> Just (futureYear - birthYear)
  displayAge maybeAge