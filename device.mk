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

# Enforce generic ramdisk allow list
$(call inherit-product, $(SRC_TARGET_DIR)/product/generic_ramdisk.mk)

PRODUCT_SHIPPING_API_LEVEL := 34

#DEVICE_MANIFEST_FILE
DEVICE_MANIFEST_FILE += device/hardkernel/common/hidl_manifests/$(PRODUCT_SHIPPING_API_LEVEL)/manifest_common.xml
#DEVICE_MANIFEST_FILE += device/hardkernel/common/hidl_manifests/$(PRODUCT_SHIPPING_API_LEVEL)/manifest_ir.xml

ifeq ($(BUILD_WITH_MIRACAST),true)
DEVICE_MANIFEST_FILE += device/hardkernel/common/hidl_manifests/$(PRODUCT_SHIPPING_API_LEVEL)/manifest_wfd.xml
endif

DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += device/hardkernel/common/hidl_manifests/$(PRODUCT_SHIPPING_API_LEVEL)/device_matrix_product_amlogic.xml

ifeq ($(BUILD_WITH_VERIMATRIX_DRM),true)
DEVICE_PRODUCT_COMPATIBILITY_MATRIX_FILE += device/hardkernel/common/hidl_manifests/$(PRODUCT_SHIPPING_API_LEVEL)/device_matrix_product_amlogic_vmx_webclient.xml
endif

# Set Vendor SPL to match platform
VENDOR_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)

# Set boot SPL
BOOT_SECURITY_PATCH = $(PLATFORM_SECURITY_PATCH)

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.boot_security_patch=$(BOOT_SECURITY_PATCH)

PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false

PRODUCT_SOONG_NAMESPACES += \
    device/hardkernel/common \
    hardware/amlogic \
    vendor/amlogic/common \
    vendor/amlogic/reference \
    vendor/amlogic/$(PRODUCT_DIR) \
    packages/apps/OdroidSettings

PRODUCT_CHARACTERISTICS := tablet

PRODUCT_TAGS += dalvik.gc.type-precise

PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/init.amlogic.board.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/hw/init.amlogic.board.rc

#########################################################################
#
# Media codec
#
#########################################################################
PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/files/media_codecs.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs.xml
PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/files/media_codecs_performance.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_performance.xml
PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/files/media_codecs_google_performance_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_google_performance_video.xml

# for ccodec xml(decoder encoder audio dolby_vision)
PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/files/video/c2/media_codecs_amlogic_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_amlogic_video.xml \
    device/hardkernel/$(PRODUCT_DIR)/files/encoder/media_codecs_amlogic_encoder.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_amlogic_encoder.xml

# for performance xml(decoder encoder audio)
PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/files/video/c2/media_codecs_amlogic_performance_video.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_amlogic_performance_video.xml
PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/files/encoder/media_codecs_amlogic_performance_encoder.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_amlogic_performance_encoder.xml

# for oem partition without license files
ifneq ($(TARGET_BUILD_OEM_WITH_LICENSE_FILES), true)
ifeq ($(TARGET_BUILD_WITH_DOVI),true)
PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/files/video/dolby_vision/media_codecs_amlogic_dolby_vision.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_amlogic_dolby_vision.xml \
    device/hardkernel/$(PRODUCT_DIR)/files/video/dolby_vision/media_codecs_amlogic_performance_dolby_vision.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_amlogic_performance_dolby_vision.xml
endif
endif ### end for TARGET_BUILD_OEM_WITH_LICENSE_FILES

ifeq ($(TARGET_WITH_MEDIA_EXT), true)
PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/files/video/c2/media_codecs_amlogic_video_ext.xml:$(TARGET_COPY_OUT_VENDOR)/etc/media_codecs_amlogic_video_ext.xml
endif

#Display config
PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/files/mesondisplay.cfg:$(TARGET_COPY_OUT_VENDOR)/etc/mesondisplay.cfg \
    device/hardkernel/$(PRODUCT_DIR)/files/mesondisplay.cfg:recovery/root/sbin/mesondisplay.cfg

# Include drawables for all densities
PRODUCT_AAPT_CONFIG ?= normal large xlarge hdpi tvdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG ?= xhdpi


