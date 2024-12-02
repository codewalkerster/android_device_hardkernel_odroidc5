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

#
# This file is the build configuration for a full Android
# build for Meson reference board.
###############################################################################



###############################################################################
# !!! This line of code needs to be on the last line.
# vendor_prop.mk defines the default prop values.
# if change the default values, need define prop above.
$(call inherit-product, device/hardkernel/common/products/mbox/s7d/vendor_prop.mk)

PRODUCT_PROPERTY_OVERRIDES += \
    bluetooth.core.gap.le.privacy.enabled=true

###############################################################################
#    Please be care of this property which tell you the type of default remote
#    This is used for smoking test which is necessary to ATV/GTV project.
#    FORMAT :  RemoteType_RemoteName
#    RemoteType : IR    (only support IR)
#                 IR_BT (support IR and BT both, GTVS/ATV default type)
#                 BT    (only support BT, such as B12.)
#    RemoteName : Bt remote name,such as G20,B12
#    Example:
#             GTVS/ATV : IR_BT_G10
#                        IR_BT_G20
#                        BT_B12
#             ASOP     : IR_NONE
#
##############################################################################
ifeq ($(ODROID_BOARD), true)
PRODUCT_PROPERTY_OVERRIDES += \
    sys.vendor.remote.type=IR_NONE
else
ifneq ($(BOARD_COMPILE_ATV),false)
PRODUCT_PROPERTY_OVERRIDES += \
        sys.vendor.remote.type=BT_B12
else
PRODUCT_PROPERTY_OVERRIDES += \
    sys.vendor.remote.type=IR_NONE
endif
endif # ODROID_BOARD

PRODUCT_PROPERTY_OVERRIDES += \
    vendor.media.mediahal.videodec.media.c2_segment0_max_size=0\
    vendor.media.mediahal.videodec.media.c2_prealloc_4k_segment0_size=240 \
    vendor.media.mediahal.videodec.media.c2_prealloc_segment0_size=146800640 \
    vendor.media.mediahal.videodec.media.c2_prealloc_segment1_size=73400320 \
    vendor.media.mediahal.videodec.media.c2_prealloc_segment2_size=33554432

#need promote benchmark
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.platform.need.bench.promote=true
