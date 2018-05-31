#!/usr/bin/env stack
-- stack --resolver lts-11.10 --install-ghc runghc

seqMaybe :: Maybe a -> b -> b
seqMaybe Nothing b = b
seqMaybe (Just _) b = b

main :: IO ()
main = do
  putStrLn $ Just undefined `seqMaybe` "Hello World"
  putStrLn $ undefined `seqMaybe` "Goodbye!"