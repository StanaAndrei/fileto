module Comp.Huffman
  ( getFreq
  , makeOptBinTree
  , buildMap
  , decodeTree
  ) where

import qualified Data.Map.Strict as Map
import Data.Word (Word8)
import Data.List (sortOn)
import Comp.OptBinTree (OptBinTree(..), freqOf, decodeSymbol)

-- Build a frequency map from a list of bytes.
getFreq :: [Word8] -> Map.Map Word8 Int
getFreq = foldl (\m b -> Map.insertWith (+) b 1 m) Map.empty

makeOptBinTree :: Map.Map Word8 Int -> OptBinTree
makeOptBinTree freqMap =
    let leaves = map (\(b, count) -> Leaf b count) (Map.toList freqMap)
    in buildTree leaves

buildTree :: [OptBinTree] -> OptBinTree
buildTree []  = error "buildTree: empty list"
buildTree [t] = t
buildTree ts  =
  let sorted = sortOn freqOf ts
  in case sorted of
       t1:t2:rest -> buildTree (merge t1 t2 : rest)
       _          -> error "buildTree: not enough elements to merge"

merge :: OptBinTree -> OptBinTree -> OptBinTree
merge t1 t2 = Internal (freqOf t1 + freqOf t2) t1 t2

-- Build a map from each byte to its bit representation (as a list of Bool)
buildMap :: [Bool] -> OptBinTree -> Map.Map Word8 [Bool]
buildMap path (Leaf b _) = Map.singleton b path
buildMap path (Internal _ left right) =
    Map.union (buildMap (path ++ [False]) left)
              (buildMap (path ++ [True]) right)

-- Decode a bit stream using the Huffman tree.
decodeTree :: OptBinTree -> [Bool] -> [Word8]
decodeTree tree bits = case bits of
    [] -> []
    _  -> let (b, rest) = decodeSymbol tree bits
          in b : decodeTree tree rest