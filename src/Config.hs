{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

module Config where

import Data.Aeson
import GHC.Generics

data Config = Config { twitterAccessToken :: String
                     , twitterAccessTokenSecret :: String
                     , twitterConsumerKey :: String
                     , twitterConsumerSecret :: String
                     , sendToReaderUsername :: String
                     , sendToReaderPassword :: String
                     } deriving (Show, Generic)

instance FromJSON Config
