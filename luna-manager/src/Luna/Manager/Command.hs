module Luna.Manager.Command where

import Prologue

import Control.Monad.Raise
import Control.Monad.State.Layered
import Luna.Manager.Command.Options
import Luna.Manager.Component.Analytics (MPUserData)
import Luna.Manager.Component.Repository
import Luna.Manager.System.Host
import Luna.Manager.System.Env
import qualified Luna.Manager.Command.Install       as Install
import           Luna.Manager.Command.Install       (InstallConfig)
import qualified Luna.Manager.Command.CreatePackage as CreatePackage
import           Luna.Manager.Command.CreatePackage (PackageConfig)
import qualified Luna.Manager.Command.Develop       as Develop
import qualified Luna.Manager.Command.NextVersion   as NextVersion
import qualified Luna.Manager.Shell.Shelly          as Shelly
import           Luna.Manager.Shell.Shelly          (MonadSh, MonadShControl)
import Control.Monad.Trans.Resource ( MonadBaseControl)

chooseCommand :: (MonadIO m, MonadException SomeException m, MonadGetter Options m, MonadSh m, MonadShControl m, MonadThrow m, MonadCatch m, MonadBaseControl IO m) => m ()
chooseCommand = do
    opts <- get @Options

    case opts ^. command of
        Install     opt -> evalDefHostConfigs @'[InstallConfig, EnvConfig, RepoConfig] $ evalStateT @MPUserData (Install.run opt) def
        MakePackage opt -> evalDefHostConfigs @'[PackageConfig, EnvConfig, RepoConfig]                        $ CreatePackage.run opt
        Develop     opt -> evalDefHostConfigs @'[Develop.DevelopConfig, EnvConfig, PackageConfig, RepoConfig] $ Develop.run       opt
        NextVersion opt -> evalDefHostConfigs @'[EnvConfig, RepoConfig]                                       $ NextVersion.run   opt
        -- TODO: other commands
