# Copyright (C) 2024 Amlogic Inc
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
# Tune the AVSync
###############################################################################
###First part, Sink Device Support Format
##E-EDID Max, PCM < DD < DDP < MAT
#out PCM(default 15)
PRODUCT_PROPERTY_OVERRIDES += \
        vendor.media.audio.hal.ms12.pcmout=15
#out DD(AC3) (default 50)
PRODUCT_PROPERTY_OVERRIDES += \
        vendor.media.audio.hal.ms12.ddout=85
#out DDP(EAC3) (default 95)
PRODUCT_PROPERTY_OVERRIDES += \
        vendor.media.audio.hal.ms12.ddpout=75
#out MAT(default 70)
PRODUCT_PROPERTY_OVERRIDES += \
        vendor.media.audio.hal.ms12.matout=85

###Second part, Tunneled, Stream Audio format
#AC4(default 30)
PRODUCT_PROPERTY_OVERRIDES += \
        vendor.media.audio.hal.ms12.tunnel.ac4_hdmi=0
#DDP(51/Atmos) (default 70)
PRODUCT_PROPERTY_OVERRIDES += \
        vendor.media.audio.hal.ms12.tunnel.ddp_hdmi=30
#HEAAC(default 70)
PRODUCT_PROPERTY_OVERRIDES += \
        vendor.media.audio.hal.ms12.tunnel.pcm=-10

###Third part, Non-Tunnel, Stream Audio format
#AC4(default 70)
PRODUCT_PROPERTY_OVERRIDES += \
        vendor.media.audio.hal.ms12.nontunnel.ac4=40
#DDP(51/Atmos) (default 20)
#PRODUCT_PROPERTY_OVERRIDES += \
#        vendor.media.audio.hal.ms12.nontunnel.ddp=20
#HEAAC(default 10)
#PRODUCT_PROPERTY_OVERRIDES += \
#        vendor.media.audio.hal.ms12.nontunnel.pcm=10

###fourth part, non-ms12(ddp license), non-tunnel mode, and CVBS
PRODUCT_PROPERTY_OVERRIDES += \
vendor.media.audio.hal.speaker_latency.raw=20
