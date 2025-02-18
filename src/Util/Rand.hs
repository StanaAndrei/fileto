module Util.Rand(generateRandomLengthString) where

  import Util.Time (getCurrentTimeAsInt)

  low :: Int
  low = 5
  
  high :: Int
  high = 15

  pseudoRandom :: Int -> Int -> Int -> Int
  pseudoRandom seed min max = 
    let hash = (seed * 1103515245 + 12345) `mod` (2 ^ (2 ^ 5 - 1) - 1)
    in min + (hash `mod` (max - min + 1))

  randomChar :: Int -> Char
  randomChar seed = 
    let chars = ['a'..'z'] ++ ['0'..'9']
        index = pseudoRandom seed 0 (length chars - 1)
    in chars !! index

  generateString :: Int -> Int -> String
  generateString seed n = 
    if n <= 0 
      then ""
      else let chars = [randomChar (seed + i) | i <- [0..n-1]]
           in chars

  generateRandomLengthString :: IO String
  generateRandomLengthString = do
    seed <- getCurrentTimeAsInt
    let randomLength = pseudoRandom seed low high
    return $ generateString seed randomLength