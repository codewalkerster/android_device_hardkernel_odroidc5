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

PRODUCT_MAKEFILES := $(LOCAL_DIR)/odroidc5.mk
PRODUCT_MAKEFILES += $(LOCAL_DIR)/odroidc5_hybrid.mk
PRODUCT_MAKEFILES += $(LOCAL_DIR)/odroidc5_soundbar.mk
PRODUCT_MAKEFILES += $(LOCAL_DIR)/odroidc5_atv.mk
PRODUCT_MAKEFILES += $(LOCAL_DIR)/odroidc5_cbs.mk
COMMON_LUNCH_CHOICES := \
    odroidc5-eng \
    odroidc5-user \
    odroidc5-userdebug \
    odroidc5_atv-eng \
    odroidc5_atv-user \
    odroidc5_atv-userdebug \
    odroidc5_cbs-eng \
    odroidc5_cbs-user \
    odroidc5_cbs-userdebug \
    odroidc5_soundbar-eng \
    odroidc5_soundbar-user \
    odroidc5_soundbar-userdebug \
    odroidc5_hybrid-eng \
    odroidc5_hybrid-user \
    odroidc5_hybrid-userdebug
