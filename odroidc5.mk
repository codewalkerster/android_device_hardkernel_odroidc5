# Copyright (C) 2011 Amlogic Inc
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

TARGET_BUILD_KERNEL_VERSION ?= 5.15
#
# This file is the build configuration for a full Android
# build for Meson reference board.
#
ifneq ($(ODROID_BOARD), true)
#ATV version, need compile DRM related modules
ifneq ($(BOARD_COMPILE_ATV),false)
BOARD_COMPILE_CTS := true
ATV_LAUNCHER ?= amati
endif
endif # not ODROID_BOARD

PRODUCT_DIR := odroidc5

PRODUCT_DTB_TARGET := common/common14-5.15/out/android14-5.15/dist/s7d_s905x5m_odroidc5_android.dtb
PRODUCT_DTBO_TARGET := common/common14-5.15/out/android14-5.15/dist/*.dtbo

include device/hardkernel/common/BoardConfig.mk

########################################################################
# put ms12 ddp dtshd dovi related to oem partitions.
########################################################################
TARGET_BUILD_OEM_WITH_LICENSE_FILES := true

#config of AM301 1080P UI surfaceflinger
PRODUCT_PRODUCT_PROPERTIES += \
    ro.surface_flinger.max_graphics_width=1920  \
    ro.surface_flinger.max_graphics_height=1080

#########################################################################
#
#                          CCodec
#
##########################################################################
VENDOR_MEDIA_CODEC2_SUPPORT := true
VENDOR_ENCODER_SUPPORT_HCODEC := true
VENDOR_ENCODER_SUPPORT_WAVE420 := true

#########################################################################
#
#                          DV
#
##########################################################################
#VENDOR_MEDIA_DV_SUPPORT := true


########################################################################
#
##                            CLOSE KO
#
#########################################################################
#kernel version kernel
TARGET_BUILD_KERNEL_USING_14_5.15 ?= true

#hdr10_tmo
HDR10_TMO_MODULE := true
include device/hardkernel/common/video_algorithm/hdr10_tmo/hdr10_tmo.mk

#cuva
CUVA_MODULE := true
include device/hardkernel/common/video_algorithm/cuva/cuva.mk

#integrate dnlp/hdr_tmo/cuva
#ALGORITHM_MODULE := true
#include device/hardkernel/common/video_algorithm/algorithm/algorithm.mk

#fbc
SOFT_AFBC_MODULE := true
include device/hardkernel/common/soft_afbc/soft_afbc.mk

ifneq ($(CONFIG_DEVICE_LOW_RAM), true)
BUILD_WITH_IMG_DEC := true
endif

$(call inherit-product, device/hardkernel/common/products/mbox/product_mbox.mk)
$(call inherit-product, device/hardkernel/$(PRODUCT_DIR)/device.mk)
$(call inherit-product, device/hardkernel/common/device.mk)
$(call inherit-product, device/hardkernel/$(PRODUCT_DIR)/vendor_prop.mk)
$(call inherit-product-if-exists, vendor/amlogic/$(PRODUCT_DIR)/device-vendor.mk)

#add feature mediashell.vp9_mirror
PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/permissions/com.google.android.apps.mediashell.vp9_mirror.xml:$(TARGET_COPY_OUT_PRODUCT)/etc/permissions/com.google.android.apps.mediashell.vp9_mirror.xml

#########################################################################
#
#                                                CTC
#
#########################################################################
BUILD_WITH_CTC_MEDIAPROCESSOR := true

#########################################################################
#
#  Amlogic Media Platform API
#
#########################################################################
BUILD_WITH_AML_MP := true

PRODUCT_NAME := $(TARGET_PRODUCT)
PRODUCT_DEVICE := $(TARGET_PRODUCT)
PRODUCT_BRAND := Amlogic
PRODUCT_MODEL := $(TARGET_PRODUCT)
PRODUCT_MANUFACTURER := Amlogic

PRODUCT_PROPERTY_OVERRIDES += \
    ro.soc.manufacturer=Amlogic \
    ro.soc.model=AMLS905X5M

PRODUCT_TYPE := mbox

BOARD_AML_VENDOR_PATH := vendor/amlogic/common/
BOARD_WIDEVINE_TA_PATH := vendor/amlogic/

OTA_UP_PART_NUM_CHANGED := true

PLATFORM_TDK_VERSION := 318
BOARD_AML_SOC_TYPE ?= S905X5M
BOARD_AML_TDK_KEY_PATH := device/hardkernel/common/tdk_keys/
ifeq ($(ODROID_BOARD), true)
BUILD_WITH_AVB := false
BOARD_USES_VBMETA_SYSTEM := false
else
BUILD_WITH_AVB := true
BOARD_USES_VBMETA_SYSTEM := true
endif # ODROID_BOARD
BUILD_WITH_UDC := false

#LAUNCH_VERSION default U
LAUNCH_VERSION ?= U

TARGET_GPT_PART ?= true
BUILDING_INIT_BOOT_IMAGE ?= true

# use hwc 3 AIDL service
HWC_ENABLE_AIDL := true

ifneq ($(KERNEL_A32_SUPPORT),true)
BOARD_PREBUILT_BOOTIMAGE := device/hardkernel/odroidc5-kernel/5.15/gki/boot-lz4.img
TARGET_NO_KERNEL := true
BOARD_AVB_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem
BOARD_AVB_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_BOOT_ROLLBACK_INDEX := $(PLATFORM_SECURITY_PATCH_TIMESTAMP)
BOARD_AVB_BOOT_ROLLBACK_INDEX_LOCATION := 3
else
TARGET_NO_KERNEL ?= false
endif

AB_OTA_UPDATER :=true
BOARD_USES_ODM_EXTIMAGE := true

BOARD_USES_VENDOR_DLKMIMAGE := true
BOARD_USES_ODM_DLKMIMAGE := true
BOARD_USES_SYSTEM_DLKMIMAGE := true

ifeq ($(ODROID_BOARD), true)
ifeq ($(AB_OTA_UPDATER), true)
AML_GPT_PART := device/hardkernel/odroidc5/part_table_non_vab_5_15.txt
else
AML_GPT_PART := device/hardkernel/odroidc5/part_table_non_ab_vab_5_15.txt
endif
else
AML_GPT_PART := device/hardkernel/odroidc5/part_table_5_15.txt
endif

ifeq ($(AB_OTA_UPDATER),true)
BUILDING_VENDOR_BOOT_IMAGE ?= true
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
endif

PRODUCT_USE_DYNAMIC_PARTITIONS := true
#BOARD_BUILD_SYSTEM_ROOT_IMAGE := true

#########################################################################
#
#  SECURE BOOT V3
#
#########################################################################
#########Support compiling out encrypted zip/aml_upgrade_package.img directly

BOARD_AML_SECUREBOOT_SOC_TYPE := sc2

PRODUCT_GOOGLEREF_SECURE_BOOT := false
ifeq ($(PRODUCT_GOOGLEREF_SECURE_BOOT),true)
PRODUCT_GOOGLEREF_SECURE_BOOT_TOOL := ./device/hardkernel/$(PRODUCT_DIR)/tools/amlogic-sign-odroidc5.sh
endif

#########################################################################
#
#  Dm-Verity
#
#########################################################################
#TARGET_USE_SECURITY_DM_VERITY_MODE_WITH_TOOL := true

#########################################################################
#
#                      WiFi and Bluetooth
#
#########################################################################
include vendor/amlogic/common/wifi_bt/wifi/configs/wifi.mk
BOARD_HAVE_BLUETOOTH := true
include vendor/amlogic/common/wifi_bt/bluetooth/configs/bluetooth.mk

#########################################################################
#
# Audio
#
#########################################################################
BOARD_ALSA_AUDIO=tiny

#########################################################################
#
#  PlayReady DRM
#
#########################################################################
#export BOARD_PLAYREADY_LEVEL=1 for PlayReady+OPTEE+TVP

#########################################################################
#
#  Verimatrix DRM
#
##########################################################################
#verimatrix web
BUILD_WITH_VIEWRIGHT_WEB := false
#verimatrix stb
BUILD_WITH_VIEWRIGHT_STB := false

#########################################################################

#########################################################################
#
#  Widevine CAS
#
#########################################################################
BUILD_WITH_WIDEVINECAS := false

#########################################################################

ifneq ($(ODROID_BOARD), true)
#########################################################################
#
#  WifiDisplay
#
##########################################################################
ifeq ($(BOARD_COMPILE_ATV), false)
BUILD_WITH_MIRACAST := true
endif
endif # not ODROID_BOARD

#########################################################################

########################################################################
#
#                        dsp_util
#
########################################################################
PRODUCT_PACKAGES += \
    dsp_util \
    hifi4_rpc_test \
    hifi4rpc_client_test

########################################################################
#
#                          Netflix
#
#########################################################################
#TARGET_BUILD_NETFLIX:= true
#TARGET_BUILD_NETFLIX_MGKID := true
#TARGET_BUILD_NETFLIX_MODELGROUP:= XXXXX

ifneq ($(wildcard vendor/amlogic/restricted_libs/nts_ross.mk),)
include vendor/amlogic/restricted_libs/nts_ross.mk
endif

########################################################################
#
#                          Audio License Decoder
#
########################################################################
TARGET_DOLBY_MS12_VERSION ?= 0
ifeq ($(TARGET_DOLBY_MS12_VERSION), 2)
    TARGET_BUILD_DOLBY_MS12_V2 := true
else
    #TARGET_BUILD_DOLBY_MS12 := true
endif

#TARGET_BUILD_DOLBY_DDP := true
TARGET_BUILD_DTSHD := true

#######################################################################
#
#           enable MIC toggle if FFM is enabled
#
#######################################################################
BOARD_ENABLE_LIGHT_CONTROL := true
ifeq ($(BOARD_ENABLE_FAR_FIELD_AEC), true)
BOARD_HAS_MIC_TOGGLE := true
endif

########################################################################
#
#                          Audio License Decoder
#  Dolby license:
#  TARGET_DOLBY_VERSION: use to control the dolby version
#  ms12_v2: support ms12 v2.4
#  ms12_v1: support ms12 v1.3
#  ddp_only: only support ddp decoder
#  non_dolby: not support dolby decoder
#
#  DTS license:
#  TARGET_DTS_VERSION: use to control the dts version
#  dtshd: support dts hd decoder
#  non_dts: not support dts decoder
########################################################################
TARGET_DOLBY_VERSION ?= non_dolby
TARGET_DTS_VERSION ?= non_dts
GEN_AUDIO_POLICY_DURING_BUILD_TIME := true
$(call inherit-product, device/hardkernel/common/audio.mk)
########################################################################
#  This control decide whether it need to be compatible
#  between ms12_v2 and non_dolby version
########################################################################

ifneq ($(TARGET_DOLBY_VERSION), ms12_v1)

TARGET_BUILD_COMPATIBLE_MS12_V2 ?= true

ifeq ($(TARGET_DOLBY_VERSION), ms12_v2)
    TARGET_INSTALL_DOLBY_MS12_V2 :=true
else ifeq ($(TARGET_BUILD_COMPATIBLE_MS12_V2), true)
    TARGET_INSTALL_DOLBY_MS12_V2 :=true
    $(warning "This non ms12 build, but it is compatible with ms12")
endif
endif

PRODUCT_PRODUCT_PROPERTIES += ro.vendor.audio.use.ms12heaac=true

########################################################################
###                       Add ini config
########################################################################
ifeq ($(TARGET_BUILD_TYPE_SOUNDBAR),true)
    PRODUCT_PRODUCT_PROPERTIES += vendor.tv.model_name=ODROIDC5
    PRODUCT_COPY_FILES += \
        device/hardkernel/common/audio/audio_config/model_sum.ini:$(TARGET_COPY_OUT_VENDOR)/etc/audio_config/model_sum.ini \
        device/hardkernel/common/audio/audio_config/AMLOGIC_SOC_ROSS.ini:$(TARGET_COPY_OUT_VENDOR)/etc/audio_config/AMLOGIC_SOC_ROSS.ini \
        device/hardkernel/common/audio/audio_config/EXT_AMP_ROSS.ini:$(TARGET_COPY_OUT_VENDOR)/etc/audio_config/EXT_AMP_ROSS.ini \
        device/hardkernel/common/audio/audio_config/AUDIO_EFFECT_ROSS.ini:$(TARGET_COPY_OUT_VENDOR)/etc/audio_config/AUDIO_EFFECT_ROSS.ini
endif

#################################################################################

#TARGET_BUILD_WITH_DOVI := true

BOARD_USES_USB_PM := true

#########################################################################
#
#           OEM Partitions based dynamic fingerprint
#
#########################################################################
ifeq ($(ODROID_BOARD), true)
BOARD_USES_DYNAMIC_FINGERPRINT ?= false
else
BOARD_USES_DYNAMIC_FINGERPRINT ?= true
endif # ODROID_BOARD

my_src_fstab := fstab.ab_oem

ifeq ($(ODROID_BOARD), true)
my_dst_fstab := $(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.amlogic
ifneq ($(AB_OTA_UPDATER), true)
my_src_fstab := fstab.oem
endif

PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/$(my_src_fstab).hardkernel:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.amlogic \
    device/hardkernel/$(PRODUCT_DIR)/$(my_src_fstab).hardkernel:$(my_dst_fstab)
else
my_dst_fstab := $(TARGET_COPY_OUT_VENDOR_RAMDISK)/first_stage_ramdisk/fstab.amlogic

PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/$(my_src_fstab).amlogic:$(TARGET_COPY_OUT_VENDOR)/etc/fstab.amlogic \
    device/hardkernel/$(PRODUCT_DIR)/$(my_src_fstab).amlogic:$(my_dst_fstab)
endif # ODROID_BOARD


$(call inherit-product, device/hardkernel/common/media.mk)

include device/hardkernel/common/gpu/vale-user-arm64.mk

include device/hardkernel/common/products/mbox/s7d/s7d.mk

#########################################################################
#
#                  ueventd parallel restorecon dirs
#
#
#########################################################################
PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/ueventd.parallel.rc:$(TARGET_COPY_OUT_ODM)/etc/ueventd.rc

#########################################################################
#
##                                     Auto Patch
#                          must put in the end of mk files
##########################################################################
include $(wildcard vendor/amlogic/common/pre_submit_for_google/Android.mk)

#overlay for seamless switch
 PRODUCT_PACKAGES += \
     MatchContentOverlay

########################################################################
#
####                          AVSync Tune Property
#
###########################################################################
include device/hardkernel/$(PRODUCT_DIR)/AVSync.mk

PRODUCT_SUPPORT_4K_UI := true
PRODUCT_SUPPORT_ATK_UI := true
TARGET_BUILD_GMS := true

BOARD_HAS_GPS := true

ifneq ("$(wildcard vendor/gapps/arm64/arm64-vendor.mk)","")
PRODUCT_BROKEN_VERIFY_USES_LIBRARIES := true
    $(call inherit-product, vendor/gapps/arm64/arm64-vendor.mk)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/oem/oem.img:$(PRODUCT_OUT)/oem.img