# for 120zh display mode support
PRODUCT_PACKAGES += DLGOverlay

#########################################################################
#
# Audio
#
#########################################################################
PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/files/audio_effects.conf:$(TARGET_COPY_OUT_VENDOR)/etc/audio_effects.conf

ifeq ($(TARGET_BUILD_TYPE_SOUNDBAR),true)
PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/files/mixer_paths_soundbar.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml
else
PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/files/mixer_paths.xml:$(TARGET_COPY_OUT_VENDOR)/etc/mixer_paths.xml
endif

#########################################################################
#
#  ATV
#
#########################################################################

ifeq ($(ODROID_BOARD), true)
DEVICE_PACKAGE_OVERLAYS := \
    device/hardkernel/$(PRODUCT_DIR)/overlay
else
ifeq ($(BOARD_COMPILE_ATV), false)
DEVICE_PACKAGE_OVERLAYS := \
    device/hardkernel/$(PRODUCT_DIR)/overlay
endif
endif # ODROID_BOARD

# setup dalvik vm configs.
$(call inherit-product, frameworks/native/build/tablet-10in-xhdpi-2048-dalvik-heap.mk)


#PRODUCT_COPY_FILES += \
#    frameworks/native/data/etc/android.software.picture_in_picture.xml:vendor/etc/permissions/android.software.picture_in_picture.xml

$(call inherit-product, device/hardkernel/common/products/mbox/s7d/device.mk)


# add ms12 v2 dap tuning file(dat/xml)
ifeq ($(TARGET_BUILD_TYPE_SOUNDBAR),true)
PRODUCT_COPY_FILES += \
     device/hardkernel/$(PRODUCT_DIR)/files/speaker_2.0.2.xml:$(TARGET_COPY_OUT_VENDOR)/etc/ms12_tuning.xml \
	 device/hardkernel/$(PRODUCT_DIR)/files/speaker_2.0.xml:$(TARGET_COPY_OUT_VENDOR)/etc/ms12_tuning_2.0.xml
PRODUCT_COPY_FILES += \
     device/hardkernel/$(PRODUCT_DIR)/files/speaker_2.0_0_internal_speaker_48000_6.dat:$(TARGET_COPY_OUT_VENDOR)/etc/ms12_tuning.dat \
	 device/hardkernel/$(PRODUCT_DIR)/files/speaker_2.0.2_0_internal_speaker_48000_6.dat:$(TARGET_COPY_OUT_VENDOR)/etc/ms12_tuning_2.0.2.dat
endif

#Dolby MS12 2.4 Decryption
include device/hardkernel/common/dolby_ms12/dolby_ms12.mk

#########################################################################
#
#  GPU
#
#########################################################################
PRODUCT_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/files/mali_platform.config:$(TARGET_COPY_OUT_VENDOR)/etc/mali_platform.config \
    device/hardkernel/$(PRODUCT_DIR)/files/aml_afrc_allowlist.config:$(TARGET_COPY_OUT_VENDOR)/etc/aml_afrc_allowlist.config

ifneq ($(ODROID_BOARD), true)
ifeq ($(BOARD_USES_DYNAMIC_FINGERPRINT),true)
PRODUCT_OEM_PROPERTIES := ro.product.name
PRODUCT_OEM_PROPERTIES += ro.product.brand
PRODUCT_OEM_PROPERTIES += ro.product.device
PRODUCT_OEM_PROPERTIES += ro.product.manufacturer
PRODUCT_OEM_PROPERTIES += ro.product.model
endif
endif # not ODROID_BOARD

ifeq ($(BOARD_HAS_GPS),true)
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.location.gps.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/android.hardware.location.gps.xml
endif


#########################################################################
#
#  ODROID Stuffs
#
#########################################################################
ifeq ($(ODROID_BOARD), true)
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/files/makebootini:$(TARGET_COPY_OUT_VENDOR)/bin/makebootini \
    $(LOCAL_PATH)/files/config.ini.template:$(TARGET_COPY_OUT_VENDOR)/etc/config.ini.template

# boblight
$(call inherit-product-if-exists, $(LOCAL_PATH)/boblight.mk)
endif
