module Comp.FileUtils
  ( readBinaryFile
  , writeBinaryFile
  ) where

import qualified Data.ByteString as B

readBinaryFile :: FilePath -> IO B.ByteString
readBinaryFile = B.readFile

writeBinaryFile :: FilePath -> B.ByteString -> IO ()
writeBinaryFile = B.writeFile