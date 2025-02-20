module Util.Rand(
  generateRandomLengthString,
  shuffleString,
) where

import System.Random


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

shuffleString :: String -> IO String
shuffleString [] = return []
shuffleString [x] = return [x]
shuffleString xs = do
    i <- randomRIO (0, length xs - 1)
    let (left, right) = splitAt i xs
    case right of
        [] -> shuffleString xs --should not happen
        (c:rest) -> do
            remaining <- shuffleString (left ++ rest)
            return (c : remaining)