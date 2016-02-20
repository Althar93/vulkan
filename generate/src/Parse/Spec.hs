{-# LANGUAGE Arrows #-}
{-# LANGUAGE RecordWildCards #-}

module Parse.Spec
  ( parseSpec
  ) where

import Spec
import Parse.Bitmask
import Parse.CType
import Parse.Command
import Parse.Enum
import Parse.Type
import Parse.Utils
import Text.XML.HXT.Core
import Safe(headMay)
import Control.Monad.IO.Class(MonadIO, liftIO)

parseSpec :: MonadIO m => String -> m (Maybe Spec)
parseSpec s = liftIO $ let doc = readString [withWarnings yes] s 
                       in headMay <$> 
                          runX (withOtherUserState initialSpecParseState 
                                (doc >>> oneRequired "spec" parseSpecXML))

parseSpecXML :: ParseArrow XmlTree Spec
parseSpecXML = isRoot /> hasName "registry" >>> extract
  where extract = proc registry -> do
          sTypes <- parseTypes <<< getChildren -< registry
          sEnums <- listA (deep parseEnum) -< registry
          sBitmasks <- listA (deep parseBitmask) -< registry
          sCommands <- listA (deep parseCommand) <<< 
                      onlyChildWithName "commands" -< registry
          sCopyright <- getAllText <<< onlyChildWithName "comment" -< registry
          returnA -< Spec{..}

