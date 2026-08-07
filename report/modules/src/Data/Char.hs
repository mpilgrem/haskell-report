-- |
-- Module: Data.Char
module Data.Char
  ( -- * Characters and strings
    Char
  , String
    -- * Character classification

    -- | Unicode characters are divided into letters, numbers, marks,
    -- punctuation, symbols, separators (including spaces) and others (including
    -- control characters).
  , isControl
  , isSpace
  , isLower
  , isUpper
  , isAlpha
  , isAlphaNum
  , isPrint
  , isDigit
  , isOctDigit
  , isHexDigit
  , isLetter
  , isMark
  , isNumber
  , isPunctuation
  , isSymbol
  , isSeparator
    -- * Subranges
  , isAscii
  , isLatin1
  , isAsciiUpper
  , isAsciiLower
    -- * Unicode general categories
  , GeneralCategory
      ( UppercaseLetter, LowercaseLetter, TitlecaseLetter, ModifierLetter
      , OtherLetter, NonSpacingMark, SpacingCombiningMark, EnclosingMark
      , DecimalNumber, LetterNumber, OtherNumber, ConnectorPunctuation
      , DashPunctuation, OpenPunctuation, ClosePunctuation, InitialQuote
      , FinalQuote, OtherPunctuation, MathSymbol, CurrencySymbol, ModifierSymbol
      , OtherSymbol, Space, LineSeparator, ParagraphSeparator, Control, Format
      , Surrogate, PrivateUse, NotAssigned
      )
  , generalCategory
    -- * Case conversion
  , toUpper
  , toLower
  , toTitle
    -- * Single digit characters
  , digitToInt
  , intToDigit
    -- * Numeric representations
  , ord
  , chr
    -- * String representations
  , showLitChar
  , lexLitChar
  , readLitChar
  ) where

import "base" Data.Char
import "base" Prelude
