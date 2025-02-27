#
# Copyright (C) 2013 The Android Open-Source Project
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

PRODUCT_DIR := odroidc5

PRODUCT_ANDROID_VERSION := 14
PRODUCT_UBOOT_CONFIG := s7d_odroidc5
PRODUCT_KERNEL_TARGET := odroidc5
PRODUCT_KERNEL_VERSION := 5.15
PRODUCT_KERNEL_DTS := s7d_s905x5m_odroidc5_android

ifneq ($(ANDROID_BUILD_TYPE), 64)
TARGET_ARCH := arm
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_VARIANT := cortex-a55
else
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_VARIANT := cortex-a55
TARGET_CPU_ABI := arm64-v8a

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_CPU_VARIANT := cortex-a55
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi

TARGET_SUPPORTS_32_BIT_APPS := true
TARGET_SUPPORTS_64_BIT_APPS := true
endif

TARGET_USES_64_BIT_BINDER := true

TARGET_NO_BOOTLOADER ?= false
TARGET_NO_RADIOIMAGE := true

TARGET_BOARD_PLATFORM := s7d
TARGET_BOOTLOADER_BOARD_NAME := odroidc5

#ifeq ($(BUILD_WITH_VERIMATRIX_DRM),true)
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
#endif

# Graphics & Display
USE_OPENGL_RENDERER := true
MAX_VIRTUAL_DISPLAY_DIMENSION := 3840
TARGET_APP_LAYER_USE_CONTINUOUS_BUFFER := true

#MESONHWC CONFIG
USE_HWC2 := true
HWC_DISPLAY_NUM := 1
HWC_PRIMARY_FRAMEBUFFER_WIDTH := 3840
HWC_PRIMARY_FRAMEBUFFER_HEIGHT := 2160
HWC_PRIMARY_CONNECTOR_TYPE ?= hdmi
#HWC_EXTEND_CONNECTOR_TYPE := panel
#HWC_ENABLE_HEADLESS_MODE := true
#HWC_ENABLE_SOFTWARE_VSYNC := true
HWC_ENABLE_PRIMARY_HOTPLUG := true
HWC_ENABLE_REAL_MODE := true
HWC_HDMI_FRAC_MODE := 2
HWC_VIDEO_DI := true
HWC_VIDEO_AIPROCESS_120 :=true
HWC_ENABLE_SEAMLESS_MODE_SWITCH := true
#HWC_ENABLE_SECURE_LAYER_PROCESS := true
#HWC_DISABLE_CURSOR_PLANE := true
GRALLOC_SAME_HEAP_ONE_LAYER := true
include hardware/amlogic/gralloc/gralloc.device.mk

include hardware/amlogic/hwcomposer/hwcomposer.device.mk

# Camera
USE_CAMERA_STUB := false
BOARD_HAVE_FRONT_CAM := false
BOARD_HAVE_BACK_CAM := false
BOARD_USE_USB_CAMERA := true
IS_CAM_NONBLOCK := true
BOARD_HAVE_FLASHLIGHT := false
BOARD_HAVE_HW_JPEGENC := true
CAMERA_SUPPORT_HW_JPEG := true

TARGET_USERIMAGES_USE_EXT4 := false
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USERIMAGES_SPARSE_EXT_DISABLED := true

BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs

BOARD_USERDATAIMAGE_PARTITION_SIZE := 576716800
BOARD_FLASH_BLOCK_SIZE := 4096

BOARD_EROFS_COMPRESSOR := eamfc
BOARD_EROFS_PCLUSTER_SIZE := 16384

BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := erofs

BOARD_USES_VENDORIMAGE := true
TARGET_COPY_OUT_VENDOR := vendor

BOARD_SYSTEMSDK_VERSIONS := 34

BOARD_ROOT_EXTRA_FOLDERS += odm

BUILDING_SYSTEM_EXT_IMAGE := true
BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE := erofs
TARGET_COPY_OUT_SYSTEM_EXT := system_ext

BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864

BOARD_ODM_EXTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_ODM_EXTIMAGE_PARTITION_SIZE := 16777216

ifeq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)
# 1024 + 512 + 256 MB
BOARD_SUPER_PARTITION_SIZE := 1879048192

BOARD_BUILD_SUPER_IMAGE_BY_DEFAULT := true

