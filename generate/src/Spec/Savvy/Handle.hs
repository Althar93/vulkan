{-# LANGUAGE ApplicativeDo   #-}
{-# LANGUAGE RecordWildCards #-}

module Spec.Savvy.Handle
  ( Handle(..)
  , specHandles
  ) where

import           Data.Either.Validation
import qualified Data.HashSet           as HashSet
import           Data.Text
import           Data.Traversable
import           Language.C.Types.Parse
import           Spec.Savvy.Error
import           Spec.Savvy.Type
import qualified Spec.Spec              as P
import qualified Spec.Type              as P

import           Debug.Trace

data Handle = Handle
  { hName :: Text
  , hType :: Type
  }
  deriving (Show)

specHandles
  :: (Text -> Either [SpecError] Text)
  -- ^ Preprocessor
  -> TypeParseContext
  -> P.Spec
  -> Validation [SpecError] [Handle]
specHandles preprocess pc P.Spec {..}
  = let
      specHandles = [ h | P.AHandleType h <- sTypes ]
      handleNames = [ htName | P.HandleType {..} <- specHandles ]
      pc'         = CParserContext
        (cpcIdentName pc)
        (HashSet.filter ((`notElem` handleNames) . pack . unCIdentifier)
                        (cpcTypeNames pc)
        )
        (cpcParseIdent pc)
        (cpcIdentToString pc)
    in
      sequenceA
        [ eitherToValidation
          $   Handle htName
          <$> (   stringToTypeExpected pc' htName
              =<< traceShowId (preprocess htType)
              )
        | P.HandleType {..} <- specHandles
        ]

