module Util.Time (
  getCurrentTimeAsInt
) where
  
import Data.Time.Clock.POSIX (getPOSIXTime)

getCurrentTimeAsInt :: IO Int
getCurrentTimeAsInt = do
  time <- getPOSIXTime
  return (round (time * 1e3))