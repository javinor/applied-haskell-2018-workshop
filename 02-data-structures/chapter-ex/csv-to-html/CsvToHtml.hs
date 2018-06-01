#!/usr/bin/env stack
-- stack --resolver lts-11.11 script

{-# LANGUAGE OverloadedStrings #-}

import qualified Data.ByteString         as B
import qualified Data.ByteString.Builder as BB
import qualified Data.Text               as T
import qualified Data.Text.Encoding      as TE
import qualified Data.Map.Strict         as M

import Data.Monoid ((<>))
import System.IO   (IOMode( ReadMode, WriteMode ), withBinaryFile )

data Person = Person
    { name  :: !T.Text
    , city  :: !T.Text
    , state :: !T.Text
    } deriving (Show)

type City = T.Text
type State = T.Text
type DemographicDict = M.Map State (M.Map City Int)

toCsvLines :: B.ByteString -> [T.Text]
toCsvLines = (T.splitOn "\n") . TE.decodeUtf8

toPerson :: T.Text -> Person
toPerson row = 
  let name' : city' : state' : [] = T.splitOn "," row
  in  Person {name=name', city=city', state=state'}

toDemographic :: Person -> DemographicDict
toDemographic p = M.singleton (state p) (M.singleton (city p) 1)

mergeDemographics :: [ DemographicDict ] -> DemographicDict
mergeDemographics stateDemos = 
  let mergeCityDemographics = M.unionWith (+)
      mergeStateDemographics = M.unionWith mergeCityDemographics
  in  foldr mergeStateDemographics M.empty $ stateDemos


pad0 = "\n"
pad2 = "\n  "
pad4 = "\n    "
pad6 = "\n      "

showDemographics :: DemographicDict -> BB.Builder
showDemographics m = 
  pad0 <> "<ul>" 
       <> M.foldMapWithKey showStateDemographics m <> 
  pad0 <> "</ul>\n"

showStateDemographics :: State -> M.Map City Int -> BB.Builder
showStateDemographics state cityMap= 
    pad2 <> "<li>" <> (BB.byteString . TE.encodeUtf8) state <>
    pad4 <> "<dl>" 
         <> showCityDemographics cityMap <>
    pad4 <> "</dl>" <>
    pad2 <> "</li>"

showCityDemographics :: M.Map City Int -> BB.Builder
showCityDemographics = 
  M.foldMapWithKey
  (\city count -> 
    pad6 <> showCity city <> 
    pad6 <> showCount count)

showCity :: City -> BB.Builder
showCity city = "<dt>" <> BB.byteString (TE.encodeUtf8 city) <> "</dt>"

showCount :: Int -> BB.Builder
showCount count = "<dd>" <> BB.intDec count <> "</dd>"


pipeFileWith :: FilePath -> FilePath -> (B.ByteString -> BB.Builder) -> IO ()
pipeFileWith src dest pipe = 
  withBinaryFile src ReadMode $ \f ->
    withBinaryFile dest WriteMode $ \t ->
      B.hGetContents f >>= BB.hPutBuilder t . pipe

main :: IO ()
main = 
  pipeFileWith 
    "input.csv" 
    "output.html" 
    (showDemographics . mergeDemographics . (fmap toDemographic) . (fmap toPerson) . toCsvLines)


-- Dev Debugging
-- input :: [T.Text] 
-- input = [ "Alice,Los Angeles,California"
--         , "Bob,New York,New York"
--         , "Charlie,San Francisco,California"
--         , "David,Portland,Oregon"
--         , "Edward,Los Angeles,California"
--         , "Frank,New York,New York" ]

-- parseInput :: [T.Text] -> DemographicDict
-- parseInput = mergeDemographics . (fmap toDemographic) . (fmap toPerson)