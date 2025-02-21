module Comp.OptBinTree
  ( OptBinTree(..)
  , freqOf
  , decodeSymbol
  ) where

import Data.Word (Word8)

data OptBinTree
  = Leaf Word8 Int
  | Internal Int OptBinTree OptBinTree
  deriving (Show, Eq)

freqOf :: OptBinTree -> Int
freqOf (Leaf _ n)         = n
freqOf (Internal n _ _)   = n

decodeSymbol :: OptBinTree -> [Bool] -> (Word8, [Bool])
decodeSymbol (Leaf b _) bits = (b, bits)
decodeSymbol (Internal _ left right) (bit:bs) =
  if not bit then decodeSymbol left bs else decodeSymbol right bs
decodeSymbol _ [] = error "Incomplete bit stream."