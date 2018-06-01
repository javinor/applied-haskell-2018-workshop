#!/usr/bin/env stack
-- stack --resolver lts-11.10 script
import Data.Foldable (foldl')
import UnliftIO.Exception (pureTry)

data Foo = Foo Int
  deriving Show
data Bar = Bar !Int
  deriving Show
newtype Baz = Baz Int
  deriving Show

main :: IO ()
main = do
  print $ pureTry $
    case Foo undefined of
      Foo _ -> "Hello World"
  print $ pureTry $
    case Bar undefined of
      Bar _ -> "Hello World"
  print $ pureTry $
    case Baz undefined of
      Baz _ -> "Hello World"

-- The argument in `case` (the * in "case * of") does not evaluate 

-- case Baz undefined of
--   Baz _ -> "Hello World"
-- is the same as:
-- case undefined of
--   _ -> "Hello World"