module Cip.Beau (
    encrypt,
    decrypt
) where

import Data.Char (toUpper, isAlphaNum)

type BeaufortMatrix = [[Char]]

readMatrix :: FilePath -> IO BeaufortMatrix
readMatrix filepath = do
    content <- readFile filepath
    return $ lines content

prepareChar :: Char -> Char
prepareChar c = if isAlphaNum c then toUpper c else c

findPosition :: Char -> String -> Int
findPosition c row = length $ takeWhile (/= c) row

processChar :: BeaufortMatrix -> Char -> Char
processChar matrix c 
    | isAlphaNum c = 
        let firstRow = head matrix
            pos = findPosition (toUpper c) firstRow
        in firstRow !! ((36 - pos) `mod` 36)
    | otherwise = c

processText :: BeaufortMatrix -> String -> String
processText matrix = map (processChar matrix . prepareChar)

encrypt :: FilePath -> String -> IO String
encrypt matrixFile plaintext = do
    matrix <- readMatrix matrixFile
    return $ processText matrix plaintext

decrypt :: FilePath -> String -> IO String
decrypt = encrypt