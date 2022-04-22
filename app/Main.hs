{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Web.Scotty
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static
import System.Environment
import System.Process
import Control.Monad
import Control.Monad.IO.Class
import Data.Monoid (mconcat)
import Data.Aeson (FromJSON, ToJSON, decode, encode)
import Pointfree

import qualified Data.Text.Lazy as T

import GHC.Generics (Generic)

data PFCode = PFCode { code :: String } deriving (Show, Generic)
instance ToJSON PFCode
instance FromJSON PFCode

newtype Error = Error {error :: String} deriving (Show, Generic)
instance ToJSON Error

main :: IO ()
main = do
  port <- liftM read $ getEnv "PORT"

  scotty port $ do
    middleware logStdoutDev
    middleware $ staticPolicy (noDots >-> addBase "static")

    get "/" $ file "static/index.html"

    get "/snippet" $ do
      c <- param "code"
      case pointfree' c of
        Nothing -> json $ Error "Error with this code"
        Just pf -> json $ PFCode pf

    notFound $ text "Not Found"
