module Main where

import System.Environment (getArgs)
import Argacts

main :: IO ()
main = do
  args <- getArgs
  case args of
    ["--gen-key"] -> Argacts.printRandLenKey
    ["--gen-key-mat", matfile] -> Argacts.writeMatrixToFile matfile
    ("--gen-key":lenStr) -> Argacts.printRandKey ( read $ lenStr !! 0 :: Int )
    ("--v-enc":"--in-file":infile:"--out-file":outfile:"--key":key:_) -> Argacts.vEncrypt infile outfile key
    ("--v-dec":"--in-file":infile:"--out-file":outfile:"--key":key:_) -> Argacts.vDecrypt infile outfile key
    ("--b-enc":"--in-file":infile:"--out-file":outfile:"--key-file":keyfile:_) -> Argacts.bEncrypt infile outfile keyfile
    ("--b-dec":"--in-file":infile:"--out-file":outfile:"--key-file":keyfile:_) -> Argacts.bDecrypt infile outfile keyfile
    ["--compress", infile] -> Argacts.huffmanEncode infile
    ["--extract", infile] -> Argacts.huffmanDecode infile
    _ -> Argacts.printUsage