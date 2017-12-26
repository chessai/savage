-- This module is designed to be used alongside "Savage.Randy" and "Savage.Range",
-- which should be imported qualified.
--
-- > import           Savage
-- > import qualified Savage.Randy as Gen
-- > import qualified Savage.Range as Range

module Savage (
    Gen
  , GenT
  , MonadGen(..)
  , Range
  , Size(..)
  , Seed(..)
  , Distributive(..)
  ) where

import           Savage.Internal.Distributive (Distributive(..))
import           Savage.Internal.Gen (Gen, GenT, MonadGen(..))
import           Savage.Internal.Range (Range, Size(..))
import           Savage.Internal.Seed (Seed(..))
