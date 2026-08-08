s/instance (?:Functor|Monad) (?:First|Last|Max|Min|NonEmpty|Solo)(?:\\\\|\r?\n)//g;
s/instance Functor (?:ArgDescr|ArgOrder|OptDescr|Arg a)(?:\\\\|\r?\n)//g;
s/instance (?:Functor|Monad(?:Fail|Plus)?) (?:P|ReadP)(?:\\\\|\r?\n)//g;
s/instance Monad m => (?:Functor|Monad) WrappedMonad m(?:\\\\|\r?\n)//g;
s/instance(?:\ Monoid a =>)? (?:Functor|Monad) Tuple2 a(?:\\\\|\r?\n)//g;
s/instance Arrow a => Functor WrappedArrow a b(?:\\\\|\r?\n)//g;
s/instance(?:\ \(Monoid a, Monoid b\) =>)? (?:Functor|Monad) Tuple3 a b(?:\\\\|\r?\n)//g;
s/instance \((?:Functor|Monad(?:Plus)?) f, (?:Functor|Monad(?:Plus)?) g\) => (?:Functor|Monad(?:Plus)?) Product f g(?:\\\\|\r?\n)//g;
s/instance \(Functor f, Functor g\) => Functor (?:Compose|Sum) f g(?:\\\\|\r?\n)//g;
s/instance(?:\ \(Monoid a, Monoid b, Monoid c\) =>)? (?:Functor|Monad) Tuple4 a b c(?:\\\\|\r?\n)//g;
s/instance Functor Tuple5 a b c d(?:\\\\|\r?\n)//g;
s/instance Functor Tuple6 a b c d e(?:\\\\|\r?\n)//g;
s/instance Functor Tuple7 a b c d e f(?:\\\\|\r?\n)//g;
s/instance IArray Array e(?:\\\\|\r?\n)//g;
s/instance (?:Foldable|Ix i => Traversable) Array i(?:\\\\|\r?\n)//g;
s/instance (?:Bits|Ix) (?:CBool|Natural)(?:\\\\|\r?\n)//g;
s/instance (?:IsChar|PrintfArg|IArray UArray) (?:Char|Int(?:8|16|32|64)?|Word(?:8|16|32|64)?|(?:Fun|Stable)?Ptr a)(?:\\\\|\r?\n)//g;
s/instance MArray (?:IOUArray|STUArray s) (?:Double|Float|Bool|Char|Int(?:8|16|32|64)?|Word(?:8|16|32|64)?|(?:Fun|Stable)?Ptr a|e) (?:ST s|IO)(?:\\\\|\r?\n)//g;
s/instance Generic Complex a(?:\\\\|\r?\n)//g;
s/instance (?:Foldable|Traversable) \((?:UChar|UWord|UAddr|UInt) :: Type -> Type\)(?:\\\\|\r?\n)//g;
s/instance Ix a => Ix Solo a(?:\\\\|\r?\n)//g;
s/instance (?:MonadFix|MonadZip|Eq1|Foldable1|Generic(?:1)?|Ord1|Read1|Show1|Alternative|Applicative|Semigroup a => (?:Monoid|Semigroup)) (?:Complex|Maybe|IO)(?:\\\\|\r?\n)//g;
s/instance FiniteBits (?:(?:Int|Word)(?:Ptr|8|16|32|64)?|(?:C|CS|CU)Char|(?:C|CU)(?:Short|Int(?:Ptr|Max)?)|(?:C|CU|CL|CUL)Long|CPtrdiff|CSize|CWchar|CSigAtomic)(?:\\\\|\r?\n)//g;
s/instance Storable (?:Fingerprint|CBool|(?:CSU|CU)Seconds|ConstPtr a)(?:\\\\|\r?\n)//g;
s/type instance Rep ExitCode = D1 \('MetaData "ExitCode" "GHC.Internal.IO.Exception" "ghc-internal" 'False\) \(C1 \('MetaCons "ExitSuccess" 'PrefixI 'False\) \(U1 :: Type -> Type\) :\+: C1 \('MetaCons "ExitFailure" 'PrefixI 'False\) \(S1 \('MetaSel \('Nothing :: Maybe Symbol\) 'NoSourceUnpackedness 'NoSourceStrictness 'DecidedLazy\) \(Rec0 Int\)\)\)//g;
s{
    type[ ]instance[ ]Rep[ ]ExitCode[ ]=[ ]
    D1[ ]\('MetaData[ ]"ExitCode"[ ]"GHC\.Internal\.IO\.Exception"[ ]"ghc-internal"[ ]'False\)[ ]
    \(
      C1[ ]
      \('MetaCons[ ]"ExitSuccess"[ ]'PrefixI[ ]'False\)[ ]
      \(\(U1[ ]::[ ]Type\\\\(\\[ ])+->[ ]Type\)\)[ ]
        :\+:[ ]
      C1[ ]\('MetaCons[ ]"ExitFailure"[ ]'PrefixI[ ]'False\)[ ]
      \(
        S1[ ]
        \(
          'MetaSel[ ]
          \(\('Nothing[ ]::[ ]Maybe[ ]Symbol\)\)[ ]
          'NoSourceUnpackedness[ ]
          'NoSourceStrictness[ ]
          'DecidedLazy
        \)[ ]
        \(Rec0[ ]Int\)
      \)
    \)
}{}x;
s/instance MonadIO IO(?:\\\\|\r?\n)//g;
s/instance Storable e => MArray StorableArray e IO(?:\\\\|\r?\n)//g;
s/instance MArray IOArray e IO(?:\\\\|\r?\n)//g;
s/instance a {\\char '176} \(\) => (?:H)?PrintfType IO a(?:\\\\|\r?\n)//g;
s/instance (?:Semigroup|Monoid) a => (?:Semigroup|Monoid) (?:Maybe|IO) a(?:\\\\|\r?\n)//g;
s/instance (?:Exception|Generic) ExitCode(?:\\\\|\r?\n)//g;
# For unknown reasons, Haddock 2.31.1 uses List rather than [] when documenting
# certain instances with LaTeX output:
s/instance (MonadFail|MonadPlus|Functor|Monad) List(\\\\)?/instance $1 {[}{]}$2/g;
# Remove problematic structures left behind after the removal of instances:
s/\\item\[\\begin\{tabular\}\{\@\{\}l\}\r?\n\r?\n\\end\{tabular\}\]\r?\n//g;
s/\\begin\{haddockdesc\}\r?\n\\end\{haddockdesc\}//g;
s{
    \\begin\{haddockdesc\}\r?\n
    \{\\haddockbegindoc\r?\n
    \\begin\{quote\}\r?\n
    \{\\haddockverb\\begin\{verbatim\}\r?\n
    >>>\ eq1\ \(1\ :\+\ 2\)\ \(1\ :\+\ 2\)\r?\n
    True\r?\n
    \r?\n
    \\end\{verbatim\}\}\r?\n
    \\end\{quote\}\r?\n
    \\begin\{quote\}\r?\n
    \{\\haddockverb\\begin\{verbatim\}\r?\n
    >>>\ eq1\ \(1\ :\+\ 2\)\ \(1\ :\+\ 3\)\r?\n
    False\r?\n
    \r?\n
    \\end\{verbatim\}\}\r?\n
    \\end\{quote\}\}\r?\n
    \\end\{haddockdesc\}\r?\n
    \\begin\{haddockdesc\}\r?\n
    \{\\haddockbegindoc\r?\n
    \\begin\{quote\}\r?\n
    \{\\haddockverb\\begin\{verbatim\}\r?\n
    >>>\ readPrec_to_S\ readPrec1\ 0\ "\(2\ %\ 3\)\ :\+\ \(3\ %\ 4\)"\ ::\ \[\(Complex\ Rational,\ String\)\]\r?\n
    \[\(2\ %\ 3\ :\+\ 3\ %\ 4,""\)\]\r?\n\r?\n
    \\end\{verbatim\}\}\r?\n
    \\end\{quote\}\}\r?\n
    \\end\{haddockdesc\}\r?\n
    \\begin\{haddockdesc\}\r?\n
    \{\\haddockbegindoc\r?\n
    \\begin\{quote\}\r?\n
    \{\\haddockverb\\begin\{verbatim\}\r?\n
    >>>\ showsPrec1\ 0\ \(2\ :\+\ 3\)\ ""\r?\n
    "2\ :\+\ 3"\r?\n
    \r?\n
    \\end\{verbatim\}\}\r?\n
    \\end\{quote\}\}\r?\n
    \\end\{haddockdesc\}\r?\n
}{}x;
s{
    type[ ]instance[ ]Rep1[ ]Complex[ ]=[ ]
    D1[ ]\('MetaData[ ]"Complex"[ ]"Data\.Complex"[ ]"base"[ ]'False\)[ ]
    \(
      C1[ ]
      \(
        'MetaCons[ ]":\+"[ ]\('InfixI[ ]'NotAssociative[ ]6\)[ ]
        'False
      \)[ ]
      \(
        S1[ ]
        \(
          'MetaSel[ ]\(\('Nothing[ ]::[ ]Maybe[ ]Symbol\)\)[ ]
          'NoSourceUnpackedness[ ]
          'SourceStrict[ ]
          'DecidedStrict
        \)[ ]
        Par1[ ]:\*:[ ]S1[ ]
        \(
          'MetaSel[ ]\(\('Nothing[ ]::[ ]Maybe[ ]Symbol\)\)[ ]
          'NoSourceUnpackedness[ ]
          'SourceStrict[ ]
          'DecidedStrict
        \)[ ]
        Par1
      \)
    \)\\\\
    type[ ]instance[ ]Rep[ ]Complex[ ]a[ ]=[ ]
    D1[ ]
    \('MetaData[ ]"Complex"[ ]"Data\.Complex"[ ]"base"[ ]'False\)[ ]
    \(
      C1[ ]
      \(
        'MetaCons[ ]":\+"[ ]\('InfixI[ ]'NotAssociative[ ]6\)[ ]
        'False
      \)[ ]
      \(
        S1[ ]
        \(
          'MetaSel[ ]\(\('Nothing[ ]::[ ]Maybe[ ]Symbol\)\)[ ]
          'NoSourceUnpackedness[ ]
          'SourceStrict[ ]
          'DecidedStrict
        \)[ ]
        \(Rec0[ ]a\)[ ]:\*:[ ]S1[ ]
        \(
          'MetaSel[ ]\(\('Nothing[ ]::[ ]Maybe[ ]Symbol\)\)[ ]
          'NoSourceUnpackedness[ ]
          'SourceStrict[ ]
          'DecidedStrict
        \)[ ]
        \(Rec0[ ]a\)
      \)
    \)
}{}x;
s{
    \\begin\{haddockdesc\}\r?\n
    \\item\[\\begin\{tabular\}\{@\{\}l\}\r?\n
    \\end\{tabular\}\]\r?\n
    \{\\haddockbegindoc\r?\n
    Lift\ a\ semigroup\ into\ \\haddockid\{Maybe\}\ forming\ a\ \\haddockid\{Monoid\}\ according\ to\r?\n
    \ \\url\{http://en\.wikipedia\.org/wiki/Monoid\}:\ "Any\ semigroup\ \\haddocktt\{S\}\ may\ be\r?\n
    \ turned\ into\ a\ monoid\ simply\ by\ adjoining\ an\ element\ \\haddocktt\{e\}\ not\ in\ \\haddocktt\{S\}\r?\n
    \ and\ defining\ \\haddocktt\{e\*e\ =\ e\}\ and\ \\haddocktt\{e\*s\ =\ s\ =\ s\*e\}\ for\ all\ \\haddocktt\{s\ ∈\ S\}\."\\par\r?\n
    \\emph\{Since\ 4\.11\.0\}:\ constraint\ on\ inner\ \\haddocktt\{a\}\ value\ generalised\ from\r?\n
    \ \\haddockid\{Monoid\}\ to\ \\haddockid\{Semigroup\}\.\\par\}\r?\n
    \\end\{haddockdesc\}\r?\n
}{}x;
s{
    \\begin\{haddockdesc\}\r?\n
    \{\\haddockbegindoc\r?\n
    Picks\ the\ leftmost\ \\haddockid\{Just\}\ value,\ or,\ alternatively,\ \\haddockid\{Nothing\}\.\\par\}\r?\n
    \\end\{haddockdesc\}\r?\n
}{}x;
