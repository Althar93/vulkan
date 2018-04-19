{-# language Strict #-}
{-# language CPP #-}
{-# language PatternSynonyms #-}
{-# language OverloadedStrings #-}
{-# language DataKinds #-}
{-# language TypeOperators #-}
{-# language DuplicateRecordFields #-}

module Graphics.Vulkan.Extensions.VK_EXT_hdr_metadata
  ( pattern VK_STRUCTURE_TYPE_HDR_METADATA_EXT
  , pattern VK_EXT_HDR_METADATA_SPEC_VERSION
  , pattern VK_EXT_HDR_METADATA_EXTENSION_NAME
  , vkSetHdrMetadataEXT
  , VkXYColorEXT(..)
  , VkHdrMetadataEXT(..)
  ) where

import Data.String
  ( IsString
  )
import Data.Word
  ( Word32
  )
import Foreign.C.Types
  ( CFloat(..)
  )
import Foreign.Ptr
  ( plusPtr
  , Ptr
  )
import Foreign.Storable
  ( Storable(..)
  , Storable
  )
import Graphics.Vulkan.NamedType
  ( (:::)
  )


import Graphics.Vulkan.Core10.Core
  ( VkStructureType(..)
  )
import Graphics.Vulkan.Core10.DeviceInitialization
  ( VkDevice
  )
import Graphics.Vulkan.Extensions.VK_KHR_swapchain
  ( VkSwapchainKHR
  )


-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_HDR_METADATA_EXT"
pattern VK_STRUCTURE_TYPE_HDR_METADATA_EXT :: VkStructureType
pattern VK_STRUCTURE_TYPE_HDR_METADATA_EXT = VkStructureType 1000105000
-- No documentation found for TopLevel "VK_EXT_HDR_METADATA_SPEC_VERSION"
pattern VK_EXT_HDR_METADATA_SPEC_VERSION :: Integral a => a
pattern VK_EXT_HDR_METADATA_SPEC_VERSION = 1
-- No documentation found for TopLevel "VK_EXT_HDR_METADATA_EXTENSION_NAME"
pattern VK_EXT_HDR_METADATA_EXTENSION_NAME :: (Eq a ,IsString a) => a
pattern VK_EXT_HDR_METADATA_EXTENSION_NAME = "VK_EXT_hdr_metadata"
-- | vkSetHdrMetadataEXT - function to set Hdr metadata
--
-- = Parameters
-- #_parameters#
--
-- -   @device@ is the logical device where the swapchain(s) were created.
--
-- -   @swapchainCount@ is the number of swapchains included in
--     @pSwapchains@.
--
-- -   @pSwapchains@ is a pointer to the array of @swapchainCount@
--     @VkSwapchainKHR@ handles.
--
-- -   @pMetadata@ is a pointer to the array of @swapchainCount@
--     @VkHdrMetadataEXT@ structures.
--
-- = Description
-- #_description#
--
-- == Valid Usage (Implicit)
--
-- -   @device@ /must/ be a valid @VkDevice@ handle
--
-- -   @pSwapchains@ /must/ be a valid pointer to an array of
--     @swapchainCount@ valid @VkSwapchainKHR@ handles
--
-- -   @pMetadata@ /must/ be a valid pointer to an array of
--     @swapchainCount@ valid @VkHdrMetadataEXT@ structures
--
-- -   @swapchainCount@ /must/ be greater than @0@
--
-- -   Both of @device@, and the elements of @pSwapchains@ /must/ have been
--     created, allocated, or retrieved from the same @VkInstance@
--
-- = See Also
-- #_see_also#
--
-- 'Graphics.Vulkan.Core10.DeviceInitialization.VkDevice',
-- 'VkHdrMetadataEXT',
-- 'Graphics.Vulkan.Extensions.VK_KHR_swapchain.VkSwapchainKHR'
foreign import ccall "vkSetHdrMetadataEXT" vkSetHdrMetadataEXT :: ("device" ::: VkDevice) -> ("swapchainCount" ::: Word32) -> ("pSwapchains" ::: Ptr VkSwapchainKHR) -> ("pMetadata" ::: Ptr VkHdrMetadataEXT) -> IO ()
-- | VkXYColorEXT - structure to specify X,Y chromaticity coordinates
--
-- = Members
-- #_members#
--
-- = Description
-- #_description#
--
-- = See Also
-- #_see_also#
--
-- 'VkHdrMetadataEXT'
data VkXYColorEXT = VkXYColorEXT
  { -- No documentation found for Nested "VkXYColorEXT" "vkX"
  vkX :: CFloat
  , -- No documentation found for Nested "VkXYColorEXT" "vkY"
  vkY :: CFloat
  }
  deriving (Eq, Show)

instance Storable VkXYColorEXT where
  sizeOf ~_ = 8
  alignment ~_ = 4
  peek ptr = VkXYColorEXT <$> peek (ptr `plusPtr` 0)
                          <*> peek (ptr `plusPtr` 4)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkX (poked :: VkXYColorEXT))
                *> poke (ptr `plusPtr` 4) (vkY (poked :: VkXYColorEXT))
-- | VkHdrMetadataEXT - structure to specify Hdr metadata
--
-- = Description
-- #_description#
--
-- __Note__
--
-- The validity and use of this data is outside the scope of Vulkan and
-- thus no Valid Usage is given.
--
-- = See Also
-- #_see_also#
--
-- 'Graphics.Vulkan.Core10.Core.VkStructureType', 'VkXYColorEXT',
-- 'vkSetHdrMetadataEXT'
data VkHdrMetadataEXT = VkHdrMetadataEXT
  { -- No documentation found for Nested "VkHdrMetadataEXT" "vkSType"
  vkSType :: VkStructureType
  , -- No documentation found for Nested "VkHdrMetadataEXT" "vkPNext"
  vkPNext :: Ptr ()
  , -- No documentation found for Nested "VkHdrMetadataEXT" "vkDisplayPrimaryRed"
  vkDisplayPrimaryRed :: VkXYColorEXT
  , -- No documentation found for Nested "VkHdrMetadataEXT" "vkDisplayPrimaryGreen"
  vkDisplayPrimaryGreen :: VkXYColorEXT
  , -- No documentation found for Nested "VkHdrMetadataEXT" "vkDisplayPrimaryBlue"
  vkDisplayPrimaryBlue :: VkXYColorEXT
  , -- No documentation found for Nested "VkHdrMetadataEXT" "vkWhitePoint"
  vkWhitePoint :: VkXYColorEXT
  , -- No documentation found for Nested "VkHdrMetadataEXT" "vkMaxLuminance"
  vkMaxLuminance :: CFloat
  , -- No documentation found for Nested "VkHdrMetadataEXT" "vkMinLuminance"
  vkMinLuminance :: CFloat
  , -- No documentation found for Nested "VkHdrMetadataEXT" "vkMaxContentLightLevel"
  vkMaxContentLightLevel :: CFloat
  , -- No documentation found for Nested "VkHdrMetadataEXT" "vkMaxFrameAverageLightLevel"
  vkMaxFrameAverageLightLevel :: CFloat
  }
  deriving (Eq, Show)

instance Storable VkHdrMetadataEXT where
  sizeOf ~_ = 64
  alignment ~_ = 8
  peek ptr = VkHdrMetadataEXT <$> peek (ptr `plusPtr` 0)
                              <*> peek (ptr `plusPtr` 8)
                              <*> peek (ptr `plusPtr` 16)
                              <*> peek (ptr `plusPtr` 24)
                              <*> peek (ptr `plusPtr` 32)
                              <*> peek (ptr `plusPtr` 40)
                              <*> peek (ptr `plusPtr` 48)
                              <*> peek (ptr `plusPtr` 52)
                              <*> peek (ptr `plusPtr` 56)
                              <*> peek (ptr `plusPtr` 60)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkHdrMetadataEXT))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkHdrMetadataEXT))
                *> poke (ptr `plusPtr` 16) (vkDisplayPrimaryRed (poked :: VkHdrMetadataEXT))
                *> poke (ptr `plusPtr` 24) (vkDisplayPrimaryGreen (poked :: VkHdrMetadataEXT))
                *> poke (ptr `plusPtr` 32) (vkDisplayPrimaryBlue (poked :: VkHdrMetadataEXT))
                *> poke (ptr `plusPtr` 40) (vkWhitePoint (poked :: VkHdrMetadataEXT))
                *> poke (ptr `plusPtr` 48) (vkMaxLuminance (poked :: VkHdrMetadataEXT))
                *> poke (ptr `plusPtr` 52) (vkMinLuminance (poked :: VkHdrMetadataEXT))
                *> poke (ptr `plusPtr` 56) (vkMaxContentLightLevel (poked :: VkHdrMetadataEXT))
                *> poke (ptr `plusPtr` 60) (vkMaxFrameAverageLightLevel (poked :: VkHdrMetadataEXT))
