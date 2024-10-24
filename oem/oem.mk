CUSTOM_IMAGE_MOUNT_POINT := oem
CUSTOM_IMAGE_PARTITION_SIZE := 31457280
CUSTOM_IMAGE_FILE_SYSTEM_TYPE := ext4
CUSTOM_IMAGE_DICT_FILE := device/hardkernel/odroidc5/oem/oem_dict.txt
CUSTOM_IMAGE_SELINUX := true
ifeq ($(ATV_LAUNCHER), amati)
CUSTOM_IMAGE_COPY_FILES := device/hardkernel/odroidc5/oem/oem.prop:oem.prop
else
CUSTOM_IMAGE_COPY_FILES := device/hardkernel/odroidc5/oem/oem_atv.prop:oem.prop
endif

ifeq ($(TARGET_BUILD_OEM_WITH_LICENSE_FILES), true)

ifeq ($(TARGET_BUILD_WITH_DOVI),true)
CUSTOM_IMAGE_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/files/dovi.ko:overlay/dovi.ko \
    device/hardkernel/$(PRODUCT_DIR)/dovi_fw.bin:firmware/dovi_fw.bin

CUSTOM_IMAGE_COPY_FILES += \
    device/hardkernel/$(PRODUCT_DIR)/files/video/dolby_vision/media_codecs_amlogic_dolby_vision.xml:/etc/media_codecs_amlogic_dolby_vision.xml \
    device/hardkernel/$(PRODUCT_DIR)/files/video/dolby_vision/media_codecs_amlogic_performance_dolby_vision.xml:/etc/media_codecs_amlogic_performance_dolby_vision.xml
endif ### end for TARGET_BUILD_WITH_DOVI

include device/hardkernel/common/audio/oem.mk
endif # TARGET_BUILD_OEM_WITH_LICENSE_FILES
