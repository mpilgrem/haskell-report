module Prelude
  ( module PreludeList
  , module PreludeText
  , module PreludeIO
  , Bool ( False, True )
  , Maybe ( Nothing, Just )
  , Either ( Left, Right )
  , Ordering ( LT, EQ, GT )
  , Char, String, Int, Integer, Float, Double, Rational, IO,

    -- These built-in types are defined in the Prelude, but are denoted by
    -- built-in syntax, and cannot legally appear in an export list:
    --     List type: []((:), [])
    --     Tuple types: (,)((,)), (,,)((,,)), etc.
    --     Trivial type: ()(())
    --     Functions: (->)

  , Eq ( (==), (/=) )
  , Ord ( compare, (<), (<=), (>=), (>), max, min )
  , Enum ( succ, pred, toEnum, fromEnum, enumFrom, enumFromThen, enumFromTo
      , enumFromThenTo
      )
  , Bounded ( minBound, maxBound )
  , Num ( (+), (-), (*), negate, abs, signum, fromInteger )
  , Real ( toRational )
  , Integral ( quot, rem, div, mod, quotRem, divMod, toInteger )
  , Fractional ( (/), recip, fromRational )
  , Floating ( pi, exp, log, sqrt, (**), logBase, sin, cos, tan, asin, acos
      , atan, sinh, cosh, tanh, asinh, acosh, atanh
      )
  , RealFrac ( properFraction, truncate, round, ceiling, floor )
  , RealFloat ( floatRadix, floatDigits, floatRange, decodeFloat, encodeFloat
      , exponent, significand, scaleFloat, isNaN, isInfinite, isDenormalized
      , isIEEE, isNegativeZero, atan2
      )
  , Semigroup ( (<>) )
  , Monoid ( mempty, mappend, mconcat )
  , Functor ( fmap, (<$) )
  , Applicative ( pure, (<*>), liftA2, (*>), (<*) )
  , Monad ( (>>=), (>>), return )
  , MonadFail ( fail )
  , (=<<)
  , Foldable ( elem, foldMap, foldr, foldl, foldl', foldr1, foldl1, maximum
      , minimum, sum, product
      )
  , null, length
  , notElem, and, or, any, all, concat, concatMap
  , Traversable ( traverse, sequenceA, mapM, sequence )
  , mapM_, sequence_
  , maybe, either
  , (&&), (||), not, otherwise
  , subtract, even, odd, gcd, lcm, (^), (^^)
  , fromIntegral, realToFrac
  , fst, snd, curry, uncurry, id, const, (.), flip, ($), until
  , asTypeOf, error, undefined
  , seq, ($!)
  ) where

