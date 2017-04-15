{-# LANGUAGE OverloadedStrings, DeriveGeneric  #-}

module Kindle where

import Config

import GHC.Generics

import qualified Data.ByteString        as B
import qualified Data.ByteString.UTF8   as BUTF8
import qualified Network.HTTP.Conduit as HTTP
import Network.HTTP.Client.Conduit (defaultManagerSettings)

type Username = String
type Password = String
type Credential = (Username, Password)
type Url = String
type ApiUrl = String


credentials :: Config -> Credential
credentials config =
  (username config, password config)


sendToKindleUrl :: Credential -> ApiUrl
sendToKindleUrl (username, password) =
  "https://sendtoreader.com/api/send/?username=" ++ username ++ "&password=" ++ password ++ "&url="


sendToKindle :: Config -> Url -> IO()
sendToKindle config url = do
  let post_url = sendToKindleUrl (credentials config) ++ url
  manager <- HTTP.newManager defaultManagerSettings
  request <- HTTP.parseRequest post_url
  HTTP.httpLbs request manager
  print "Document Sent!"
