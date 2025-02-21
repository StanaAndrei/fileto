module Cip.BeauMat(
  generateMatrix, 
  formatMatrix
) where

import Data.Char (chr)
import Util.Rand (shuffleString)

indexToChar :: Int -> Char
indexToChar n
    | n < 10    = chr (n + 48)    -- 0-9
    | otherwise = chr (n + 55)     -- A-Z (65-90)

generateRow :: Int -> String
generateRow offset = [indexToChar ((n + offset) `mod` 36) | n <- [0..35]]

generateMatrix :: IO [String]
generateMatrix = mapM (shuffleString . generateRow) [0..35]

formatMatrix :: [String] -> String
formatMatrix = unlines