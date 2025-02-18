import System.Environment (getArgs)
import System.IO (readFile, writeFile)

import qualified Cip.Vig as Vig

main :: IO()
main = do
  print $ Vig.decrypt "mskf sl, hseo!" "key1"