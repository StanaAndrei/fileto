module Util.Rand(generateRandomLengthString) where

  import System.Random
  import Util.Time (getCurrentTimeAsInt)

  low :: Int
  low = 5

  high :: Int
  high = 15

  randomChar :: IO Char
  randomChar = do
    let chars = ['a'..'z'] ++ ['0'..'9']
    index <- randomRIO (0, length chars - 1)
    return $ chars !! index

  generateString :: Int -> IO String
  generateString n = 
    if n <= 0 
      then return ""
      else sequence [randomChar | _ <- [1..n]]

  generateRandomLengthString :: IO String
  generateRandomLengthString = do
    randomLength <- randomRIO (low, high)
    generateString randomLength