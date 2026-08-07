-- MonadFail ( fail ) is added to the export list, and the Haddock documentation
-- updated accordingly.

-- |
-- Module: Control.Monad
--
-- The Control.Monad module provides the `Functor`, `Monad`, `MonadFail` and
-- `MonadPlus` classes, together with some useful operations on monads.
module Control.Monad
  ( -- * Functor and monad classes
    Functor ( fmap )
  , Monad ( (>>=), (>>), return )
  , MonadFail ( fail )
  , MonadPlus ( mzero, mplus )
    -- * Functions
    -- ** Naming conventions

    -- | The functions in this library use the following naming conventions:
    --
    -- *   A postfix ’M’ always stands for a function in the Kleisli category:
    --     The monad type constructor m is added to function results (modulo
    --     currying) and nowhere else. So, for example,
    --
    --     @
    --     filter :: (a -> Bool) -> [a] -> [a]
    --     filterM :: (Monad m) => (a -> m Bool) -> [a] -> m [a]
    --     @
    --
    -- *   A postfix ’_’ changes the result type from (m a) to (m ()). Thus,
    --     for example:
    --
    --     @
    --     sequence :: Monad m => [m a] -> m [a]
    --     sequence_ :: Monad m => [m a] -> m ()
    --     @
    --
    -- *   A prefix ’m’ generalizes an existing function to a monadic form.
    --     Thus, for example:
    --
    --     @
    --     sum :: Num a => [a] -> a
    --     msum :: MonadPlus m => [m a] -> m a
    --     @

    -- ** Basic `Monad` functions
  , mapM
  , mapM_
  , forM
  , forM_
  , sequence
  , sequence_
  , (=<<)
  , (>=>)
  , (<=<)
  , forever
  , void
    -- ** Generalisations of list functions
  , join
  , msum
  , filterM
  , mapAndUnzipM
  , zipWithM
  , zipWithM_
  , foldM
  , foldM_
  , replicateM
  , replicateM_
    -- ** Conditional execution of monadic expressions
  , guard
  , when
  , unless
    -- ** Monadic lifting operators
  , liftM
  , liftM2
  , liftM3
  , liftM4
  , liftM5
  , ap
  ) where

import "base" Control.Monad
