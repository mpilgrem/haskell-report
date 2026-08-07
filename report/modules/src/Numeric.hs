-- |
-- Module: Numeric
module Numeric
  ( -- * Showing
    showSigned
  , showIntAtBase
  , showInt
  , showHex
  , showOct
  , showEFloat
  , showFFloat
  , showGFloat
  , showFloat
  , floatToDigits
    -- * Reading

    -- | NB: @readInt@ is the ’dual’ of @showIntAtBase@, and @readDec@ is
    -- the ‘dual’ of @showInt@. The inconsistent naming is a historical
    -- accident.
  , readSigned
  , readInt
  , readDec
  , readOct
  , readHex
  , readFloat
  , lexDigits
    -- * Miscellaneous
  , fromRat
  ) where

import "base" Numeric
