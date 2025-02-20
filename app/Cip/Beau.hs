module Cip.Beau (
    encrypt,
    decrypt
) where

import System.IO
import Data.Char (toUpper, isAlphaNum)

-- Type alias for the Beaufort matrix
type BeaufortMatrix = [[Char]]

-- Read and parse the matrix file
readMatrix :: FilePath -> IO BeaufortMatrix
readMatrix filepath = do
    content <- readFile filepath
    return $ lines content

-- Clean input string: convert to uppercase and remove non-alphanumeric chars
cleanInput :: String -> String
cleanInput = filter isAlphaNum . map toUpper

-- Process text using the matrix
processText :: BeaufortMatrix -> String -> String
processText matrix text = 
    let cleanText = cleanInput text
        firstRow = head matrix
    in map (\c -> firstRow !! (findIndex c matrix)) cleanText
    where
        findIndex c matrix = length $ takeWhile (/= c) (head matrix)

-- Encrypt text using Beaufort matrix
encrypt :: FilePath -> String -> IO String
encrypt matrixFile plaintext = do
    matrix <- readMatrix matrixFile
    return $ processText matrix plaintext

-- Decrypt text using Beaufort matrix
-- For Beaufort cipher with matrix, encryption and decryption are the same operation
decrypt :: FilePath -> String -> IO String
decrypt = encrypt