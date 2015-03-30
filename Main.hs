{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

import Web.Scotty
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static
import System.Environment
import System.Process
import Control.Monad
import Control.Monad.IO.Class
import Data.Monoid (mconcat)
import Data.Aeson (FromJSON, ToJSON, decode, encode)

import qualified Data.Text.Lazy as T

import GHC.Generics (Generic)

data PFCode = PFCode { code :: String } deriving (Show, Generic)
instance ToJSON PFCode

main = do
  port <- liftM read $ getEnv "PORT"

  scotty port $ do
    middleware logStdoutDev
    middleware $ staticPolicy (noDots >-> addBase "static")

    get "/" $ file "static/index.html"

    post "/snippet" $ do
      code  <- param "code"
      pf    <- liftIO $ pointsFree code
      json (PFCode pf)

    notFound $ text "that route does not exist"

pointsFree code = readProcess process (sanitizeArgs code) ""
sanitizeArgs = words
process = "./bin/pointfree"

