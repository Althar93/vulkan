{-# language Strict #-}
{-# language CPP #-}
{-# language GeneralizedNewtypeDeriving #-}
{-# language PatternSynonyms #-}
{-# language OverloadedStrings #-}
{-# language DataKinds #-}
{-# language TypeOperators #-}
{-# language DuplicateRecordFields #-}

module Graphics.Vulkan.Extensions.VK_MVK_macos_surface
  ( VkMacOSSurfaceCreateFlagsMVK(..)
  , pattern VK_STRUCTURE_TYPE_MACOS_SURFACE_CREATE_INFO_MVK
  , pattern VK_MVK_MACOS_SURFACE_SPEC_VERSION
  , pattern VK_MVK_MACOS_SURFACE_EXTENSION_NAME
  , vkCreateMacOSSurfaceMVK
  , VkMacOSSurfaceCreateInfoMVK(..)
  ) where

import Data.Bits
  ( Bits
  , FiniteBits
  )
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
import GHC.Read
  ( expectP
  , choose
  )
import Graphics.Vulkan.NamedType
  ( (:::)
  )
import Text.ParserCombinators.ReadPrec
  ( (+++)
  , prec
  , step
  )
import Text.Read
  ( Read(..)
  , parens
  )
import Text.Read.Lex
  ( Lexeme(Ident)
  )


import Graphics.Vulkan.Core10.Core
  ( VkResult(..)
  , VkStructureType(..)
  , VkFlags
  )
import Graphics.Vulkan.Core10.DeviceInitialization
  ( VkAllocationCallbacks(..)
  , VkInstance
  )
import Graphics.Vulkan.Extensions.VK_KHR_surface
  ( VkSurfaceKHR
  )


-- ** VkMacOSSurfaceCreateFlagsMVK

-- No documentation found for TopLevel "VkMacOSSurfaceCreateFlagsMVK"
newtype VkMacOSSurfaceCreateFlagsMVK = VkMacOSSurfaceCreateFlagsMVK VkFlags
  deriving (Eq, Ord, Storable, Bits, FiniteBits)

instance Show VkMacOSSurfaceCreateFlagsMVK where
  
  showsPrec p (VkMacOSSurfaceCreateFlagsMVK x) = showParen (p >= 11) (showString "VkMacOSSurfaceCreateFlagsMVK " . showsPrec 11 x)

instance Read VkMacOSSurfaceCreateFlagsMVK where
  readPrec = parens ( choose [ 
                             ] +++
                      prec 10 (do
                        expectP (Ident "VkMacOSSurfaceCreateFlagsMVK")
                        v <- step readPrec
                        pure (VkMacOSSurfaceCreateFlagsMVK v)
                        )
                    )


-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_MACOS_SURFACE_CREATE_INFO_MVK"
pattern VK_STRUCTURE_TYPE_MACOS_SURFACE_CREATE_INFO_MVK :: VkStructureType
pattern VK_STRUCTURE_TYPE_MACOS_SURFACE_CREATE_INFO_MVK = VkStructureType 1000123000
-- No documentation found for TopLevel "VK_MVK_MACOS_SURFACE_SPEC_VERSION"
pattern VK_MVK_MACOS_SURFACE_SPEC_VERSION :: Integral a => a
pattern VK_MVK_MACOS_SURFACE_SPEC_VERSION = 2
-- No documentation found for TopLevel "VK_MVK_MACOS_SURFACE_EXTENSION_NAME"
pattern VK_MVK_MACOS_SURFACE_EXTENSION_NAME :: (Eq a ,IsString a) => a
pattern VK_MVK_MACOS_SURFACE_EXTENSION_NAME = "VK_MVK_macos_surface"
-- | vkCreateMacOSSurfaceMVK - Create a VkSurfaceKHR object for a macOS
-- NSView
--
-- = Parameters
-- #_parameters#
--
-- -   @instance@ is the instance with which to associate the surface.
--
-- -   @pCreateInfo@ is a pointer to an instance of the
--     'VkMacOSSurfaceCreateInfoMVK' structure containing parameters
--     affecting the creation of the surface object.
--
-- -   @pAllocator@ is the allocator used for host memory allocated for the
--     surface object when there is no more specific allocator available
--     (see <{html_spec_relative}#memory-allocation Memory Allocation>).
--
-- -   @pSurface@ points to a @VkSurfaceKHR@ handle in which the created
--     surface object is returned.
--
-- = Description
-- #_description#
--
-- == Valid Usage (Implicit)
--
-- -   @instance@ /must/ be a valid @VkInstance@ handle
--
-- -   @pCreateInfo@ /must/ be a valid pointer to a valid
--     @VkMacOSSurfaceCreateInfoMVK@ structure
--
-- -   If @pAllocator@ is not @NULL@, @pAllocator@ /must/ be a valid
--     pointer to a valid @VkAllocationCallbacks@ structure
--
-- -   @pSurface@ /must/ be a valid pointer to a @VkSurfaceKHR@ handle
--
-- == Return Codes
--
-- [<#fundamentals-successcodes Success>]
--     -   @VK_SUCCESS@
--
-- [<#fundamentals-errorcodes Failure>]
--     -   @VK_ERROR_OUT_OF_HOST_MEMORY@
--
--     -   @VK_ERROR_OUT_OF_DEVICE_MEMORY@
--
--     -   @VK_ERROR_NATIVE_WINDOW_IN_USE_KHR@
--
-- = See Also
-- #_see_also#
--
-- 'Graphics.Vulkan.Core10.DeviceInitialization.VkAllocationCallbacks',
-- 'Graphics.Vulkan.Core10.DeviceInitialization.VkInstance',
-- 'VkMacOSSurfaceCreateInfoMVK',
-- 'Graphics.Vulkan.Extensions.VK_KHR_surface.VkSurfaceKHR'
foreign import ccall "vkCreateMacOSSurfaceMVK" vkCreateMacOSSurfaceMVK :: ("instance" ::: VkInstance) -> ("pCreateInfo" ::: Ptr VkMacOSSurfaceCreateInfoMVK) -> ("pAllocator" ::: Ptr VkAllocationCallbacks) -> ("pSurface" ::: Ptr VkSurfaceKHR) -> IO VkResult
-- | VkMacOSSurfaceCreateInfoMVK - Structure specifying parameters of a newly
-- created macOS surface object
--
-- = Description
-- #_description#
--
-- == Valid Usage
--
-- -   @pView@ /must/ be a valid @NSView@ and /must/ be backed by a
--     @CALayer@ instance of type @CAMetalLayer@.
--
-- == Valid Usage (Implicit)
--
-- -   @sType@ /must/ be @VK_STRUCTURE_TYPE_MACOS_SURFACE_CREATE_INFO_MVK@
--
-- -   @pNext@ /must/ be @NULL@
--
-- -   @flags@ /must/ be @0@
--
-- = See Also
-- #_see_also#
--
-- 'VkMacOSSurfaceCreateFlagsMVK',
-- 'Graphics.Vulkan.Core10.Core.VkStructureType', 'vkCreateMacOSSurfaceMVK'
data VkMacOSSurfaceCreateInfoMVK = VkMacOSSurfaceCreateInfoMVK
  { -- No documentation found for Nested "VkMacOSSurfaceCreateInfoMVK" "vkSType"
  vkSType :: VkStructureType
  , -- No documentation found for Nested "VkMacOSSurfaceCreateInfoMVK" "vkPNext"
  vkPNext :: Ptr ()
  , -- No documentation found for Nested "VkMacOSSurfaceCreateInfoMVK" "vkFlags"
  vkFlags :: VkMacOSSurfaceCreateFlagsMVK
  , -- No documentation found for Nested "VkMacOSSurfaceCreateInfoMVK" "vkPView"
  vkPView :: Ptr ()
  }
  deriving (Eq, Show)

instance Storable VkMacOSSurfaceCreateInfoMVK where
  sizeOf ~_ = 32
  alignment ~_ = 8
  peek ptr = VkMacOSSurfaceCreateInfoMVK <$> peek (ptr `plusPtr` 0)
                                         <*> peek (ptr `plusPtr` 8)
                                         <*> peek (ptr `plusPtr` 16)
                                         <*> peek (ptr `plusPtr` 24)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkMacOSSurfaceCreateInfoMVK))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkMacOSSurfaceCreateInfoMVK))
                *> poke (ptr `plusPtr` 16) (vkFlags (poked :: VkMacOSSurfaceCreateInfoMVK))
                *> poke (ptr `plusPtr` 24) (vkPView (poked :: VkMacOSSurfaceCreateInfoMVK))
