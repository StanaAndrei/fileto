import System.Environment (getArgs)
import System.IO (readFile, writeFile)

import qualified Cip.Vig as Vig
import qualified Cip.Beau as Beau

import Cip.BeauMat (generateMatrix, formatMatrix)
import Util.Rand (generateRandomLengthString)

writeMatrixToFile :: FilePath -> IO ()
writeMatrixToFile filepath = do
  let matrix = generateMatrix
  writeFile filepath (formatMatrix matrix)
  putStrLn $ "Beaufort cipher matrix key has been written to " ++ filepath

main :: IO()
main = do
  print $ Vig.decrypt "mskf sl, hseo!" "key1"
  randomStr <- generateRandomLengthString
  putStrLn randomStr
  writeMatrixToFile "mat.txt"
  print "Works123!"

  encrypted <- Beau.encrypt "mat.txt" "HELLO123"
  putStrLn $ "Encrypted: " ++ encrypted
    
  decrypted <- Beau.decrypt "mat.txt" encrypted
  putStrLn $ "Decrypted: " ++ decrypted