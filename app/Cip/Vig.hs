module Cip.Vig(
  encrypt, 
  decrypt
) where

import Data.Char (chr, ord, isAlpha, isDigit, isUpper, isLower)

shiftChar :: Char -> Int -> Char
shiftChar c key
  | isAlpha c = shiftAlpha c key
  | isDigit c = shiftDigit c key
  | otherwise = c -- Leave !alphanumeric characters unchanged

shiftAlpha :: Char -> Int -> Char
shiftAlpha c key
  | isUpper c = chr $ (ord 'A' + (ord c - ord 'A' + key) `mod` 26)
  | isLower c = chr $ (ord 'a' + (ord c - ord 'a' + key) `mod` 26)
  | otherwise = c

shiftDigit :: Char -> Int -> Char
shiftDigit c key = chr $ (ord '0' + (ord c - ord '0' + key) `mod` 10)

generateKeyStream :: String -> String -> [Int]
generateKeyStream _ key = map keyToShift $ concat $ repeat key
  where
    keyToShift k
      | isAlpha k = if isUpper k then ord k - ord 'A' else ord k - ord 'a'
      | isDigit k = ord k - ord '0'
      | otherwise = 0

encrypt :: String -> String -> String
encrypt text key = zipWith shiftChar text (generateKeyStream text key)

decrypt :: String -> String -> String
decrypt text key = zipWith shiftChar text (map negate (generateKeyStream text key))