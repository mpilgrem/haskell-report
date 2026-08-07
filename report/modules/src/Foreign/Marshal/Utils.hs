-- |
-- Module: Foreign.Marshal.Utils
module Foreign.Marshal.Utils
  ( -- * General marshalling utilities
    -- ** Combined allocation and marshalling
    with
  , new
    -- ** Marshalling of Boolean values (non-zero corresponds to True)
  , fromBool
  , toBool
    -- ** Marshalling of Maybe values
  , maybeNew
  , maybeWith
  , maybePeek
    -- ** Marshalling lists of storable objects
  , withMany
    -- ** Haskellish interface to memcpy and memmove

    -- | (argument order: destination, source)
  , copyBytes
  , moveBytes
  ) where

import "base" Foreign.Marshal.Utils
