# Copyright (C) 2024 Paranoid Android
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Inherit from sm8450-common
$(call inherit-product, device/xiaomi/sm8450-common/common.mk)

# Call the proprietary setup
$(call inherit-product, vendor/xiaomi/cupid/cupid-vendor.mk)

# Camera
PRODUCT_SYSTEM_PROPERTIES += \
    ro.product.mod_device=cupid_global

# Characteristics
PRODUCT_CHARACTERISTICS := nosdcard

# Display
PRODUCT_ODM_PROPERTIES += \
    vendor.display.disable_3d_adaptive_tm=0 \
    vendor.display.enable_fb_scaling=1 \
    vendor.display.enable_rounded_corner=0 \
    vendor.display.enable_optimize_refresh=1

PRODUCT_VENDOR_PROPERTIES += \
    ro.vendor.display.ai_disp.enable=true \
    ro.vendor.display.hwc_thermal_dimming=true \
    ro.vendor.display.mi_calib.enable=true \
    ro.vendor.display.nature_mode.enable=true \
    ro.vendor.histogram.enable=true \
    ro.vendor.sre.enable=true \
    ro.vendor.xiaomi.bl.poll=true

# Fingerprint
PRODUCT_PACKAGES += \
    android.hardware.biometrics.fingerprint@2.3-service.xiaomi \
    libudfpshandler

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/rootdir/etc/init.cupid.rc:$(TARGET_COPY_OUT_VENDOR)/etc/init/init.cupid.rc

# Kernel
KERNEL_PREBUILT_DIR := $(LOCAL_PATH)-kernel

# Overlays
PRODUCT_PACKAGES += \
    AOSPACupidFrameworksOverlay \
    CupidFrameworksOverlay \
    CupidNfcOverlay \
    CupidSettingsProviderOverlay \
    CupidWifiOverlay \
    CupidWifiMainlineOverlay \
    CupidSettingsOverlay \
    CupidSettingsProviderOverlay \
    CupidSystemUIOverlay \
    CupidWifiOverlay \
    CupidWifiMainlineOverlay

# Sensors
PRODUCT_PACKAGES += \
    android.hardware.sensors@2.1-service.xiaomi-multihal \
    sensors.xiaomi

PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/sensors/hals.conf:$(TARGET_COPY_OUT_VENDOR)/etc/sensors/hals.conf

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)
