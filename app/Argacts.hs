module Argacts where

import Util.Rand (generateRandomLengthString, generateString)
import qualified Cip.Vig as Vig

printRandLenKey :: IO ()
printRandLenKey = do
  key <- generateRandomLengthString
  putStr "key: "
  print key
  
printRandKey :: Int -> IO ()
printRandKey len = do
  key <- generateString len
  putStr "key: "
  print key

vEncrypt :: FilePath -> FilePath -> String -> IO ()
vEncrypt infile outfile key = do
  original <- readFile infile
  let encrypted = Vig.encrypt original key
  writeFile outfile encrypted

vDecrypt :: FilePath -> FilePath -> String -> IO ()
vDecrypt infile outfile key = do
  encrypted <- readFile infile
  let original = Vig.decrypt encrypted key
  writeFile outfile original
