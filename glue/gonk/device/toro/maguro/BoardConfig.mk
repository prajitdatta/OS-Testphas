#
# config.mk
#
# Product-specific compile-time definitions.
#

ifeq ($(QC_PROP),true)
    BOARD_USES_QCOM_HARDWARE := true
    BOARD_USES_ADRENO_200 := true
    HAVE_ADRENO200_SOURCE := true
    HAVE_ADRENO200_SC_SOURCE := true
    HAVE_ADRENO200_FIRMWARE := true
    BOARD_USES_QCNE := true
    #  [WIFI] If enable Wi-Fi Support. Set "BOARD_HAVE_WIFI := true"
    BOARD_HAVE_WIFI := true
    ifneq ($(BUILD_TINY_ANDROID), true)
    BOARD_VENDOR_QCOM_GPS_LOC_API_AMSS_VERSION := 50001
    BOARD_VENDOR_QCOM_GPS_LOC_API_HARDWARE := default
    BOARD_CAMERA_LIBRARIES := libcamera
    BOARD_HAVE_BLUETOOTH := true
    BOARD_HAVE_QCOM_FM := true
    BOARD_HAS_QCOM_WLAN := false
    #BOARD_USES_GENERIC_AUDIO := true
    ifeq ($(BOARD_HAS_QCOM_WLAN),true)
	BOARD_WPA_SUPPLICANT_DRIVER := WEXT
	WPA_SUPPLICANT_VERSION := VER_0_6_X
	WIFI_SDIO_IF_DRIVER_MODULE_PATH := "/system/lib/modules/librasdioif.ko"
	WIFI_SDIO_IF_DRIVER_MODULE_NAME := "librasdioif"
	WIFI_SDIO_IF_DRIVER_MODULE_ARG  := ""
    endif
    endif   # !BUILD_TINY_ANDROID

else
#    BOARD_USES_GENERIC_AUDIO := true
    USE_CAMERA_STUB := false
    BOARD_HAVE_BLUETOOTH := true

endif # QC_PROP

TARGET_HAVE_TSLIB := true

TARGET_NO_BOOTLOADER := false
TARGET_NO_KERNEL := false
TARGET_NO_RADIOIMAGE := true
# Try to use ASHMEM if possible (when non-MDP composition is used)
TARGET_GRALLOC_USES_ASHMEM := true
TARGET_PROVIDES_INIT_RC := true
TARGET_PROVIDES_UEVENTD_RC := true
TARGET_PROVIDES_RILD := true

TARGET_CPU_ABI  := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_BOARD_PLATFORM := msm7k
TARGET_BOOTLOADER_BOARD_NAME := MSM7627A_SKU1
TARGET_AVOID_DRAW_TEXTURE_EXTENSION := true
TARGET_USES_16BPPSURFACE_FOR_OPAQUE := true
QCOM_TARGET_PRODUCT := msm7627a_sku1

# Enable temporary stub methods that permit the newer libcamera.so blob
# to link with the older source
TARGET_LIBCAMERA_BLOB_SYM_MISMATCH := true

# Enable newer vtable layout for audio interfaces.
TARGET_AUDIO_INTERFACE_NEWER_VTABLE := true
COMMON_GLOBAL_CFLAGS += -DENABLE_NEWER_AUDIO_INTERFACE_VTABLE

COMMON_GLOBAL_CFLAGS += -DENABLE_GRALLOC_NUMFB

TARGET_CORTEX_CACHE_LINE_32 := true
BOARD_KERNEL_BASE    := 0x00200000
BOARD_KERNEL_PAGESIZE := 4096
#Spare size is (BOARD_KERNEL_PAGESIZE>>9)*16
BOARD_KERNEL_SPARESIZE := 128
#Spare size for 8 bit BCH ECC NAND
BOARD_HAS_8BIT_BCHECC_SUPPORT := true
BOARD_KERNEL_BCHECC_SPARESIZE := 160

TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USES_UNCOMPRESSED_KERNEL := true

BOARD_KERNEL_CMDLINE := console=ttyMSM0,115200,n8 androidboot.hardware=qcom
BOARD_KERNEL_CMDLINE += mem=256M
# The default touch event polling time of 30ms currently causes the FPS while
# panning to be artificially limited.  Increasing polling to 15ms gives +60 FPS.
BOARD_KERNEL_CMDLINE += rmi_sensor.polltime=15000000
ARCH_ARM_HAVE_TLS_REGISTER := true
BOARD_EGL_CFG := vendor/toro/common/proprietary/egl/egl.cfg

BOARD_NO_SPEAKER := true # msm7627a doesn't have speaker
BOARD_NO_TOUCHSCREEN := false

BOARD_HAVE_CDROM :=true
#ADD_RADIO_FILES :=true
BOARD_USES_EMMC_APPSBOOT :=true
BOARD_BOOTIMAGE_PARTITION_SIZE := 0x00D42000
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 0x00D42000
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 184041472
BOARD_USERDATAIMAGE_PARTITION_SIZE := 1472593920
BOARD_CACHEIMAGE_PARTITION_SIZE := 104857600
BOARD_PERSISTIMAGE_PARTITION_SIZE := 10485760
BOARD_FLASH_BLOCK_SIZE := 131072 # (BOARD_KERNEL_PAGESIZE * 64)
#Atheros ++++
#BOARD_USES_ATH_WIFI ?= true
BOARD_USES_AR6002 := false
BOARD_USES_AR6003 := true
ifeq ($(BOARD_USES_ATH_WIFI),true)
   WPA_SUPPLICANT_VERSION := VER_0_8_ATHEROS
   BOARD_WPA_SUPPLICANT_DRIVER := WEXT
   HOSTAPD_VERSION := VER_0_8_ATHEROS
   BOARD_HAS_ATH_WLAN := true
   ifeq ($(BOARD_USES_AR6002),true)
	BOARD_WLAN_ATHEROS_SDK := external/ar6002/olca
   endif
   ifeq ($(BOARD_USES_AR6003),true)
	BOARD_WLAN_ATHEROS_SDK := system/wlan/atheros/AR6kSDK.build_3.1_RC.560
   endif
endif
# Atheros ---

#TARGET_RECOVERY_UPDATER_LIBS += librecovery_updater_qcom

# Maguro blobs expect the following property values. Sneak them into
# /build.prop so that the defaults added to /system/build.prop by the
# build system are ignored (easier than messing around with the core
# build system at the moment.)
#
# TODO: This should eventually be fixed properly by renaming device/
#       directories...
#
ADDITIONAL_DEFAULT_PROPERTIES :=  \
   ro.product.model=msm7627a_sku1 \
   ro.product.brand=qcom \
   ro.product.name=msm7627a_sku1 \
   ro.product.device=msm7627a_sku1 \
   ro.product.board=msm7627a_sku1 \
   ro.build.product=msm7627a_sku1 \
