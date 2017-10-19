{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_savage (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/usr/local/bin"
libdir     = "/usr/local/lib/x86_64-linux-ghc-8.0.2/savage-1.0.0-LGYAHjbFnbrKnyU2oqxtqs"
dynlibdir  = "/usr/local/lib/x86_64-linux-ghc-8.0.2"
datadir    = "/usr/local/share/x86_64-linux-ghc-8.0.2/savage-1.0.0"
libexecdir = "/usr/local/libexec/x86_64-linux-ghc-8.0.2/savage-1.0.0"
sysconfdir = "/usr/local/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "savage_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "savage_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "savage_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "savage_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "savage_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "savage_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
