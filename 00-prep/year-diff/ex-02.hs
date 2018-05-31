#!/usr/bin/env stack
-- stack --resolver lts-11.10 --install-ghc runghc

returnMaybe = Just

main
    | returnMaybe "Hello" == Just "Hello" = putStrLn "Correct!"
    | otherwise = putStrLn "Incorrect, please try again"