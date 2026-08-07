-- |
-- Module: Foreign.Marshal.Array
--
-- The module @Foreign.Marshal.Array@ provides operations for marshalling
-- Haskell lists into monolithic arrays and vice versa. Most functions come in
-- two flavours: one for arrays terminated by a special termination element and
-- one where an explicit length parameter is used to determine the extent of an
-- array. The typical example for the former case are C’s NUL terminated
-- strings. However, please note that C strings should usually be marshalled
-- using the functions provided by @Foreign.C.String@ as the Unicode encoding
-- has to be taken into account. All functions specifically operating on arrays
-- that are terminated by a special termination element have a name ending on
-- @0@—e.g., 'mallocArray' allocates space for an array of the given size,
-- whereas 'mallocArray0' allocates space for one more element to ensure that
-- there is room for the terminator.
module Foreign.Marshal.Array
  ( -- * Marshalling arrays
    -- ** Allocation
    mallocArray
  , mallocArray0
  , allocaArray
  , allocaArray0
  , reallocArray
  , reallocArray0
    -- ** Marshalling
  , peekArray
  , peekArray0
  , pokeArray
  , pokeArray0
    -- ** Combined allocation and marshalling
  , newArray
  , newArray0
  , withArray
  , withArray0
  , withArrayLen
  , withArrayLen0
    -- ** Copying

    -- | (argument order: destination, source)
  , copyArray
  , moveArray
    -- ** Finding the length
  , lengthArray0
    -- ** Indexing
  , advancePtr
  ) where

import "base" Foreign.Marshal.Array
