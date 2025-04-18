# Copyright (C) 2010 Amlogic Inc
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

LOCAL_PATH := $(call my-dir)
LOCAL_PATH := device/hardkernel/odroidc5

include device/hardkernel/common/factory.mk
include $(LOCAL_PATH)/kernel_config_build.mk

-include device/hardkernel/common/build/amlogic/odm_ext.mk

# generate selfinstall_boot.scr for device
-include device/hardkernel/common/build/hardkernel/BuildSelfinstallBootScript.mk

# generate boot.scr for device
-include device/hardkernel/common/build/hardkernel/RebuildBootScript.mk

# generate gpt image for device
-include device/hardkernel/common/build/amlogic/BuildGpt.mk

# generate fat image for device
-include device/hardkernel/common/build/hardkernel/BuildFatImg.mk

# generate update_boot.scr for device
-include device/hardkernel/common/build/hardkernel/BuildUpdateBootScript.mk

# generate fat image for device
-include device/hardkernel/common/build/hardkernel/BuildUpdateFatImg.mk
