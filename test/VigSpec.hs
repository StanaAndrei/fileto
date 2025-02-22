module VigSpec where

import Test.Hspec
import Test.QuickCheck

import qualified Cip.Vig as Vig

spec :: Spec
spec = do
  describe "YourFunction" $ do
    it "should work with basic input" $ do
      1 + 1 `shouldBe` 2

  describe "evig" $ do
    it "should work with basic input" $ do
      (Vig.encrypt ("Hi dude!" "key")) `shouldBe` "Rm behc!"
  
  describe "dvig" $ do
    it "should work with basic input" $ do
      (Vig.decrypt ("Rm behc!" "key")) `shouldBe` "Hi dude!"