import PreludeBuiltin                      -- Contains all `prim' values
import UnicodePrims( primUnicodeMaxChar )  -- Unicode primitives
import PreludeList
import PreludeText
import PreludeIO
import Data.Ratio( Rational )

infixr 9  .
infixr 8  ^, ^^, **
infixl 7  *, /, `quot`, `rem`, `div`, `mod`
infixl 6  +, -

-- The (:) operator is built-in syntax, and cannot legally be given
-- a fixity declaration; but its fixity is given by:
--   infixr 5  :

infix  4  ==, /=, <, <=, >=, >, `notElem`
infixr 3  &&
infixr 2  ||
infixl 1  >>, >>=
infixr 1  =<<
infixr 0  $, $!, `seq`

-- Standard types, classes, instances and related functions

-- Equality and Ordered classes

class  Eq a  where
    (==), (/=) :: a -> a -> Bool

        -- Minimal complete definition:
        --      (==) or (/=)
    x /= y     =  not (x == y)
    x == y     =  not (x /= y)

class  (Eq a) => Ord a  where
    compare              :: a -> a -> Ordering
    (<), (<=), (>=), (>) :: a -> a -> Bool
    max, min             :: a -> a -> a

        -- Minimal complete definition:
        --      (<=) or compare
        -- Using compare can be more efficient for complex types.
    compare x y
         | x == y    =  EQ
         | x <= y    =  LT
         | otherwise =  GT

    x <= y           =  compare x y /= GT
    x <  y           =  compare x y == LT
    x >= y           =  compare x y /= LT
    x >  y           =  compare x y == GT

-- note that (min x y, max x y) = (x,y) or (y,x)
    max x y
         | x <= y    =  y
         | otherwise =  x
    min x y
         | x <= y    =  x
         | otherwise =  y

-- Enumeration and Bounded classes

class  Enum a  where
    succ, pred       :: a -> a
    toEnum           :: Int -> a
    fromEnum         :: a -> Int
    enumFrom         :: a -> [a]             -- [n..]
    enumFromThen     :: a -> a -> [a]        -- [n,n'..]
    enumFromTo       :: a -> a -> [a]        -- [n..m]
    enumFromThenTo   :: a -> a -> a -> [a]   -- [n,n'..m]

        -- Minimal complete definition:
        --      toEnum, fromEnum
	--
	-- NOTE: these default methods only make sense for types
	-- 	 that map injectively into Int using fromEnum
	--	 and toEnum.
    succ             =  toEnum . (+1) . fromEnum
    pred             =  toEnum . (subtract 1) . fromEnum
    enumFrom x       =  map toEnum [fromEnum x ..]
    enumFromTo x y   =  map toEnum [fromEnum x .. fromEnum y]
    enumFromThen x y =  map toEnum [fromEnum x, fromEnum y ..]
    enumFromThenTo x y z =
                        map toEnum [fromEnum x, fromEnum y .. fromEnum z]

class  Bounded a  where
    minBound         :: a
    maxBound         :: a

-- Numeric classes

class  (Eq a, Show a) => Num a  where
    (+), (-), (*)    :: a -> a -> a
    negate           :: a -> a
    abs, signum      :: a -> a
    fromInteger      :: Integer -> a

        -- Minimal complete definition:
        --      All, except negate or (-)
    x - y            =  x + negate y
    negate x         =  0 - x

class  (Num a, Ord a) => Real a  where
    toRational       ::  a -> Rational

class  (Real a, Enum a) => Integral a  where
    quot, rem        :: a -> a -> a
    div, mod         :: a -> a -> a
    quotRem, divMod  :: a -> a -> (a,a)
    toInteger        :: a -> Integer

        -- Minimal complete definition:
        --      quotRem, toInteger
    n `quot` d       =  q  where (q,r) = quotRem n d
    n `rem` d        =  r  where (q,r) = quotRem n d
    n `div` d        =  q  where (q,r) = divMod n d
    n `mod` d        =  r  where (q,r) = divMod n d
    divMod n d       =  if signum r == - signum d then (q-1, r+d) else qr
                        where qr@(q,r) = quotRem n d

class  (Num a) => Fractional a  where
    (/)              :: a -> a -> a
    recip            :: a -> a
    fromRational     :: Rational -> a

        -- Minimal complete definition:
        --      fromRational and (recip or (/))
    recip x          =  1 / x
    x / y            =  x * recip y

class  (Fractional a) => Floating a  where
    pi                  :: a
    exp, log, sqrt      :: a -> a
    (**), logBase       :: a -> a -> a
    sin, cos, tan       :: a -> a
    asin, acos, atan    :: a -> a
    sinh, cosh, tanh    :: a -> a
    asinh, acosh, atanh :: a -> a

        -- Minimal complete definition:
        --      pi, exp, log, sin, cos, sinh, cosh
        --      asin, acos, atan
        --      asinh, acosh, atanh
    x ** y           =  exp (log x * y)
    logBase x y      =  log y / log x
    sqrt x           =  x ** 0.5
    tan  x           =  sin  x / cos  x
    tanh x           =  sinh x / cosh x


class  (Real a, Fractional a) => RealFrac a  where
    properFraction   :: (Integral b) => a -> (b,a)
    truncate, round  :: (Integral b) => a -> b
    ceiling, floor   :: (Integral b) => a -> b

        -- Minimal complete definition:
        --      properFraction
    truncate x       =  m  where (m,_) = properFraction x

    round x          =  let (n,r) = properFraction x
                            m     = if r < 0 then n - 1 else n + 1
                          in case signum (abs r - 0.5) of
                                -1 -> n
                                0  -> if even n then n else m
                                1  -> m

    ceiling x        =  if r > 0 then n + 1 else n
                        where (n,r) = properFraction x

    floor x          =  if r < 0 then n - 1 else n
                        where (n,r) = properFraction x

class  (RealFrac a, Floating a) => RealFloat a  where
    floatRadix       :: a -> Integer
    floatDigits      :: a -> Int
    floatRange       :: a -> (Int,Int)
    decodeFloat      :: a -> (Integer,Int)
    encodeFloat      :: Integer -> Int -> a
    exponent         :: a -> Int
    significand      :: a -> a
    scaleFloat       :: Int -> a -> a
    isNaN, isInfinite, isDenormalized, isNegativeZero, isIEEE
                     :: a -> Bool
    atan2            :: a -> a -> a

        -- Minimal complete definition:
        --      All except exponent, significand,
        --                 scaleFloat, atan2
    exponent x       =  if m == 0 then 0 else n + floatDigits x
                        where (m,n) = decodeFloat x

    significand x    =  encodeFloat m (- floatDigits x)
                        where (m,_) = decodeFloat x

    scaleFloat k x   =  encodeFloat m (n+k)
                        where (m,n) = decodeFloat x

    atan2 y x
      | x>0           =  atan (y/x)
      | x==0 && y>0   =  pi/2
      | x<0  && y>0   =  pi + atan (y/x)
      |(x<=0 && y<0)  ||
       (x<0 && isNegativeZero y) ||
       (isNegativeZero x && isNegativeZero y)
                      = -atan2 (-y) x
      | y==0 && (x<0 || isNegativeZero x)
                      =  pi    -- must be after the previous test on zero y
      | x==0 && y==0  =  y     -- must be after the other double zero tests
      | otherwise     =  x + y -- x or y is a NaN, return a NaN (via +)

-- Numeric functions

subtract         :: (Num a) => a -> a -> a
subtract         =  flip (-)

even, odd        :: (Integral a) => a -> Bool
even n           =  n `rem` 2 == 0
odd              =  not . even

gcd              :: (Integral a) => a -> a -> a
gcd 0 0          =  error "Prelude.gcd: gcd 0 0 is undefined"
gcd x y          =  gcd' (abs x) (abs y)
                    where gcd' x 0  =  x
                          gcd' x y  =  gcd' y (x `rem` y)

lcm              :: (Integral a) => a -> a -> a
lcm _ 0          =  0
lcm 0 _          =  0
lcm x y          =  abs ((x `quot` (gcd x y)) * y)

(^)              :: (Num a, Integral b) => a -> b -> a
x ^ 0            =  1
x ^ n | n > 0    =  f x (n-1) x
                    where f _ 0 y = y
                          f x n y = g x n  where
                                    g x n | even n  = g (x*x) (n `quot` 2)
                                          | otherwise = f x (n-1) (x*y)
_ ^ _            = error "Prelude.^: negative exponent"

(^^)             :: (Fractional a, Integral b) => a -> b -> a
x ^^ n           =  if n >= 0 then x^n else recip (x^(-n))

fromIntegral     :: (Integral a, Num b) => a -> b
fromIntegral     =  fromInteger . toInteger

realToFrac     :: (Real a, Fractional b) => a -> b
realToFrac      =  fromRational . toRational

-- Monadic classes

class  Functor f  where
    fmap              :: (a -> b) -> f a -> f b
    (<$)              :: a -> f b -> f a
    (<$)              =  fmap . const

-- | A functor with application, providing operations to
--
-- * embed pure expressions ('pure'), and
--
-- * sequence computations and combine their results ('<*>' and 'liftA2').
--
-- Any definition must satisfy the following:
--
-- [Identity]
--
--      @'pure' 'id' '<*>' v = v@
--
-- [Composition]
--
--      @'pure' (.) '<*>' u '<*>' v '<*>' w = u '<*>' (v '<*>' w)@
--
-- [Homomorphism]
--
--      @'pure' f '<*>' 'pure' x = 'pure' (f x)@
--
-- [Interchange]
--
--      @u '<*>' 'pure' y = 'pure' ('$' y) '<*>' u@
--
--
-- The other methods have the following default definitions, which may
-- be overridden with equivalent specialized implementations:
--
--   * @u '*>' v = ('id' '<$' u) '<*>' v@
--
--   * @u '<*' v = 'liftA2' 'const' u v@
--
-- As a consequence of these laws, the 'Functor' instance for @f@ will satisfy
--
--   * @'fmap' f x = 'pure' f '<*>' x@
--
--
-- It may be useful to note that supposing
--
--      @forall x y. p (q x y) = f x . g y@
--
-- it follows from the above that
--
--      @'liftA2' p ('liftA2' q u v) = 'liftA2' f u . 'liftA2' g v@
--
--
-- If @f@ is also a 'Monad', it should satisfy
--
--   * @'pure' = 'return'@
--
--   * @m1 '<*>' m2 = m1 '>>=' (\\x1 -> m2 '>>=' (\\x2 -> 'return' (x1 x2)))@
--
--   * @('*>') = ('>>')@
--
-- (which implies that 'pure' and '<*>' satisfy the applicative functor laws).

class Functor f => Applicative f where
  -- | Lift a value into the Structure.
  pure :: a -> f a

  -- | Sequential application.
  (<*>) :: f (a -> b) -> f a -> f b
  (<*>) = liftA2 id

  -- | Lift a binary function to actions.
  liftA2 :: (a -> b -> c) -> f a -> f b -> f c
  liftA2 f x = (<*>) (fmap f x)

  -- | Sequence actions, discarding the value of the first argument.
  (*>) :: f a -> f b -> f b
  a1 *> a2 = (id <$ a1) <*> a2

  -- | Sequence actions, discarding the value of the second argument.
  (<*) :: f a -> f b -> f a
  (<*) = liftA2 const

class  Applicative m => Monad m where
  (>>=)  :: m a -> (a -> m b) -> m b
  (>>)   :: m a -> m b -> m b
  return :: a -> m a

  -- Minimal complete definition:
  --      (>>=), return
  m >> k  =  m >>= \_ -> k

class  Monad m => MonadFail m where
  fail   :: String -> m a
  fail s  = error s

(=<<)            :: Monad m => (a -> m b) -> m a -> m b
f =<< x          =  x >>= f

-- Trivial type

data  ()  =  ()  deriving (Eq, Ord, Enum, Bounded)
	-- Not legal Haskell; for illustration only

-- Function type

-- identity function
id               :: a -> a
id x             =  x

-- constant function
const            :: a -> b -> a
const x _        =  x

-- function composition
(.)              :: (b -> c) -> (a -> b) -> a -> c
f . g            =  \ x -> f (g x)

-- flip f  takes its (first) two arguments in the reverse order of f.
flip             :: (a -> b -> c) -> b -> a -> c
flip f x y       =  f y x

seq :: a -> b -> b
seq = ...       -- Primitive

-- right-associating infix application operators
-- (useful in continuation-passing style)
($), ($!) :: (a -> b) -> a -> b
f $  x    =  f x
f $! x    =  x `seq` f x


-- Boolean type

data  Bool  =  False | True     deriving (Eq, Ord, Enum, Read, Show, Bounded)

-- Boolean functions

(&&), (||)       :: Bool -> Bool -> Bool
True  && x       =  x
False && _       =  False
True  || _       =  True
False || x       =  x

not              :: Bool -> Bool
not True         =  False
not False        =  True

otherwise        :: Bool
otherwise        =  True


-- Character type

data Char = ... 'a' | 'b' ... -- Unicode values

instance  Eq Char  where
    c == c'          =  fromEnum c == fromEnum c'

instance  Ord Char  where
    c <= c'          =  fromEnum c <= fromEnum c'

instance  Enum Char  where
    toEnum            = primIntToChar
    fromEnum          = primCharToInt
    enumFrom c        = map toEnum [fromEnum c .. fromEnum (maxBound::Char)]
    enumFromThen c c' = map toEnum [fromEnum c, fromEnum c' .. fromEnum lastChar]
                      where lastChar :: Char
                            lastChar | c' < c    = minBound
                                     | otherwise = maxBound

instance  Bounded Char  where
    minBound  =  '\0'
    maxBound  =  primUnicodeMaxChar

type  String = [Char]


-- Maybe type

data  Maybe a  =  Nothing | Just a      deriving (Eq, Ord, Read, Show)

maybe              :: b -> (a -> b) -> Maybe a -> b
maybe n f Nothing  =  n
maybe n f (Just x) =  f x

instance  Functor Maybe  where
    fmap f Nothing    =  Nothing
    fmap f (Just x)   =  Just (f x)

instance  Monad Maybe  where
    (Just x) >>= k   =  k x
    Nothing  >>= k   =  Nothing
    return           =  Just
    fail s           =  Nothing

-- Either type

data  Either a b  =  Left a | Right b   deriving (Eq, Ord, Read, Show)

either               :: (a -> c) -> (b -> c) -> Either a b -> c
either f g (Left x)  =  f x
either f g (Right y) =  g y

-- IO type

data IO a = ... 	-- abstract

instance  Functor IO where
   fmap f x           =  x >>= (return . f)

instance Monad IO where
   (>>=)  = ...
   return = ...
   fail s = ioError (userError s)

-- Ordering type

data  Ordering  =  LT | EQ | GT
          deriving (Eq, Ord, Enum, Read, Show, Bounded)


-- Standard numeric types.  The data declarations for these types cannot
-- be expressed directly in Haskell since the constructor lists would be
-- far too large.

data  Int  =  minBound ... -1 | 0 | 1 ... maxBound
instance  Eq       Int  where ...
instance  Ord      Int  where ...
instance  Num      Int  where ...
instance  Real     Int  where ...
instance  Integral Int  where ...
instance  Enum     Int  where ...
instance  Bounded  Int  where ...

data  Integer  =  ... -1 | 0 | 1 ...
instance  Eq       Integer  where ...
instance  Ord      Integer  where ...
instance  Num      Integer  where ...
instance  Real     Integer  where ...
instance  Integral Integer  where ...
instance  Enum     Integer  where ...

data  Float
instance  Eq         Float  where ...
instance  Ord        Float  where ...
instance  Num        Float  where ...
instance  Real       Float  where ...
instance  Fractional Float  where ...
instance  Floating   Float  where ...
instance  RealFrac   Float  where ...
instance  RealFloat  Float  where ...

data  Double
instance  Eq         Double  where ...
instance  Ord        Double  where ...
instance  Num        Double  where ...
instance  Real       Double  where ...
instance  Fractional Double  where ...
instance  Floating   Double  where ...
instance  RealFrac   Double  where ...
instance  RealFloat  Double  where ...

-- The Enum instances for Floats and Doubles are slightly unusual.
-- The `toEnum' function truncates numbers to Int.  The definitions
-- of enumFrom and enumFromThen allow floats to be used in arithmetic
-- series: [0,0.1 .. 0.95].  However, roundoff errors make these somewhat
-- dubious.  This example may have either 10 or 11 elements, depending on
-- how 0.1 is represented.

