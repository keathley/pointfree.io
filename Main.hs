{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static
import System.Environment
import System.Process
import Control.Monad
import Control.Monad.IO.Class
import Data.Monoid (mconcat)

import qualified Data.Text.Lazy as T

main = do
  port <- liftM read $ getEnv "PORT"
  scotty port $ do
    middleware logStdoutDev
    middleware $ staticPolicy (noDots >-> addBase "static")

    get "/" $ file "static/index.html"

    post "/snippet" $ do
      code  <- param "code"
      pf    <- liftIO $ pointsFree code
      html $ mconcat ["OUTPUT: ", T.pack pf]

    notFound $ do
      text "that route does not exist"

pointsFree code = readProcess process (sanitizeArgs code) ""
-- sanitizeArgs code = map (filter (/='"')) $ words code
sanitizeArgs = words
process = ".cabal-sandbox/bin/pointfree"
