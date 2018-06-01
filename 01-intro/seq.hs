#!/usr/bin/env stack
-- stack --resolver lts-11.11 --install-ghc runghc

seqMaybe :: Maybe a -> b -> b
seqMaybe Nothing b = b
seqMaybe (Just _) b = b

seqInt :: Int -> b -> b
seqInt (n + 0) b = b

seqInt' :: Int -> b -> b
seqInt' 0 b = b
seqInt' _ b = b

-- breaking Haskell
seqFn :: ((->) a a') -> b -> b
seqFn = undefined -- can't be done!

g f == g (\y -> f y)
f `seqFunc` "Hello World!" == (\y -> f y) `seqFunc` "Hello World!"

f _ = undefined -- is a function that holds the above equality
f = undefined -- is an undefined function which breaks that above equality

-- they could have defined a type-class as follows:
class Seq a where
  seq :: a -> b -> b
-- but this was dismissed for pragmatic reasons

-- this is how NFData is defined! giving us deepSeq
class NFData a where
  rnf :: a -> ()
instance NFData Int where
  rnf x = seq x ()
instance NFData a => NFData (Maybe a) where
  rnf Nothing = ()
  rnf (Just x) = rnf x
instance NFData a => NFData [a] where
  rnf [] = ()
  rnf (x:xs) = rnf x `seq` rnf xs

deepseq :: NFData a => a -> b -> b
deepSeq a b = rnf a `seq` b



-- another example: sum
sum :: Int -> [Int] -> Int
sum total [] = total
sum total (x:xs) = sum (total + x) xs

sum :: Int -> [Int] -> Int
sum total [] = total
sum total (x:xs) =
  let total' = total + x
   in total' `seq` sum total' xs
