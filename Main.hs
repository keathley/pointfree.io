{-# LANGUAGE OverloadedStrings #-}
import Web.Scotty
import Network.Wai.Middleware.RequestLogger
import Network.Wai.Middleware.Static
import System.Environment
import Control.Monad
import Data.Monoid

main = do
  port <- liftM read $ getEnv "PORT"

  scotty 3000 $ do
    middleware logStdoutDev
    middleware $ staticPolicy (noDots >-> addBase "static")

    get "/" $ file "static/index.html"

    post "/snippet" $ do
      code <- param "code"
      html $ mconcat ["Posted: ", code]

    notFound $ do
      text "that route does not exist"