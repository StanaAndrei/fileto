module Comp.Defs where

import Data.Word (Word8)

bitsInByte :: Int
bitsInByte = 8

chunkSize :: Int
chunkSize = 1

fileSuffix :: String
fileSuffix = ".hc"

minSize :: Int
minSize = 10