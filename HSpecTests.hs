module Main where

import Points
import Test.Hspec

main :: IO ()
main = hspec $ do

  describe "Validate pointfree functionality" $ do
    it "haqify is supposed to prefix Haq! to things" $ do
      haqify "me" `shouldBe` "Haq! me"
