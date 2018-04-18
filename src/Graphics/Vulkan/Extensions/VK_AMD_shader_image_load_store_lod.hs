{-# language Strict #-}
{-# language CPP #-}
{-# language PatternSynonyms #-}
{-# language OverloadedStrings #-}

module Graphics.Vulkan.Extensions.VK_AMD_shader_image_load_store_lod
  ( pattern VK_AMD_SHADER_IMAGE_LOAD_STORE_LOD_SPEC_VERSION
  , pattern VK_AMD_SHADER_IMAGE_LOAD_STORE_LOD_EXTENSION_NAME
  ) where

import Data.String
  ( IsString
  )





pattern VK_AMD_SHADER_IMAGE_LOAD_STORE_LOD_SPEC_VERSION :: Integral a => a
pattern VK_AMD_SHADER_IMAGE_LOAD_STORE_LOD_SPEC_VERSION = 1
pattern VK_AMD_SHADER_IMAGE_LOAD_STORE_LOD_EXTENSION_NAME :: (Eq a ,IsString a) => a
pattern VK_AMD_SHADER_IMAGE_LOAD_STORE_LOD_EXTENSION_NAME = "VK_AMD_shader_image_load_store_lod"
