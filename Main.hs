{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty as S
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static
import System.Environment
import System.Process
import Control.Monad
import Control.Monad.IO.Class
import Data.Monoid (mconcat)
import Data.Aeson

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
      S.json $ object ["pointfree" .= T.pack pf ]

    notFound $ do
      text "that route does not exist"

pointsFree code = readProcess process (sanitizeArgs code) ""
sanitizeArgs = words
process = ".cabal-sandbox/bin/pointfree"

-- instance ToJSON String where
--   toJSON str = object ["ok" .= str]