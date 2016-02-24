{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TupleSections #-}

module Write.Spec
  ( haskellize
  , writeSpecModules
  ) where

import Data.Maybe(catMaybes)
import Spec.Spec
import Spec.Type
import Text.InterpolatedString.Perl6
import Write.Constant
import Write.Enum
import Write.Header as H hiding (ModuleName)
import Write.Type.Base
import Write.Type.Bitmask
import Write.Type.FuncPointer
import Write.Type.Handle
import Write.Type.Struct
import Write.TypeConverter
import Write.Command

import Spec.Graph
import Spec.Partition
import Write.Module
import Write.Utils
import qualified Data.HashSet as S
import qualified Data.HashMap.Strict as M
import System.Directory (createDirectoryIfMissing)
import System.FilePath ((</>), (<.>))
import Data.List.Split(splitOn)
import Data.List(foldl1')

writeSpecModules :: FilePath -> Spec -> IO ()
writeSpecModules directory spec = do
  let modules = getSpecModules spec
      createParents = True
  createDirectoryIfMissing createParents (directory </> "Graphics" </> "Vulkan")
  mapM_ (uncurry (writeModuleFile directory)) modules

writeModuleFile :: FilePath -> ModuleName -> String -> IO ()
writeModuleFile directory moduleName = 
  writeFile (directory </> moduleNameToFile moduleName)

moduleNameToFile :: ModuleName -> FilePath
moduleNameToFile (ModuleName moduleName) = 
  let pathComponents = splitOn "." moduleName 
  in foldl1' (</>) pathComponents <.> "hs"

getSpecModules :: Spec -> [(ModuleName, String)]
getSpecModules spec =
  let graph = getSpecGraph spec
      partitions = partitionSpec (sSections spec) graph
      exclusiveModules = 
        partitionExclusiveModule <$> M.toList (sectionNames partitions)
      -- otherModule = (ModuleName "Graphics.Vulkan.Other", 
                     -- S.toList (otherNames partitions))
      modules = exclusiveModules
      locations = M.unions (uncurry exportMap <$> modules)
      moduleNames = fst <$> modules
      moduleStrings = uncurry (writeModule graph locations) <$> modules
  in zip moduleNames moduleStrings

exportMap :: ModuleName -> [String] -> M.HashMap String ModuleName
exportMap moduleName exports = M.fromList ((,moduleName) <$> exports)

partitionExclusiveModule :: (String, S.HashSet String) -> (ModuleName, [String])
partitionExclusiveModule (sectionName, names) = 
  (sectionNameToModuleName sectionName, S.toList names)

haskellize :: Spec -> String
haskellize spec = let -- TODO: Remove
                      typeConverter = cTypeToHsTypeString
                      typeEnv = buildTypeEnvFromSpec spec
                  in [qc|{writeExtensions allExtensions }
module Vulkan where

{writeImports allImports}

{writeConstants (sConstants spec)}
{writeBaseTypes typeConverter 
                (catMaybes . fmap typeDeclToBaseType . sTypes $ spec)}
{writeHandleTypes typeConverter 
                  (catMaybes . fmap typeDeclToHandleType . sTypes $ spec)}
{writeFuncPointerTypes typeConverter 
                       (catMaybes . fmap typeDeclToFuncPointerType . sTypes $ 
                         spec)}
{writeBitmaskTypes typeConverter 
                   (sBitmasks spec) 
                   (catMaybes . fmap typeDeclToBitmaskType . sTypes $ spec)}
{writeEnums (sEnums spec)}
{writeStructTypes typeEnv 
                  (catMaybes . fmap typeDeclToStructType . sTypes $ spec)}
{writeUnionTypes typeEnv 
                  (catMaybes . fmap typeDeclToUnionType . sTypes $ spec)}
{writeCommands (sCommands spec)}
|]

allExtensions :: [Extension]
allExtensions = [ Extension "DataKinds"
                , Extension "DuplicateRecordFields"
                , Extension "ForeignFunctionInterface"
                , Extension "GeneralizedNewtypeDeriving"
                , Extension "PatternSynonyms"
                , Extension "Strict"
                ]

allImports :: [H.Import]
allImports = [ H.Import "Data.Bits" ["Bits", "FiniteBits"]
             , H.Import "Data.Int" ["Int32"]
             , H.Import "Data.Vector.Fixed.Storable" ["Vec"]
             , H.Import "Data.Vector.Fixed.Cont" ["ToPeano"]
             , H.Import "Data.Void" ["Void"]
             , H.Import "Data.Word" ["Word8", "Word32", "Word64"]
             , H.Import "Foreign.C.Types" ["CChar", "CFloat(..)", "CSize(..)"]
             , H.Import "Foreign.Ptr" ["Ptr", "FunPtr", "plusPtr", "castPtr"]
             , H.Import "Foreign.Storable" ["Storable(..)"]
             ]

