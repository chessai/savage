module Savage.Randy (
  -- * Combinators
    lift

  -- ** Shrinking
  , shrink
  , prune

  -- ** Size
  , small
  , scale
  , resize
  , sized

  -- ** Integral
  , integral
  , integral_

  , int
  , int8
  , int16
  , int32
  , int64

  , word
  , word8
  , word16
  , word32
  , word64

  -- ** Floating-point
  , realFloat
  , realFrac_
  , float
  , double

  -- ** Enumeration
  , enum
  , enumBounded
  , bool
  , bool_

  -- ** Characters
  , binit
  , octit
  , digit
  , hexit
  , lower
  , upper
  , alpha
  , alphaNum
  , ascii
  , latin1
  , unicode
  , unicodeAll

  -- ** Strings
  , string
  , text
  , utf8
  , bytes

  -- ** Choice
  , constant
  , element
  , choice
  , frequency
  , recursive

  -- ** Conditional
  , discard
  , filter
  , just

  -- ** Collections
  , maybe
  , list
  , seq
  , nonEmpty
  , set
  , map

  -- ** Subterms
  , freeze
  , subterm
  , subtermM
  , subterm2
  , subtermM2
  , subterm3
  , subtermM3

  -- ** Combinations & Permutations
  , subsequence
  , shuffle

  -- * Sampling Generators
  , sample
  , print
  , printTree
  , printWith
  , printTreeWith
  ) where

import           Savage.Internal.Gen

import           Prelude hiding (filter, print, maybe, map, seq)
