--Warnig!! temporary file to refactor

module Luna.Manager.Gui.InstallationProgress where

import Prologue hiding (FilePath)

import Data.Aeson                    (FromJSON, ToJSON, FromJSONKey, ToJSONKey, parseJSON, encode)
import qualified Data.Aeson          as JSON
import qualified Data.Aeson.Types    as JSON
import qualified Data.Aeson.Encoding as JSON
import qualified Data.ByteString.Lazy as BS
import Control.Lens.Aeson

data InstallationProgress = InstallationProgress { installation_progress :: Float
                                 } deriving (Show, Generic, Eq)

instance ToJSON   InstallationProgress
instance FromJSON InstallationProgress
