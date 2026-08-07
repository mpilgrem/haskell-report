-- |
-- Module: Foreign.Marshal
module Foreign.Marshal
  ( module Foreign.Marshal.Alloc
  , module Foreign.Marshal.Array
  , module Foreign.Marshal.Error
  , module Foreign.Marshal.Utils
  , unsafeLocalState
  ) where

import "base" Foreign.Marshal.Unsafe
import "this" Foreign.Marshal.Alloc
import "this" Foreign.Marshal.Array
import "this" Foreign.Marshal.Error
import "this" Foreign.Marshal.Utils
