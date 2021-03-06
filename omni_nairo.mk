# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file is the build configuration for a full Android
# build for grouper hardware. This cleanly combines a set of
# device-specific aspects (drivers) with a device-agnostic
# product configuration (apps).
#

PRODUCT_EXTRA_VNDK_VERSIONS := 29

VENDOR_EXCEPTION_PATHS := omni \
    motorola \
    gapps \
    microg

# Sample: This is where we'd set a backup provider if we had one
# $(call inherit-product, device/sample/products/backup_overlay.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# Get the prebuilt list of APNs
$(call inherit-product, vendor/omni/config/gsm.mk)

# Inherit from the common Open Source product configuration
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

PRODUCT_USE_DYNAMIC_PARTITIONS := true
PRODUCT_BUILD_SUPER_PARTITION := false
PRODUCT_BUILD_PRODUCT_IMAGE  := true
PRODUCT_BUILD_ODM_IMAGE := false

# tell update_engine to not change dynamic partition table during updates
# needed since our qti_dynamic_partitions does not include
# vendor and odm and we also dont want to AB update them
TARGET_ENFORCE_AB_OTA_PARTITION_LIST := true

PRODUCT_BUILD_RAMDISK_IMAGE := true
BOARD_BUILD_SYSTEM_ROOT_IMAGE := false
TARGET_NO_RECOVERY := false
#BOARD_INCLUDE_RECOVERY_DTBO = true
BOARD_BUILD_RETROFIT_DYNAMIC_PARTITIONS_OTA_PACKAGE := false
BOARD_USES_RECOVERY_AS_BOOT := false

# must be before including omni part
TARGET_BOOTANIMATION_SIZE := 1080p
AB_OTA_UPDATER := true

DEVICE_PACKAGE_OVERLAYS += device/motorola/nairo/overlay/device
DEVICE_PACKAGE_OVERLAYS += vendor/omni/overlay/CarrierConfig

# Inherit from our custom product configuration
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from hardware-specific part of the product configuration
$(call inherit-product, device/motorola/nairo/device.mk)

PRODUCT_SHIPPING_API_LEVEL := 29

# Discard inherited values and use our own instead.
PRODUCT_NAME := omni_nairo
PRODUCT_DEVICE := nairo
PRODUCT_BRAND := motorola
PRODUCT_MANUFACTURER := motorola
PRODUCT_MODEL := moto g 5G plus

TARGET_DEVICE := nairo
PRODUCT_SYSTEM_NAME := nairo_retail

VENDOR_RELEASE := 10/QPN30.37-Q3-42-51/264b33:user/release-keys
BUILD_FINGERPRINT := motorola/nairo_retail/nairo:$(VENDOR_RELEASE)
OMNI_BUILD_FINGERPRINT := motorola/nairo_retail/nairo:$(VENDOR_RELEASE)
OMNI_PRIVATE_BUILD_DESC := "'nairo_retail-user 10 QPN30.37-Q3-42-51 264b33 release-keys'"

PLATFORM_SECURITY_PATCH_OVERRIDE := 2020-09-01

TARGET_VENDOR := motorola

PRODUCT_PRODUCT_PROPERTIES += \
    debug.sf.enable_gl_backpressure=0 \
    debug.sf.enable_hwc_vds=1 \
    debug.sf.latch_unsignaled=1

$(call inherit-product, vendor/motorola/nairo/nairo-vendor.mk)

ifeq ($(WITH_GAPPS),true)
# https://gitlab.com/darkobas/android_vendor_gapps
$(call inherit-product, vendor/gapps/config.mk)
endif

ifeq ($(WITH_MICROG),true)
# https://github.com/boulzordev/android_prebuilts_prebuiltapks
$(call inherit-product, vendor/microg/microg.mk)
endif

