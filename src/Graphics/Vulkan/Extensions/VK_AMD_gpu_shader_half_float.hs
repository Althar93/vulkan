{-# language Strict #-}
{-# language CPP #-}
{-# language PatternSynonyms #-}
{-# language OverloadedStrings #-}

module Graphics.Vulkan.Extensions.VK_AMD_gpu_shader_half_float
  ( pattern VK_AMD_GPU_SHADER_HALF_FLOAT_SPEC_VERSION
  , pattern VK_AMD_GPU_SHADER_HALF_FLOAT_EXTENSION_NAME
  ) where

import Data.String
  ( IsString
  )





-- No documentation found for TopLevel "VK_AMD_GPU_SHADER_HALF_FLOAT_SPEC_VERSION"
pattern VK_AMD_GPU_SHADER_HALF_FLOAT_SPEC_VERSION :: Integral a => a
pattern VK_AMD_GPU_SHADER_HALF_FLOAT_SPEC_VERSION = 1
-- No documentation found for TopLevel "VK_AMD_GPU_SHADER_HALF_FLOAT_EXTENSION_NAME"
pattern VK_AMD_GPU_SHADER_HALF_FLOAT_EXTENSION_NAME :: (Eq a ,IsString a) => a
pattern VK_AMD_GPU_SHADER_HALF_FLOAT_EXTENSION_NAME = "VK_AMD_gpu_shader_half_float"
