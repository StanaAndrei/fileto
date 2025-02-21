module Argacts where

import Util.Rand (generateRandomLengthString, generateString)
import qualified Cip.Vig as Vig

import System.Exit (exitFailure)
import qualified Data.ByteString as B
import qualified Data.Map.Strict as Map
import Data.List (isSuffixOf)
import Data.Word (Word8)
import Control.Monad (when)
import Comp.Defs (minSize, fileSuffix)
import Comp.Huffman (getFreq, makeOptBinTree, buildMap, decodeTree)

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

huffmanEncode :: FilePath -> IO ()
huffmanEncode infile = do
  content <- B.readFile infile
  let bytes = B.unpack content
  when (length bytes < minSize) $ do
    putStrLn "It makes no sense to encode this file (too small)!"
    exitFailure
  let freq    = getFreq bytes
      tree    = makeOptBinTree freq
      reprMap = buildMap [] tree
      bits    = concatMap (\b -> Map.findWithDefault [] b reprMap) bytes
      bitsStr = map (\bit -> if bit then '1' else '0') bits
      encodedContent = show (Map.toList freq) ++ "\n" ++ bitsStr
      outFilename = infile ++ fileSuffix
  writeFile outFilename encodedContent
  putStrLn $ "Encoded file written to " ++ outFilename

huffmanDecode :: FilePath -> IO ()
huffmanDecode infile = do
  content <- readFile infile
  let ls = lines content
  if null ls || length ls < 2
    then do
      putStrLn "Encoded file format is invalid."
      exitFailure
    else do
      let freqList   = read (head ls) :: [(Word8, Int)]
          freq       = Map.fromList freqList
          tree       = makeOptBinTree freq
          bits       = map (== '1') (ls !! 1)
          outFilename = if fileSuffix `isSuffixOf` infile
                          then take (length infile - length fileSuffix) infile
                          else error "Wrong file type!"
          decodedBytes = decodeTree tree bits
      B.writeFile outFilename (B.pack decodedBytes)
      putStrLn $ "Decoded file written to " ++ outFilename