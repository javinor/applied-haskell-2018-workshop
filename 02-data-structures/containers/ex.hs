#!/usr/bin/env stack
-- stack --resolver lts-11.10 script
import qualified Data.ByteString as B
import Data.ByteString (ByteString)
import Data.Word (Word8)
import qualified Data.Map.Strict as Map
import Data.Map.Strict (Map)

getFreqs :: ByteString -> Map Word8 Int
getFreqs bs = B.foldl'
  (\acc w -> Map.insertWith (+) w 1 acc)
  Map.empty
  bs

main :: IO ()
main = do
  bs <- B.getContents
  putStrLn $ unlines $ map show $ Map.toList $ getFreqs bs