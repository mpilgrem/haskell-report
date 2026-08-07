-- |
-- Module: Data.Bits
--
-- This module defines bitwise operations for signed and unsigned integers.
module Data.Bits
  ( Bits ( (.&.), (.|.), xor, complement, shift, rotate, bit, setBit, clearBit
      , complementBit, testBit, bitSize, isSigned, shiftL, shiftR, rotateL
      , rotateR
      )
  ) where

import "base" Data.Bits
