{-# LANGUAGE CPP #-}

module Savage.Randy where

import System.Random
import System.Random.TF
import System.Random.TF.Gen (splitn)
import Data.Word
import Data.Bits

#define TheGen TFGen

newTheGen :: IO TFGen
newTheGen = newTFGen

bits, mask, doneBit :: Integral a => a
bits = 14
mask = 0x3fff
doneBit = 0x4000

chip :: Bool -> Word32 -> TFGen -> TFGen
chip done n g = splitn g (bits+1) (if done then m .|. doneBit else m)
  where
    m = n .&. mask

chop :: Integer -> Integer
chop n = n `shiftR` bits

stop :: Integral a => a -> Bool
stop n = n <= mask

mkTheGen :: Int -> TFGen
mkTheGen = mkTFGen

-- | The "standard" QuickCheck random number generator.
-- A wrapper around either 'TFGen' on GHC, or 'StdGen'
-- on other Haskell systems.
newtype SVGen = SVGen TheGen

instance Show SVGen where
  showsPrec n (SVGen g) s = showsPrec n g "" ++ s
instance Read SVGen where
  readsPrec n xs = [(SVGen g, ys) | (g, ys) <- readsPrec n xs]

instance RandomGen SVGen where
  split (SVGen g) =
    case split g of
      (g1, g2) -> (SVGen g1, SVGen g2)
  genRange (SVGen g) = genRange g
  next (SVGen g) =
    case next g of
      (x, g') -> (x, SVGen g')

newSVGen :: IO SVGen
newSVGen = fmap SVGen newTheGen

mkSVGen :: Int -> SVGen
mkSVGen n = SVGen (mkTheGen n)

bigNatVariant :: Integer -> TheGen -> TheGen
bigNatVariant n g
  | g `seq` stop n = chip True (fromInteger n) g
  | otherwise      = (bigNatVariant $! chop n) $! chip False (fromInteger n) g

{-# INLINE natVariant #-}
natVariant :: Integral a => a -> TheGen -> TheGen
natVariant n g
  | g `seq` stop n = chip True (fromIntegral n) g
  | otherwise      = bigNatVariant (toInteger n) g

{-# INLINE variantTheGen #-}
variantTheGen :: Integral a => a -> TheGen -> TheGen
variantTheGen n g
  | n >= 1    = natVariant (n-1) (boolVariant False g)
  | n == 0   = natVariant (0 `asTypeOf` n) (boolVariant True g)
  | otherwise = bigNatVariant (negate (toInteger n)) (boolVariant True g)

boolVariant :: Bool -> TheGen -> TheGen
boolVariant False = fst . split
boolVariant True = snd . split

variantSVGen :: Integral a => a -> SVGen -> SVGen
variantSVGen n (SVGen g) = SVGen (variantTheGen n g)
