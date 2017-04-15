{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

module Main where

import Config
import Twitter
import Kindle

import System.Environment
import Web.Authenticate.OAuth
import qualified Data.Aeson as JSON
import qualified Network.HTTP.Conduit as HTTP
import qualified Data.ByteString.Lazy as BL
import Network.HTTP.Client.Conduit (defaultManagerSettings)

main :: IO ()
main = do
  configData <- BL.readFile "config.json"
  [user] <- getArgs
  let mConfig = JSON.decode configData :: Maybe Config
  case mConfig of
    Nothing ->
      do putStrLn("Unable to parse config.json:");
         BL.putStr(configData)
    Just config ->
      printFavsUrls config user;


printFavsUrls :: Config -> String -> IO ()
printFavsUrls config user = do
  let (myCredential, myOauthApp) = credentials config
  req <- HTTP.parseRequest $ favoritesUrl user
  signedReq <- signOAuth myOauthApp myCredential req
  m <- HTTP.newManager defaultManagerSettings
  resp <-  HTTP.httpLbs signedReq m
  let body = HTTP.responseBody resp
  let maybeTweets = JSON.decode body :: Maybe [Tweet]
  case maybeTweets of
    Nothing -> putStrLn "No tweets found"
    Just tweets -> mapM_ putStrLn $ extractLinks tweets
