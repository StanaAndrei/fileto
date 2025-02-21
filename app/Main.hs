module Main where

import System.Environment (getArgs)
import Argacts

main :: IO ()
main = do
  args <- getArgs
  case args of
    ["gen-key"] -> Argacts.printRandLenKey
    ("gen-key":lenStr) -> Argacts.printRandKey ( read $ lenStr !! 0 :: Int )
    ("v-enc":"--in-file":infile:"--out-file":outfile:"--key":key:_) -> Argacts.vEncrypt infile outfile key
    ("v-dec":"--in-file":infile:"--out-file":outfile:"--key":key:_) -> Argacts.vDecrypt infile outfile key
    -- ("b-enc":"--in-file":infile:"--out-file":outfile:"--key-file":keyfile) -> print infile
    -- ("b-dec":"--in-file":infile:"--out-file":outfile:"--key-file":keyfile) -> print infile
    ["--encode", infile] -> huffmanEncode infile
    ["--decode", infile] -> huffmanDecode infile
    _ -> printUsage


printUsage :: IO ()
printUsage = putStrLn $ unlines
  [ "Usage:"
  -- , "  Encrypt a text:   --encrypt --text \"Hello123\" --out encrypted.txt --key Key123"
  -- , "  Decrypt a text:   --decrypt --text \"Rijvs456\" --out decrypted.txt --key Key123"
  ]