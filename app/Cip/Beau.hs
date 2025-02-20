module Cip.Beau (
  encrypt,
  decrypt
) where

import System.IO
import Data.Char (toUpper, isAlphaNum)

type BeaufortMatrix = [[Char]]

readMatrix :: FilePath -> IO BeaufortMatrix
readMatrix filepath = do
    content <- readFile filepath
    return $ lines content

cleanInput :: String -> String
cleanInput = filter isAlphaNum . map toUpper

processText :: BeaufortMatrix -> String -> String
processText matrix text = 
    let cleanText = cleanInput text
        firstRow = head matrix
    in map (\c -> firstRow !! (findIndex c matrix)) cleanText
    where
        findIndex c matrix = length $ takeWhile (/= c) (head matrix)

encrypt :: FilePath -> String -> IO String
encrypt matrixFile plaintext = do
    matrix <- readMatrix matrixFile
    return $ processText matrix plaintext

decrypt :: FilePath -> String -> IO String
decrypt = encrypt