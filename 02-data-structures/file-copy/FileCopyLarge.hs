#!/usr/bin/env stack
-- stack --resolver lts-11.11 script

{-# LANGUAGE OverloadedStrings #-}
import qualified Data.ByteString.Lazy as BL
import Conduit

-- does this work? no...
main :: IO ()
main = do
  let sourceFp = "source-large.txt"
  let destFp = "dest-large.txt"
  BL.readFile sourceFp >>= BL.writeFile destFp


main' :: IO ()
  withSourceFile "source-large.txt" $ \src ->
    withSinkFile "dest-large.txt" $ \dest ->
      runConduit $ src .| dest