#
# Copyright (C) 2023 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from corfur device
$(call inherit-product, device/motorola/corfur/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_corfur
PRODUCT_DEVICE := corfur
PRODUCT_MANUFACTURER := motorola
PRODUCT_BRAND := motorola
PRODUCT_MODEL := moto g71 5G

PRODUCT_GMS_CLIENTID_BASE := android-motorola

PRODUCT_BUILD_PROP_OVERRIDES += \
    TARGET_PRODUCT=corfur_g \
    PRIVATE_BUILD_DESC="corfur_g-user 12 S2RUBS32.51-15-9-7 8049b-fa5cf release-keys"

BUILD_FINGERPRINT := motorola/corfur_g/corfur:12/S2RUBS32.51-15-9-7/8049b-fa5cf:user/release-keys
