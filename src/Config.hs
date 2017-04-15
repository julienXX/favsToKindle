{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

module Config where

import Data.Aeson
import GHC.Generics

data Config = Config { apiKey         :: String
                     , apiSecret      :: String
                     , consumerKey    :: String
                     , consumerSecret :: String
                     } deriving (Show, Generic)

instance FromJSON Config
