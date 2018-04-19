{-# language Strict #-}
{-# language CPP #-}
{-# language PatternSynonyms #-}
{-# language OverloadedStrings #-}
{-# language DuplicateRecordFields #-}

module Graphics.Vulkan.Extensions.VK_AMD_texture_gather_bias_lod
  ( pattern VK_STRUCTURE_TYPE_TEXTURE_LOD_GATHER_FORMAT_PROPERTIES_AMD
  , pattern VK_AMD_TEXTURE_GATHER_BIAS_LOD_SPEC_VERSION
  , pattern VK_AMD_TEXTURE_GATHER_BIAS_LOD_EXTENSION_NAME
  , VkTextureLODGatherFormatPropertiesAMD(..)
  ) where

import Data.String
  ( IsString
  )
import Foreign.Ptr
  ( plusPtr
  , Ptr
  )
import Foreign.Storable
  ( Storable(..)
  , Storable
  )


import Graphics.Vulkan.Core10.Core
  ( VkBool32(..)
  , VkStructureType(..)
  )


-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_TEXTURE_LOD_GATHER_FORMAT_PROPERTIES_AMD"
pattern VK_STRUCTURE_TYPE_TEXTURE_LOD_GATHER_FORMAT_PROPERTIES_AMD :: VkStructureType
pattern VK_STRUCTURE_TYPE_TEXTURE_LOD_GATHER_FORMAT_PROPERTIES_AMD = VkStructureType 1000041000
-- No documentation found for TopLevel "VK_AMD_TEXTURE_GATHER_BIAS_LOD_SPEC_VERSION"
pattern VK_AMD_TEXTURE_GATHER_BIAS_LOD_SPEC_VERSION :: Integral a => a
pattern VK_AMD_TEXTURE_GATHER_BIAS_LOD_SPEC_VERSION = 1
-- No documentation found for TopLevel "VK_AMD_TEXTURE_GATHER_BIAS_LOD_EXTENSION_NAME"
pattern VK_AMD_TEXTURE_GATHER_BIAS_LOD_EXTENSION_NAME :: (Eq a ,IsString a) => a
pattern VK_AMD_TEXTURE_GATHER_BIAS_LOD_EXTENSION_NAME = "VK_AMD_texture_gather_bias_lod"
-- | VkTextureLODGatherFormatPropertiesAMD - Structure informing whether or
-- not texture gather bias\/LOD functionality is supported for a given
-- image format and a given physical device.
--
-- = Description
-- #_description#
--
-- = See Also
-- #_see_also#
--
-- @VkBool32@, 'Graphics.Vulkan.Core10.Core.VkStructureType'
data VkTextureLODGatherFormatPropertiesAMD = VkTextureLODGatherFormatPropertiesAMD
  { -- No documentation found for Nested "VkTextureLODGatherFormatPropertiesAMD" "vkSType"
  vkSType :: VkStructureType
  , -- No documentation found for Nested "VkTextureLODGatherFormatPropertiesAMD" "vkPNext"
  vkPNext :: Ptr ()
  , -- No documentation found for Nested "VkTextureLODGatherFormatPropertiesAMD" "vkSupportsTextureGatherLODBiasAMD"
  vkSupportsTextureGatherLODBiasAMD :: VkBool32
  }
  deriving (Eq, Show)

instance Storable VkTextureLODGatherFormatPropertiesAMD where
  sizeOf ~_ = 24
  alignment ~_ = 8
  peek ptr = VkTextureLODGatherFormatPropertiesAMD <$> peek (ptr `plusPtr` 0)
                                                   <*> peek (ptr `plusPtr` 8)
                                                   <*> peek (ptr `plusPtr` 16)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkTextureLODGatherFormatPropertiesAMD))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkTextureLODGatherFormatPropertiesAMD))
                *> poke (ptr `plusPtr` 16) (vkSupportsTextureGatherLODBiasAMD (poked :: VkTextureLODGatherFormatPropertiesAMD))
