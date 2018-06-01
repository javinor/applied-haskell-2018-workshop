#!/usr/bin/env stack
-- stack --resolver lts-11.11 script

{-# LANGUAGE OverloadedStrings #-}
import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as B8
import Data.Monoid ((<>))

main :: IO ()
main = do
  let sourceFp = "source.txt"
  let destFp = "dest.txt"
  contents <- B.readFile sourceFp
  B.writeFile destFp contents