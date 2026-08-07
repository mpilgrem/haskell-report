-- catch and try are removed from the export list.

-- |
-- Module: System.IO.Error
module System.IO.Error
  ( -- * I/O errors
    IOError
  , userError
  , mkIOError
  , annotateIOError
    -- * Classifying I/O errors
  , isAlreadyExistsError
  , isDoesNotExistError
  , isAlreadyInUseError
  , isFullError
  , isEOFError
  , isIllegalOperation
  , isPermissionError
  , isUserError
    -- * Attributes of I/O errors
  , ioeGetErrorString
  , ioeGetHandle
  , ioeGetFileName
    -- * Types of I/O error
  , IOErrorType
  , alreadyExistsErrorType
  , doesNotExistErrorType
  , alreadyInUseErrorType
  , fullErrorType
  , eofErrorType
  , illegalOperationErrorType
  , permissionErrorType
  , userErrorType
    -- * Throwing and catching I/O errors
  , ioError
  ) where

import "base" System.IO.Error
