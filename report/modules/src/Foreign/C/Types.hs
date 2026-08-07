-- |
-- Module: Foreign.C.Types
module Foreign.C.Types
  ( -- * Representations of C types
    -- ** Integral types

    -- | These types are are represented as @newtype@s of types in @Data.Int@
    -- and @Data.Word@, and are instances of 'Eq', 'Ord', 'Num', 'Read', 'Show',
    -- 'Enum', 'Storable', 'Bounded', 'Real', 'Integral' and 'Bits'.
    CChar
  , CSChar
  , CUChar
  , CShort
  , CUShort
  , CInt
  , CUInt
  , CLong
  , CULong
  , CPtrdiff
  , CSize
  , CWchar
  , CSigAtomic
  , CLLong
  , CULLong
  , CIntPtr
  , CUIntPtr
  , CIntMax
  , CUIntMax
    -- ** Numeric types
  , CClock
  , CTime
    -- ** Floating types
  , CFloat
  , CDouble
    -- ** Other types
  , CFile
  , CFpos
  , CJmpBuf
  ) where

import "base" Foreign.C.Types
