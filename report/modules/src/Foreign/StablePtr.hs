module Foreign.StablePtr
  ( -- * Stable references to Haskell values
    StablePtr
  , newStablePtr
  , deRefStablePtr
  , freeStablePtr
  , castStablePtrToPtr
  , castPtrToStablePtr
    -- ** The C-Side interface

    -- | The following definition is available to C programs inter-operating
    -- with Haskell code when including the header @HsFFI.h@.
    --
    -- @
    -- typedef void *HsStablePtr;
    -- @
    --
    -- Note that no assumptions may be made about the values representing stable
    --  pointers. In fact, they need not even be valid memory addresses. The
    -- only guarantee provided is that if they are passed back to Haskell land,
    -- the function 'deRefStablePtr' will be able to reconstruct the Haskell
    -- value referred to by the stable pointer.
  ) where

import "base" Foreign.StablePtr
