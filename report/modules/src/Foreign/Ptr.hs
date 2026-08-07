-- |
-- Module: Foreign.Ptr
--
-- The module @Foreign.Ptr@ provides typed pointers to foreign entities. We
-- distinguish two kinds of pointers: pointers to data and pointers to
-- functions. It is understood that these two kinds of pointers may be
-- represented differently as they may be references to data and text segments,
-- respectively.
module Foreign.Ptr
  ( -- * Data pointers
    Ptr
  , nullPtr
  , castPtr
  , plusPtr
  , alignPtr
  , minusPtr
    -- * Function pointers
  , FunPtr
  , nullFunPtr
  , castFunPtr
  , castFunPtrToPtr
  , castPtrToFunPtr
  , freeHaskellFunPtr
    -- * Integral types with lossless conversion to and from pointers
  , IntPtr
  , ptrToIntPtr
  , intPtrToPtr
  , WordPtr
  , ptrToWordPtr
  , wordPtrToPtr
  ) where

import "base" Foreign.Ptr
