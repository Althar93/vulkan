{-# LANGUAGE RecordWildCards #-}

-- | Wrappers for the QuasiQuoters in 'Text.InterpolatedString.Perl6' which
-- remove indentation from the string passed to the quasiquoter.
--
--
-- @
-- trailingNewline :: Text
-- foo = [qci|
--   foo
--
--   |]
-- @
--
-- @
-- noTrailingNewline :: Text
-- noTrailingNewline = [qci|
--   foo
--   |]
-- @
module Text.InterpolatedString.Perl6.Unindented (qqi, qci, qi)where

import           Data.List
import           Language.Haskell.TH.Quote
import           Text.InterpolatedString.Perl6

wrapQuasi :: (String -> String) -> QuasiQuoter -> QuasiQuoter
wrapQuasi f QuasiQuoter {..} =
  QuasiQuoter (quoteExp . f) (quotePat . f) (quoteType . f) (quoteDec . f)

-- |
-- Strips empty lines from the beginning and end
-- Removed the common space prefix from the nonempty lines
unindent :: String -> String
unindent s
  = let
      stripEmptyLines = dropWhile (== "") . dropWhileEnd (== "")
      ls              = stripEmptyLines . lines $ s
      nonEmpties      = filter (/= "") ls
      minIndent       = case nonEmpties of
        [] -> 0
        _  -> minimum (length . takeWhile (== ' ') <$> nonEmpties)
      unindented = drop minIndent <$> ls
      noEmptyLastLine =
        if null (last unindented) then init unindented else unindented
    in
      intercalate "\n" noEmptyLastLine

qqi :: QuasiQuoter
qqi = wrapQuasi unindent qq

qci :: QuasiQuoter
qci = wrapQuasi unindent qc

qi :: QuasiQuoter
qi = wrapQuasi unindent q
