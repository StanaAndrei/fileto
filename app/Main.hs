import System.Environment (getArgs)
import System.IO (readFile, writeFile)

import qualified Cip.Vig as Vig

import Util.Rand (generateRandomLengthString)

main :: IO()
main = do
  print $ Vig.decrypt "mskf sl, hseo!" "key1"
  randomStr <- generateRandomLengthString
  putStrLn randomStr
  print "Works123!"