BOARD_SUPER_PARTITION_GROUPS := amlogic_dynamic_partitions

#dynamic partition
# 1024 + 512 MB
BOARD_AMLOGIC_DYNAMIC_PARTITIONS_SIZE := 1610612736

BOARD_AMLOGIC_DYNAMIC_PARTITIONS_PARTITION_LIST := system vendor product odm
BOARD_AMLOGIC_DYNAMIC_PARTITIONS_PARTITION_LIST += system_ext

BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
TARGET_COPY_OUT_VENDOR_DLKM := vendor_dlkm
BOARD_AMLOGIC_DYNAMIC_PARTITIONS_PARTITION_LIST += vendor_dlkm
BOARD_AVB_VENDOR_DLKM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
TARGET_COPY_OUT_SYSTEM_DLKM := system_dlkm
BOARD_AMLOGIC_DYNAMIC_PARTITIONS_PARTITION_LIST += system_dlkm
BOARD_AVB_SYSTEM_DLKM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

BOARD_ODM_DLKMIMAGE_FILE_SYSTEM_TYPE := erofs
TARGET_COPY_OUT_ODM_DLKM := odm_dlkm
BOARD_AMLOGIC_DYNAMIC_PARTITIONS_PARTITION_LIST += odm_dlkm
BOARD_AVB_ODM_DLKM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

ifeq ($(BUILDING_INIT_BOOT_IMAGE),true)
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE := 8388608
BOARD_AVB_INIT_BOOT_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
endif

BOARD_EXT4_SHARE_DUP_BLOCKS := true

BOARD_KERNEL_CMDLINE += bootconfig

BOARD_BOOTCONFIG += androidboot.dynamic_partitions=true

BOARD_INCLUDE_DTB_IN_BOOTIMG ?= true
endif

ifeq ($(BUILD_WITH_UDC), true)
BOARD_ROOT_EXTRA_FOLDERS += metadata
endif

BOARD_ODMIMAGE_FILE_SYSTEM_TYPE := erofs
BOARD_USES_ODMIMAGE := true

BOARD_USES_METADATA_PARTITION := true

BOARD_USES_PRODUCTIMAGE := true
BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE := erofs
TARGET_COPY_OUT_PRODUCT := product

BOARD_AVB_SYSTEM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_SYSTEM_EXT_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_PRODUCT_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_VENDOR_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_ODM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256

BOARD_RAMDISK_USE_LZ4 := true

BOARD_DTBIMAGE_PARTITION_SIZE := 258048

BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864

BOARD_DTBOIMG_PARTITION_SIZE := 2097152

BOARD_BOOTCONFIG += androidboot.dtbo_idx=0

# add androidboot.boot_devices for func GetBlockDeviceSymlinks
# to create a new link as /dev/block/by-name/xxx (partition names)
# Because avb Verified will open the path /dev/block/by-name/vbmeta
BOARD_BOOTCONFIG += "androidboot.boot_devices=soc/fe08c000.mmc"

ifneq ($(USE_USB_AS_HOST),true)
BOARD_BOOTCONFIG += "otg_device=1"
endif

# use uvm
BOARD_BOOTCONFIG += "use_uvm=1"

TARGET_SUPPORT_USB_BURNING_V2 := true
TARGET_AMLOGIC_RES_PACKAGE := device/hardkernel/common/logo_img_files
#TARGET_AMLOGIC_RES_PACKAGE := device/hardkernel/$(PRODUCT_DIR)/logo_img_files

#BOARD_HAL_STATIC_LIBRARIES := libhealthd.mboxdefault

USE_E2FSPROGS := true

BOARD_KERNEL_BASE := 0x0
BOARD_KERNEL_OFFSET := 0x2080000

BOARD_USES_GENERIC_AUDIO := false
BOARD_USES_ALSA_AUDIO := true
TARGET_USE_BLOCK_BASE_UPGRADE := true
TARGET_OTA_UPDATE_DTB := true
#TARGET_RECOVERY_DISABLE_ADB_SIDELOAD := true
#TARGET_OTA_PARTITION_CHANGE := true


TARGET_COPY_OUT_ODM := odm

include device/hardkernel/common/sepolicy.mk

#MALLOC_SVELTE := true

