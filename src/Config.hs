{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

module Config where

import qualified Data.Aeson as JSON
import GHC.Generics

data Config = Config { apiKey         :: String
                     , apiSecret      :: String
                     , consumerKey    :: String
                     , consumerSecret :: String
                     } deriving (Show, Generic)

instance JSON.FromJSON Config