instance  Enum Float  where
    succ x           =  x+1
    pred x           =  x-1
    toEnum           =  fromIntegral
    fromEnum         =  fromInteger . truncate   -- may overflow
    enumFrom         =  numericEnumFrom
    enumFromThen     =  numericEnumFromThen
    enumFromTo       =  numericEnumFromTo
    enumFromThenTo   =  numericEnumFromThenTo

instance  Enum Double  where
    succ x           =  x+1
    pred x           =  x-1
    toEnum           =  fromIntegral
    fromEnum         =  fromInteger . truncate   -- may overflow
    enumFrom         =  numericEnumFrom
    enumFromThen     =  numericEnumFromThen
    enumFromTo       =  numericEnumFromTo
    enumFromThenTo   =  numericEnumFromThenTo

numericEnumFrom         :: (Fractional a) => a -> [a]
numericEnumFromThen     :: (Fractional a) => a -> a -> [a]
numericEnumFromTo       :: (Fractional a, Ord a) => a -> a -> [a]
numericEnumFromThenTo   :: (Fractional a, Ord a) => a -> a -> a -> [a]
numericEnumFrom         =  iterate (+1)
numericEnumFromThen n m =  iterate (+(m-n)) n
numericEnumFromTo n m   =  takeWhile (<= m+1/2) (numericEnumFrom n)
numericEnumFromThenTo n n' m = takeWhile p (numericEnumFromThen n n')
                             where
                               p | n' >= n   = (<= m + (n'-n)/2)
                                 | otherwise = (>= m + (n'-n)/2)

-- Lists

data  [a]  =  [] | a : [a]  deriving (Eq, Ord)
	-- Not legal Haskell; for illustration only

instance Functor [] where
    fmap = map

instance  Monad []  where
    m >>= k          = concat (map k m)
    return x         = [x]
    fail s           = []

-- | Non-empty (and non-strict) list type.
data NonEmpty a = a :| [a]

-- | The class of semigroups (types with an associative binary operation).
--
-- Instances should satisfy the following:
--
-- [Associativity] @x '<>' (y '<>' z) = (x '<>' y) '<>' z@
--
-- You can alternatively define `sconcat` instead of (`<>`), in which case the
-- laws are:
--
-- [Unit]: @'sconcat' ('pure' x) = x@
-- [Multiplication]: @'sconcat' ('join' xss) = 'sconcat' ('fmap' 'sconcat' xss)@
--
-- @since base-4.9.0.0
class Semigroup a where
  -- | An associative operation.
  (<>) :: a -> a -> a
  a <> b = go a [ b ]
   where
    go c (d : ds) = c <> go d ds
    go c []       = c

-- | The class of monoids (types with an associative binary operation that
-- has an identity).  Instances should satisfy the following:
--
-- [Right identity] @x '<>' 'mempty' = x@
-- [Left identity]  @'mempty' '<>' x = x@
-- [Associativity]  @x '<>' (y '<>' z) = (x '<>' y) '<>' z@ ('Semigroup' law)
-- [Concatenation]  @'mconcat' = 'foldr' ('<>') 'mempty'@
--
-- You can alternatively define `mconcat` instead of `mempty`, in which case the
-- laws are:
--
-- [Unit]: @'mconcat' ('pure' x) = x@
-- [Multiplication]: @'mconcat' ('join' xss) = 'mconcat' ('fmap' 'mconcat' xss)@
-- [Subclass]: @'mconcat' ('toList' xs) = 'sconcat' xs@
--
-- The method names refer to the monoid of lists under concatenation,
-- but there are many other instances.
--
-- Some types can be viewed as a monoid in more than one way,
-- e.g. both addition and multiplication on numbers.
-- In such cases we often define @newtype@s and make those instances
-- of 'Monoid', e.g. 'Data.Semigroup.Sum' and 'Data.Semigroup.Product'.
class Semigroup a => Monoid a where
  -- | Identity of 'mappend'
  mempty :: a
  mempty = mconcat []

  -- | An associative operation
  mappend :: a -> a -> a
  mappend = (<>)

  -- | Fold a list using the monoid.
  mconcat :: [a] -> a
  mconcat = foldr mappend mempty

class Foldable t where

  -- | Does the element occur in the structure?
  elem :: Eq a => a -> t a -> Bool
  elem = any . (==)

  -- | Map each element of the structure into a monoid, and combine the
  -- results with @('<>')@.  This fold is right-associative and lazy in the
  -- accumulator.
  foldMap :: Monoid m => (a -> m) -> t a -> m
  foldMap f = foldr (mappend . f) mempty

  -- | Right-associative fold of a structure, lazy in the accumulator.
  --
  -- In the case of lists, 'foldr', when applied to a binary operator, a
  -- starting value (typically the right-identity of the operator), and a
  -- list, reduces the list using the binary operator, from right to left:
  --
  -- > foldr f z [x1, x2, ..., xn] == x1 `f` (x2 `f` ... (xn `f` z)...)
  --
  -- Note that since the head of the resulting expression is produced by an
  -- application of the operator to the first element of the list, given an
  -- operator lazy in its right argument, 'foldr' can produce a terminating
  -- expression from an unbounded list.
  --
  -- For a general 'Foldable' structure this should be semantically identical
  -- to,
  --
  -- @foldr f z = 'List.foldr' f z . 'toList'@
  foldr :: (a -> b -> b) -> b -> t a -> b
  foldr f z t = appEndo (foldMap (Endo #. f) t) z

  -- | Left-associative fold of a structure, lazy in the accumulator.  This
  -- is rarely what you want, but can work well for structures with efficient
  -- right-to-left sequencing and an operator that is lazy in its left
  -- argument.
  --
  -- In the case of lists, 'foldl', when applied to a binary operator, a
  -- starting value (typically the left-identity of the operator), and a
  -- list, reduces the list using the binary operator, from left to right:
  --
  -- > foldl f z [x1, x2, ..., xn] == (...((z `f` x1) `f` x2) `f`...) `f` xn
  --
  -- Note that to produce the outermost application of the operator the
  -- entire input list must be traversed.  Like all left-associative folds,
  -- 'foldl' will diverge if given an infinite list.
  --
  -- For a general 'Foldable' structure this should be semantically identical
  -- to:
  --
  -- @foldl f z = 'List.foldl' f z . 'toList'@
  foldl :: (b -> a -> b) -> b -> t a -> b
  foldl f z t = appEndo (getDual (foldMap (Dual . Endo . flip f) t)) z

  -- | Left-associative fold of a structure but with strict application of
  -- the operator.
  --
  -- This ensures that each step of the fold is forced to Weak Head Normal
  -- Form before being applied, avoiding the collection of thunks that would
  -- otherwise occur.  This is often what you want to strictly reduce a
  -- finite structure to a single strict result (e.g. 'sum').
  --
  -- For a general 'Foldable' structure this should be semantically identical
  -- to,
  --
  -- @foldl' f z = 'List.foldl'' f z . 'toList'@
  foldl' :: (b -> a -> b) -> b -> t a -> b
  foldl' f z0 = \ xs ->
      foldr (\ (x::a) (k::b->b) -> oneShot (\ (z::b) -> z `seq` k (f z x)))
            (id::b->b) xs z0

  -- | A variant of 'foldr' that has no base case,
  -- and thus may only be applied to non-empty structures.
  --
  -- This function is non-total and will raise a runtime exception if the
  -- structure happens to be empty.
  foldr1 :: (a -> a -> a) -> t a -> a
  foldr1 f xs = fromMaybe (errorWithoutStackTrace "foldr1: empty structure")
                  (foldr mf Nothing xs)
   where
    mf x m = Just (case m of
                     Nothing -> x
                     Just y  -> f x y)

  -- | A variant of 'foldl' that has no base case,
  -- and thus may only be applied to non-empty structures.
  --
  -- This function is non-total and will raise a runtime exception if the
  -- structure happens to be empty.
  --
  -- @'foldl1' f = 'List.foldl1' f . 'toList'@
  foldl1 :: (a -> a -> a) -> t a -> a
  foldl1 f xs = fromMaybe (errorWithoutStackTrace "foldl1: empty structure")
                  (foldl mf Nothing xs)
   where
    mf m y = Just (case m of
                     Nothing -> y
                     Just x  -> f x y)

  -- | The largest element of a non-empty structure. This function is
  -- equivalent to @'foldr1' 'max'@, and its behavior on structures with
  -- multiple largest elements depends on the relevant implementation of
  -- 'max'. For the default implementation of 'max' (@max x y = if x <= y
  -- then y else x@), structure order is used as a tie-breaker: if there are
  -- multiple largest elements, the rightmost of them is chosen (this is
  -- equivalent to @'maximumBy' 'compare'@).
  --
  -- This function is non-total and will raise a runtime exception if the
  -- structure happens to be empty.  A structure that supports random access
  -- and maintains its elements in order should provide a specialised
  -- implementation to return the maximum in faster than linear time.
  maximum :: forall a . Ord a => t a -> a
  maximum = fromMaybe (errorWithoutStackTrace "maximum: empty structure") .
     getMax . foldMap' (Max #. (Just :: a -> Maybe a))

  -- | The least element of a non-empty structure. This function is
  -- equivalent to @'foldr1' 'min'@, and its behavior on structures with
  -- multiple largest elements depends on the relevant implementation of
  -- 'min'. For the default implementation of 'min' (@min x y = if x <= y
  -- then x else y@), structure order is used as a tie-breaker: if there are
  -- multiple least elements, the leftmost of them is chosen (this is
  -- equivalent to @'minimumBy' 'compare'@).
  --
  -- This function is non-total and will raise a runtime exception if the
  -- structure happens to be empty.  A structure that supports random access
  -- and maintains its elements in order should provide a specialised
  -- implementation to return the minimum in faster than linear time.
  minimum :: forall a . Ord a => t a -> a
  minimum = fromMaybe (errorWithoutStackTrace "minimum: empty structure") .
    getMin . foldMap' (Min #. (Just :: a -> Maybe a))

  -- | The 'sum' function computes the sum of the numbers of a structure.
  sum :: Num a => t a -> a
  sum = getSum #. foldMap' Sum

  -- | The 'product' function computes the product of the numbers of a
  -- structure.
  product :: Num a => t a -> a
  product = getProduct #. foldMap' Product

-- | Test whether the structure is empty.  The default implementation is
-- Left-associative and lazy in both the initial element and the
-- accumulator.  Thus optimised for structures where the first element can
-- be accessed in constant time.  Structures where this is not the case
-- should have a non-default implementation.
null :: t a -> Bool
null = foldr (\_ _ -> False) True

-- | Returns the size/length of a finite structure as an 'Int'.  The
-- default implementation just counts elements starting with the leftmost.
-- Instances for structures that can compute the element count faster
-- than via element-by-element counting, should provide a specialised
-- implementation.
length :: t a -> Int
length = foldl' (\c _ -> c + 1) 0

-- notElem is the negation of elem.
notElem    :: (Eq a, Foldable t) => a -> t a -> Bool
notElem x        =  all (/= x)

-- and returns the conjunction of a Boolean list.  For the result to be
-- True, the list must be finite; False, however, results from a False
-- value at a finite index of a finite or infinite list.  or is the
-- disjunctive dual of and.
and, or          :: Foldable t => t Bool -> Bool
and              =  foldr (&&) True
or               =  foldr (||) False

-- Applied to a predicate and a list, any determines if any element
-- of the list satisfies the predicate.  Similarly, for all.
any, all         :: Foldable t => (a -> Bool) -> t a -> Bool
any p            =  or . map p
all p            =  and . map p

-- The concatenation of all the elements of a container of lists.
concat           :: Foldable t => t [a] -> [a]
concat xss       = foldr (++) [] xss

-- Map a function over all the elements of a container and concatenate the
-- resulting lists.
concatMap        :: Foldable t => (a -> [b]) -> t a -> [b]
concatMap f      = concat . map f

-- | Functors representing data structures that can be transformed to
-- structures of the /same shape/ by performing an 'Applicative' (or,
-- therefore, 'Monad') action on each element from left to right.
--
-- A more detailed description of what /same shape/ means, the various methods,
-- how traversals are constructed, and example advanced use-cases can be found
-- in the __Overview__ section of "Data.Traversable#overview".
--
-- For the class laws see the __Laws__ section of "Data.Traversable#laws".
--
class (Functor t, Foldable t) => Traversable t where

  -- | Map each element of a structure to an action, evaluate these actions
  -- from left to right, and collect the results. For a version that ignores
  -- the results see 'Data.Foldable.traverse_'.
  traverse :: Applicative f => (a -> f b) -> t a -> f (t b)
  traverse f = sequenceA . fmap f

  -- | Evaluate each action in the structure from left to right, and
  -- collect the results. For a version that ignores the results
  -- see 'Data.Foldable.sequenceA_'.
  sequenceA :: Applicative f => t (f a) -> f (t a)
  sequenceA = traverse id

  -- | Map each element of a structure to a monadic action, evaluate
  -- these actions from left to right, and collect the results. For
  -- a version that ignores the results see 'Data.Foldable.mapM_'.
  mapM :: Monad m => (a -> m b) -> t a -> m (t b)
  mapM = traverse

  -- | Evaluate each monadic action in the structure from left to
  -- right, and collect the results. For a version that ignores the
  -- results see 'Data.Foldable.sequence_'.
  sequence :: Monad m => t (m a) -> m (t a)
  sequence = sequenceA

sequence_ :: (Foldable t, Monad m) => t (m a) -> m ()
sequence_ =  foldr (>>) (pure ())

mapM_            :: (Foldable t, Monad m) => (a -> m b) -> t a -> m ()
mapM_ f as       =  sequence_ (traverse f as)

-- Tuples

data  (a,b)   =  (a,b)    deriving (Eq, Ord, Bounded)
data  (a,b,c) =  (a,b,c)  deriving (Eq, Ord, Bounded)
	-- Not legal Haskell; for illustration only

-- component projections for pairs:
-- (NB: not provided for triples, quadruples, etc.)
fst              :: (a,b) -> a
fst (x,y)        =  x

snd              :: (a,b) -> b
snd (x,y)        =  y

-- curry converts an uncurried function to a curried function;
-- uncurry converts a curried function to a function on pairs.
curry            :: ((a, b) -> c) -> a -> b -> c
curry f x y      =  f (x, y)

uncurry          :: (a -> b -> c) -> ((a, b) -> c)
uncurry f p      =  f (fst p) (snd p)

-- Misc functions

-- until p f  yields the result of applying f until p holds.
until            :: (a -> Bool) -> (a -> a) -> a -> a
until p f x
     | p x       =  x
     | otherwise =  until p f (f x)

-- asTypeOf is a type-restricted version of const.  It is usually used
-- as an infix operator, and its typing forces its first argument
-- (which is usually overloaded) to have the same type as the second.
asTypeOf         :: a -> a -> a
asTypeOf         =  const

-- error stops execution and displays an error message

error            :: String -> a
error            =  primError

-- It is expected that compilers will recognize this and insert error
-- messages that are more appropriate to the context in which undefined
-- appears.

undefined        :: a
undefined        =  error "Prelude.undefined"