WITH_DEXPREOPT := true
PRODUCT_FULL_TREBLE_OVERRIDE := true
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
TARGET_USES_MKE2FS := true

PRODUCT_USE_VNDK_OVERRIDE := true
BOARD_VNDK_VERSION := current
BOARD_BOOT_HEADER_VERSION := 4
BOARD_INCLUDE_RECOVERY_DTBO ?= true

ifeq ($(BUILDING_INIT_BOOT_IMAGE),true)
BOARD_INIT_BOOT_HEADER_VERSION := 4
BOARD_MKBOOTIMG_INIT_ARGS += --header_version $(BOARD_INIT_BOOT_HEADER_VERSION)
endif

#voice record of SEI BT remote control
#BOARD_ENABLE_HBG := true

# introduced and must set in Q, also can used in P, see the ReadMe.txt at below dir:
TARGET_HOST_TOOL_PATH := vendor/amlogic/common/tools/host-tool

#Enable SVELTE malloc
#MALLOC_SVELTE := true

#put here after all vendor configuration assigned evaluated.
include device/hardkernel/common/soong_config/soong_config.mk

#########################################################################
#
#           OEM Partitions based dynamic fingerprint
#
#########################################################################
ifneq ($(ODROID_BOARD), true)
ifeq ($(BOARD_USES_DYNAMIC_FINGERPRINT),true)
#Building raw OEM images with "make custom_images"
PRODUCT_CUSTOM_IMAGE_MAKEFILES := \
    device/hardkernel/odroidc5/oem/oem.mk

#re-sign the raw ext4 OEM image
ifeq ($(filter $(MAKECMDGOALS),custom_images),)
BOARD_CUSTOMIMAGES_PARTITION_LIST := oem
endif
BOARD_AVB_OEM_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_OEM_ALGORITHM := SHA256_RSA4096
BOARD_AVB_OEM_ADD_HASHTREE_FOOTER_ARGS += --hash_algorithm sha256
BOARD_AVB_OEM_ROLLBACK_INDEX_LOCATION := 1
BOARD_AVB_OEM_PARTITION_SIZE := 33554432
ifneq ($(wildcard vendor/amlogic/restricted_libs/oem/ross),)
ifeq ($(ATV_LAUNCHER), amati)
BOARD_AVB_OEM_IMAGE_LIST := \
    vendor/amlogic/restricted_libs/oem/ross/oem_gtv/oem.img
else
BOARD_AVB_OEM_IMAGE_LIST := \
    vendor/amlogic/restricted_libs/oem/ross/oem_atv/oem.img
endif
else
ifeq ($(ATV_LAUNCHER), amati)
BOARD_AVB_OEM_IMAGE_LIST := \
    device/hardkernel/odroidc5/oem/oem.img
else
BOARD_AVB_OEM_IMAGE_LIST := \
    device/hardkernel/odroidc5/oem/oem_atv/oem.img
endif
endif

#Set the OEM partition mounting flag to Read Only
TARGET_RECOVERY_FSTYPE_MOUNT_OPTIONS := ext4=ro
#Building OTAs for OEM properties
ifeq ($(ATV_LAUNCHER), amati)
OEM_OTA_CONFIG := device/hardkernel/odroidc5/oem/oem.prop
else
OEM_OTA_CONFIG := device/hardkernel/odroidc5/oem/oem_atv.prop
endif

endif
endif # not ODROID_BOARD

ifeq ($(BOARD_USES_VBMETA_SYSTEM),true)
# Enable chain partition for system.
BOARD_AVB_VBMETA_SYSTEM := system system_ext
BOARD_AVB_VBMETA_SYSTEM += system_dlkm
BOARD_AVB_VBMETA_SYSTEM_KEY_PATH := external/avb/test/data/testkey_rsa2048.pem
BOARD_AVB_VBMETA_SYSTEM_ALGORITHM := SHA256_RSA2048
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_VBMETA_SYSTEM_ROLLBACK_INDEX_LOCATION := 2
endif

#GKI firstlist and blacklist modules
RAMDISK_KERNEL_MODULES_LOAD_FIRSTLIST :=

RAMDISK_KERNEL_MODULES_LOAD_BLACKLIST += hifidsp.ko \
					 snd-soc-aml_codec_tl1_acodec.ko \
					 snd-soc-tas5805.ko
