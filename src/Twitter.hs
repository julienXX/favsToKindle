{-# LANGUAGE OverloadedStrings, DeriveGeneric  #-}

module Twitter where

import Web.Authenticate.OAuth
import GHC.Generics

import qualified Data.Aeson             as JSON
import qualified Data.ByteString        as B
import qualified Data.ByteString.UTF8   as BUTF8

data Config = Config { apiKey         :: String
                     , apiSecret      :: String
                     , consumerKey    :: String
                     , consumerSecret :: String
                     } deriving (Show, Generic)

instance JSON.FromJSON Config

data Tweet = Tweet { entities :: Entities } deriving (Show, Generic)
data Entities = Entities { urls :: [Url] } deriving (Show, Generic)
data Url = Url { expanded_url :: String } deriving (Show, Generic)

instance JSON.FromJSON Tweet
instance JSON.FromJSON Entities
instance JSON.FromJSON Url

type TwitterHandle = String
type ApiUrl = String
type ExtractedUrl = String


extractLinks :: [Tweet] -> [ExtractedUrl]
extractLinks tweets =
  let url_list = map entities tweets >>= urls
  in map expanded_url url_list;


favoritesUrl :: TwitterHandle -> ApiUrl
favoritesUrl =
  (++) "https://api.twitter.com/1.1/favorites/list.json?count=200&screen_name="


credentials :: Config -> (Credential, OAuth)
credentials config =
  let credential = newCredential
                   (BUTF8.fromString $ apiKey config)
                   (BUTF8.fromString $ apiSecret config)
      oauth = newOAuth
            { oauthServerName = "api.twitter.com"
            , oauthConsumerKey = BUTF8.fromString $ consumerKey config
            , oauthConsumerSecret = BUTF8.fromString $ consumerSecret config
            }
  in (credential, oauth)
