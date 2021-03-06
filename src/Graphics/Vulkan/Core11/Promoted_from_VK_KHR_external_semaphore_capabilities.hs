{-# language Strict #-}
{-# language CPP #-}
{-# language GeneralizedNewtypeDeriving #-}
{-# language PatternSynonyms #-}
{-# language DataKinds #-}
{-# language TypeOperators #-}
{-# language DuplicateRecordFields #-}

module Graphics.Vulkan.Core11.Promoted_from_VK_KHR_external_semaphore_capabilities
  ( VkExternalSemaphoreHandleTypeFlagBits(..)
  , pattern VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD_BIT
  , pattern VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_BIT
  , pattern VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT_BIT
  , pattern VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE_BIT
  , pattern VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_SYNC_FD_BIT
  , VkExternalSemaphoreFeatureFlagBits(..)
  , pattern VK_EXTERNAL_SEMAPHORE_FEATURE_EXPORTABLE_BIT
  , pattern VK_EXTERNAL_SEMAPHORE_FEATURE_IMPORTABLE_BIT
  , pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_EXTERNAL_SEMAPHORE_INFO
  , pattern VK_STRUCTURE_TYPE_EXTERNAL_SEMAPHORE_PROPERTIES
  , vkGetPhysicalDeviceExternalSemaphoreProperties
  , VkPhysicalDeviceExternalSemaphoreInfo(..)
  , VkExternalSemaphoreProperties(..)
  , VkExternalSemaphoreHandleTypeFlags
  , VkExternalSemaphoreFeatureFlags
  ) where

import Data.Bits
  ( Bits
  , FiniteBits
  )
import Foreign.Ptr
  ( Ptr
  , plusPtr
  )
import Foreign.Storable
  ( Storable
  , Storable(..)
  )
import GHC.Read
  ( choose
  , expectP
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
  ( VkStructureType(..)
  , VkFlags
  )
import Graphics.Vulkan.Core10.DeviceInitialization
  ( VkPhysicalDevice
  )


-- ** VkExternalSemaphoreHandleTypeFlagBits

-- | VkExternalSemaphoreHandleTypeFlagBits - Bitmask of valid external
-- semaphore handle types
--
-- = Description
--
-- -   @VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD_BIT@ specifies a POSIX
--     file descriptor handle that has only limited valid usage outside of
--     Vulkan and other compatible APIs. It /must/ be compatible with the
--     POSIX system calls @dup@, @dup2@, @close@, and the non-standard
--     system call @dup3@. Additionally, it /must/ be transportable over a
--     socket using an @SCM_RIGHTS@ control message. It owns a reference to
--     the underlying synchronization primitive represented by its Vulkan
--     semaphore object.
--
-- -   @VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_BIT@ specifies an NT
--     handle that has only limited valid usage outside of Vulkan and other
--     compatible APIs. It /must/ be compatible with the functions
--     @DuplicateHandle@, @CloseHandle@, @CompareObjectHandles@,
--     @GetHandleInformation@, and @SetHandleInformation@. It owns a
--     reference to the underlying synchronization primitive represented by
--     its Vulkan semaphore object.
--
-- -   @VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT_BIT@ specifies a
--     global share handle that has only limited valid usage outside of
--     Vulkan and other compatible APIs. It is not compatible with any
--     native APIs. It does not own a reference to the underlying
--     synchronization primitive represented its Vulkan semaphore object,
--     and will therefore become invalid when all Vulkan semaphore objects
--     associated with it are destroyed.
--
-- -   @VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE_BIT@ specifies an NT
--     handle returned by @ID3D12Device@::@CreateSharedHandle@ referring to
--     a Direct3D 12 fence. It owns a reference to the underlying
--     synchronization primitive associated with the Direct3D fence.
--
-- -   @VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_SYNC_FD_BIT@ specifies a POSIX
--     file descriptor handle to a Linux Sync File or Android Fence object.
--     It can be used with any native API accepting a valid sync file or
--     fence as input. It owns a reference to the underlying
--     synchronization primitive associated with the file descriptor.
--     Implementations which support importing this handle type /must/
--     accept any type of sync or fence FD supported by the native system
--     they are running on.
--
-- __Note__
--
-- Handles of type @VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_SYNC_FD_BIT@
-- generated by the implementation may represent either Linux Sync Files or
-- Android Fences at the implementation’s discretion. Applications /should/
-- only use operations defined for both types of file descriptors, unless
-- they know via means external to Vulkan the type of the file descriptor,
-- or are prepared to deal with the system-defined operation failures
-- resulting from using the wrong type.
--
-- Some external semaphore handle types can only be shared within the same
-- underlying physical device and\/or the same driver version, as defined
-- in the following table:
--
-- +----------------------------------------------------------+----------------------------------------------+----------------------------------------------+
-- | Handle type                                              | @VkPhysicalDeviceIDProperties@::@driverUUID@ | @VkPhysicalDeviceIDProperties@::@deviceUUID@ |
-- +----------------------------------------------------------+----------------------------------------------+----------------------------------------------+
-- | @VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD_BIT@        | Must match                                   | Must match                                   |
-- +----------------------------------------------------------+----------------------------------------------+----------------------------------------------+
-- | @VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_BIT@     | Must match                                   | Must match                                   |
-- +----------------------------------------------------------+----------------------------------------------+----------------------------------------------+
-- | @VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT_BIT@ | Must match                                   | Must match                                   |
-- +----------------------------------------------------------+----------------------------------------------+----------------------------------------------+
-- | @VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE_BIT@      | Must match                                   | Must match                                   |
-- +----------------------------------------------------------+----------------------------------------------+----------------------------------------------+
-- | @VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_SYNC_FD_BIT@          | No restriction                               | No restriction                               |
-- +----------------------------------------------------------+----------------------------------------------+----------------------------------------------+
--
-- External semaphore handle types compatibility
--
-- = See Also
--
-- 'VkExternalSemaphoreHandleTypeFlags',
-- 'Graphics.Vulkan.Extensions.VK_KHR_external_semaphore_fd.VkImportSemaphoreFdInfoKHR',
-- 'Graphics.Vulkan.Extensions.VK_KHR_external_semaphore_win32.VkImportSemaphoreWin32HandleInfoKHR',
-- 'VkPhysicalDeviceExternalSemaphoreInfo',
-- 'Graphics.Vulkan.Extensions.VK_KHR_external_semaphore_fd.VkSemaphoreGetFdInfoKHR',
-- 'Graphics.Vulkan.Extensions.VK_KHR_external_semaphore_win32.VkSemaphoreGetWin32HandleInfoKHR'
newtype VkExternalSemaphoreHandleTypeFlagBits = VkExternalSemaphoreHandleTypeFlagBits VkFlags
  deriving (Eq, Ord, Storable, Bits, FiniteBits)

instance Show VkExternalSemaphoreHandleTypeFlagBits where
  showsPrec _ VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD_BIT = showString "VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD_BIT"
  showsPrec _ VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_BIT = showString "VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_BIT"
  showsPrec _ VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT_BIT = showString "VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT_BIT"
  showsPrec _ VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE_BIT = showString "VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE_BIT"
  showsPrec _ VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_SYNC_FD_BIT = showString "VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_SYNC_FD_BIT"
  showsPrec p (VkExternalSemaphoreHandleTypeFlagBits x) = showParen (p >= 11) (showString "VkExternalSemaphoreHandleTypeFlagBits " . showsPrec 11 x)

instance Read VkExternalSemaphoreHandleTypeFlagBits where
  readPrec = parens ( choose [ ("VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD_BIT",        pure VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD_BIT)
                             , ("VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_BIT",     pure VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_BIT)
                             , ("VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT_BIT", pure VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT_BIT)
                             , ("VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE_BIT",      pure VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE_BIT)
                             , ("VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_SYNC_FD_BIT",          pure VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_SYNC_FD_BIT)
                             ] +++
                      prec 10 (do
                        expectP (Ident "VkExternalSemaphoreHandleTypeFlagBits")
                        v <- step readPrec
                        pure (VkExternalSemaphoreHandleTypeFlagBits v)
                        )
                    )

-- No documentation found for Nested "VkExternalSemaphoreHandleTypeFlagBits" "VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD_BIT"
pattern VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD_BIT :: VkExternalSemaphoreHandleTypeFlagBits
pattern VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_FD_BIT = VkExternalSemaphoreHandleTypeFlagBits 0x00000001

-- No documentation found for Nested "VkExternalSemaphoreHandleTypeFlagBits" "VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_BIT"
pattern VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_BIT :: VkExternalSemaphoreHandleTypeFlagBits
pattern VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_BIT = VkExternalSemaphoreHandleTypeFlagBits 0x00000002

-- No documentation found for Nested "VkExternalSemaphoreHandleTypeFlagBits" "VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT_BIT"
pattern VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT_BIT :: VkExternalSemaphoreHandleTypeFlagBits
pattern VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_OPAQUE_WIN32_KMT_BIT = VkExternalSemaphoreHandleTypeFlagBits 0x00000004

-- No documentation found for Nested "VkExternalSemaphoreHandleTypeFlagBits" "VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE_BIT"
pattern VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE_BIT :: VkExternalSemaphoreHandleTypeFlagBits
pattern VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_D3D12_FENCE_BIT = VkExternalSemaphoreHandleTypeFlagBits 0x00000008

-- No documentation found for Nested "VkExternalSemaphoreHandleTypeFlagBits" "VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_SYNC_FD_BIT"
pattern VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_SYNC_FD_BIT :: VkExternalSemaphoreHandleTypeFlagBits
pattern VK_EXTERNAL_SEMAPHORE_HANDLE_TYPE_SYNC_FD_BIT = VkExternalSemaphoreHandleTypeFlagBits 0x00000010
-- ** VkExternalSemaphoreFeatureFlagBits

-- | VkExternalSemaphoreFeatureFlagBits - Bitfield describing features of an
-- external semaphore handle type
--
-- = See Also
--
-- 'VkExternalSemaphoreFeatureFlags'
newtype VkExternalSemaphoreFeatureFlagBits = VkExternalSemaphoreFeatureFlagBits VkFlags
  deriving (Eq, Ord, Storable, Bits, FiniteBits)

instance Show VkExternalSemaphoreFeatureFlagBits where
  showsPrec _ VK_EXTERNAL_SEMAPHORE_FEATURE_EXPORTABLE_BIT = showString "VK_EXTERNAL_SEMAPHORE_FEATURE_EXPORTABLE_BIT"
  showsPrec _ VK_EXTERNAL_SEMAPHORE_FEATURE_IMPORTABLE_BIT = showString "VK_EXTERNAL_SEMAPHORE_FEATURE_IMPORTABLE_BIT"
  showsPrec p (VkExternalSemaphoreFeatureFlagBits x) = showParen (p >= 11) (showString "VkExternalSemaphoreFeatureFlagBits " . showsPrec 11 x)

instance Read VkExternalSemaphoreFeatureFlagBits where
  readPrec = parens ( choose [ ("VK_EXTERNAL_SEMAPHORE_FEATURE_EXPORTABLE_BIT", pure VK_EXTERNAL_SEMAPHORE_FEATURE_EXPORTABLE_BIT)
                             , ("VK_EXTERNAL_SEMAPHORE_FEATURE_IMPORTABLE_BIT", pure VK_EXTERNAL_SEMAPHORE_FEATURE_IMPORTABLE_BIT)
                             ] +++
                      prec 10 (do
                        expectP (Ident "VkExternalSemaphoreFeatureFlagBits")
                        v <- step readPrec
                        pure (VkExternalSemaphoreFeatureFlagBits v)
                        )
                    )

-- | @VK_EXTERNAL_SEMAPHORE_FEATURE_EXPORTABLE_BIT@ specifies that handles of
-- this type /can/ be exported from Vulkan semaphore objects.
pattern VK_EXTERNAL_SEMAPHORE_FEATURE_EXPORTABLE_BIT :: VkExternalSemaphoreFeatureFlagBits
pattern VK_EXTERNAL_SEMAPHORE_FEATURE_EXPORTABLE_BIT = VkExternalSemaphoreFeatureFlagBits 0x00000001

-- | @VK_EXTERNAL_SEMAPHORE_FEATURE_IMPORTABLE_BIT@ specifies that handles of
-- this type /can/ be imported as Vulkan semaphore objects.
pattern VK_EXTERNAL_SEMAPHORE_FEATURE_IMPORTABLE_BIT :: VkExternalSemaphoreFeatureFlagBits
pattern VK_EXTERNAL_SEMAPHORE_FEATURE_IMPORTABLE_BIT = VkExternalSemaphoreFeatureFlagBits 0x00000002
-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_EXTERNAL_SEMAPHORE_INFO"
pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_EXTERNAL_SEMAPHORE_INFO :: VkStructureType
pattern VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_EXTERNAL_SEMAPHORE_INFO = VkStructureType 1000076000
-- No documentation found for Nested "VkStructureType" "VK_STRUCTURE_TYPE_EXTERNAL_SEMAPHORE_PROPERTIES"
pattern VK_STRUCTURE_TYPE_EXTERNAL_SEMAPHORE_PROPERTIES :: VkStructureType
pattern VK_STRUCTURE_TYPE_EXTERNAL_SEMAPHORE_PROPERTIES = VkStructureType 1000076001
-- | vkGetPhysicalDeviceExternalSemaphoreProperties - Function for querying
-- external semaphore handle capabilities.
--
-- = Parameters
--
-- -   @physicalDevice@ is the physical device from which to query the
--     semaphore capabilities.
--
-- -   @pExternalSemaphoreInfo@ points to an instance of the
--     'VkPhysicalDeviceExternalSemaphoreInfo' structure, describing the
--     parameters that would be consumed by
--     'Graphics.Vulkan.Core10.QueueSemaphore.vkCreateSemaphore'.
--
-- -   @pExternalSemaphoreProperties@ points to an instance of the
--     'VkExternalSemaphoreProperties' structure in which capabilities are
--     returned.
--
-- == Valid Usage (Implicit)
--
-- -   @physicalDevice@ /must/ be a valid @VkPhysicalDevice@ handle
--
-- -   @pExternalSemaphoreInfo@ /must/ be a valid pointer to a valid
--     @VkPhysicalDeviceExternalSemaphoreInfo@ structure
--
-- -   @pExternalSemaphoreProperties@ /must/ be a valid pointer to a
--     @VkExternalSemaphoreProperties@ structure
--
-- = See Also
--
-- 'VkExternalSemaphoreProperties',
-- 'Graphics.Vulkan.Core10.DeviceInitialization.VkPhysicalDevice',
-- 'VkPhysicalDeviceExternalSemaphoreInfo'
foreign import ccall
#if !defined(SAFE_FOREIGN_CALLS)
  unsafe
#endif
  "vkGetPhysicalDeviceExternalSemaphoreProperties" vkGetPhysicalDeviceExternalSemaphoreProperties :: ("physicalDevice" ::: VkPhysicalDevice) -> ("pExternalSemaphoreInfo" ::: Ptr VkPhysicalDeviceExternalSemaphoreInfo) -> ("pExternalSemaphoreProperties" ::: Ptr VkExternalSemaphoreProperties) -> IO ()
-- | VkPhysicalDeviceExternalSemaphoreInfo - Structure specifying semaphore
-- creation parameters.
--
-- == Valid Usage (Implicit)
--
-- -   @sType@ /must/ be
--     @VK_STRUCTURE_TYPE_PHYSICAL_DEVICE_EXTERNAL_SEMAPHORE_INFO@
--
-- -   @pNext@ /must/ be @NULL@
--
-- -   @handleType@ /must/ be a valid
--     'VkExternalSemaphoreHandleTypeFlagBits' value
--
-- = See Also
--
-- 'VkExternalSemaphoreHandleTypeFlagBits',
-- 'Graphics.Vulkan.Core10.Core.VkStructureType',
-- 'vkGetPhysicalDeviceExternalSemaphoreProperties',
-- 'Graphics.Vulkan.Extensions.VK_KHR_external_semaphore_capabilities.vkGetPhysicalDeviceExternalSemaphorePropertiesKHR'
data VkPhysicalDeviceExternalSemaphoreInfo = VkPhysicalDeviceExternalSemaphoreInfo
  { -- | @sType@ is the type of this structure
  vkSType :: VkStructureType
  , -- | @pNext@ is NULL or a pointer to an extension-specific structure.
  vkPNext :: Ptr ()
  , -- | @handleType@ is a 'VkExternalSemaphoreHandleTypeFlagBits' value
  -- specifying the external semaphore handle type for which capabilities
  -- will be returned.
  vkHandleType :: VkExternalSemaphoreHandleTypeFlagBits
  }
  deriving (Eq, Show)

instance Storable VkPhysicalDeviceExternalSemaphoreInfo where
  sizeOf ~_ = 24
  alignment ~_ = 8
  peek ptr = VkPhysicalDeviceExternalSemaphoreInfo <$> peek (ptr `plusPtr` 0)
                                                   <*> peek (ptr `plusPtr` 8)
                                                   <*> peek (ptr `plusPtr` 16)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkPhysicalDeviceExternalSemaphoreInfo))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkPhysicalDeviceExternalSemaphoreInfo))
                *> poke (ptr `plusPtr` 16) (vkHandleType (poked :: VkPhysicalDeviceExternalSemaphoreInfo))
-- | VkExternalSemaphoreProperties - Structure describing supported external
-- semaphore handle features
--
-- = Description
--
-- If @handleType@ is not supported by the implementation, then
-- 'VkExternalSemaphoreProperties'::@externalSemaphoreFeatures@ will be set
-- to zero.
--
-- == Valid Usage (Implicit)
--
-- -   @sType@ /must/ be @VK_STRUCTURE_TYPE_EXTERNAL_SEMAPHORE_PROPERTIES@
--
-- -   @pNext@ /must/ be @NULL@
--
-- = See Also
--
-- 'VkExternalSemaphoreFeatureFlags', 'VkExternalSemaphoreHandleTypeFlags',
-- 'Graphics.Vulkan.Core10.Core.VkStructureType',
-- 'vkGetPhysicalDeviceExternalSemaphoreProperties',
-- 'Graphics.Vulkan.Extensions.VK_KHR_external_semaphore_capabilities.vkGetPhysicalDeviceExternalSemaphorePropertiesKHR'
data VkExternalSemaphoreProperties = VkExternalSemaphoreProperties
  { -- No documentation found for Nested "VkExternalSemaphoreProperties" "sType"
  vkSType :: VkStructureType
  , -- No documentation found for Nested "VkExternalSemaphoreProperties" "pNext"
  vkPNext :: Ptr ()
  , -- | @exportFromImportedHandleTypes@ is a bitmask of
  -- 'VkExternalSemaphoreHandleTypeFlagBits' specifying which types of
  -- imported handle @handleType@ /can/ be exported from.
  vkExportFromImportedHandleTypes :: VkExternalSemaphoreHandleTypeFlags
  , -- | @compatibleHandleTypes@ is a bitmask of
  -- 'VkExternalSemaphoreHandleTypeFlagBits' specifying handle types which
  -- /can/ be specified at the same time as @handleType@ when creating a
  -- semaphore.
  vkCompatibleHandleTypes :: VkExternalSemaphoreHandleTypeFlags
  , -- | @externalSemaphoreFeatures@ is a bitmask of
  -- 'VkExternalSemaphoreFeatureFlagBits' describing the features of
  -- @handleType@.
  vkExternalSemaphoreFeatures :: VkExternalSemaphoreFeatureFlags
  }
  deriving (Eq, Show)

instance Storable VkExternalSemaphoreProperties where
  sizeOf ~_ = 32
  alignment ~_ = 8
  peek ptr = VkExternalSemaphoreProperties <$> peek (ptr `plusPtr` 0)
                                           <*> peek (ptr `plusPtr` 8)
                                           <*> peek (ptr `plusPtr` 16)
                                           <*> peek (ptr `plusPtr` 20)
                                           <*> peek (ptr `plusPtr` 24)
  poke ptr poked = poke (ptr `plusPtr` 0) (vkSType (poked :: VkExternalSemaphoreProperties))
                *> poke (ptr `plusPtr` 8) (vkPNext (poked :: VkExternalSemaphoreProperties))
                *> poke (ptr `plusPtr` 16) (vkExportFromImportedHandleTypes (poked :: VkExternalSemaphoreProperties))
                *> poke (ptr `plusPtr` 20) (vkCompatibleHandleTypes (poked :: VkExternalSemaphoreProperties))
                *> poke (ptr `plusPtr` 24) (vkExternalSemaphoreFeatures (poked :: VkExternalSemaphoreProperties))
-- | VkExternalSemaphoreHandleTypeFlags - Bitmask of
-- VkExternalSemaphoreHandleTypeFlagBits
--
-- = Description
--
-- @VkExternalSemaphoreHandleTypeFlags@ is a bitmask type for setting a
-- mask of zero or more 'VkExternalSemaphoreHandleTypeFlagBits'.
--
-- = See Also
--
-- 'Graphics.Vulkan.Core11.Promoted_from_VK_KHR_external_semaphore.VkExportSemaphoreCreateInfo',
-- 'VkExternalSemaphoreHandleTypeFlagBits', 'VkExternalSemaphoreProperties'
type VkExternalSemaphoreHandleTypeFlags = VkExternalSemaphoreHandleTypeFlagBits
-- | VkExternalSemaphoreFeatureFlags - Bitmask of
-- VkExternalSemaphoreFeatureFlagBitsKHR
--
-- = Description
--
-- @VkExternalSemaphoreFeatureFlags@ is a bitmask type for setting a mask
-- of zero or more 'VkExternalSemaphoreFeatureFlagBits'.
--
-- = See Also
--
-- 'VkExternalSemaphoreFeatureFlagBits', 'VkExternalSemaphoreProperties'
type VkExternalSemaphoreFeatureFlags = VkExternalSemaphoreFeatureFlagBits
