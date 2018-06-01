#!/usr/bin/env stack
-- stack --resolver lts-11.10 script
{-# LANGUAGE OverloadedStrings #-}

import           Data.ByteString         (ByteString)
import qualified Data.ByteString         as B
import           Data.ByteString.Builder (Builder)
import qualified Data.ByteString.Builder as BB
import           Data.Map.Strict         (Map)
import qualified Data.Map.Strict         as Map
import           Data.Monoid             ((<>))
import           Data.Word               (Word8)
import           System.IO

getFreqs :: ByteString -> Map Word8 Int
getFreqs bs = B.foldl'
    (\acc w -> Map.insertWith (+) w 1 acc)
    Map.empty
    bs

showFreqs :: Map Word8 Int -> Builder
showFreqs m = Map.foldMapWithKey
    (\w cnt -> BB.word8Dec w <> ": " <> BB.intDec cnt <> "\n")
    m

main :: IO ()
main = do
    bs <- B.getContents
    BB.hPutBuilder stdout $ showFreqs $ getFreqs bs