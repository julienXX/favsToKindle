{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

module Config where

import Data.Aeson
import GHC.Generics

data TwitterConfig = TwitterConfig { accessToken :: String
                                   , accessTokenSecret :: String
                                   , consumerKey :: String
                                   , consumerSecret :: String
                                   } deriving (Show, Generic)

data SendToReaderConfig = SendToReaderConfig { username :: String
                                             , password :: String
                                             } deriving (Show, Generic)

data Config = Config { twitter :: TwitterConfig
                     , send_to_reader :: SendToReaderConfig
                     } deriving (Show, Generic)

instance FromJSON TwitterConfig
instance FromJSON SendToReaderConfig
instance FromJSON Config
