module System.IO
  ( -- * The IO monad
    IO
  , fixIO
    -- * Files and handles
  , FilePath
  , Handle
    -- * Standard handles

    -- | Three handles are allocated during program initialisation, and are
    -- initially open.
  , stdin
  , stdout
  , stderr
    -- * Opening and closing files
    -- ** Opening files
  , withFile
  , openFile
  , IOMode ( ReadMode, WriteMode, AppendMode, ReadWriteMode )
    -- ** Closing files
  , hClose
    -- ** Special cases

    -- | These functions are also exported by the 'Prelude'.
  , readFile
  , writeFile
  , appendFile
    -- ** File locking

    -- | Implementations should enforce as far as possible, at least locally to
    -- the Haskell process, multiple-reader single-writer locking on files. That
    --  is, /there may either be many handles on the same file which manage/
    -- /input, or just one handle on the file which manages output/. If any open
    -- or semi-closed handle is managing a file for output, no new handle can be
    -- allocated for that file. If any open or semi-closed handle is managing
    -- a file for input, new handles can only be allocated if they do not manage
    -- output. Whether two files are the same is implementation-dependent, but
    -- they should normally be the same if they have the same absolute path name
    -- and neither has been renamed, for example.
    --
    -- Warning: the 'readFile' operation holds a semi-closed handle on the file
    -- until the entire contents of the file have been consumed. It follows that
    -- an attempt to write to a file (using 'writeFile', for example) that was
    -- earlier opened by 'readFile' will usually result in failure
    -- with 'System.IO.Error.isAlreadyInUseError'.

    -- * Operations on handles
    -- ** Determining and changing the size of a file
  , hFileSize
  , hSetFileSize
    -- ** Detecting the end of input
  , hIsEOF
  , isEOF
    -- ** Buffering operations
  , BufferMode ( NoBuffering, LineBuffering, BlockBuffering )
  , hSetBuffering
  , hGetBuffering
  , hFlush
    -- ** Repositioning handles
  , hGetPosn
  , hSetPosn
  , HandlePosn
  , hSeek
  , SeekMode ( AbsoluteSeek, RelativeSeek, SeekFromEnd )
  , hTell
    -- ** Handle properties

    -- | Each of these operations returns 'True' if the handle has the the
    -- specified property, or 'False' otherwise.
  , hIsOpen
  , hIsClosed
  , hIsReadable
  , hIsWritable
  , hIsSeekable
    -- ** Terminal operations
  , hIsTerminalDevice
  , hSetEcho
  , hGetEcho
    -- ** Showing handle state
  , hShow
    -- * Text input and output
    -- ** Text input
  , hWaitForInput
  , hReady
  , hGetChar
  , hGetLine
  , hLookAhead
  , hGetContents
    -- ** Text output
  , hPutChar
  , hPutStr
  , hPutStrLn
  , hPrint
    -- ** Special cases for standard input and output

    -- | These functions are also exported by the 'Prelude'.
  , interact
  , putChar
  , putStr
  , putStrLn
  , print
  , getChar
  , getLine
  , getContents
  , readIO
  , readLn
  ) where

import "base" System.IO
