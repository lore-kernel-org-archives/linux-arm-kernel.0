From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 11 Mar 2018 14:53:04 +0100
Subject: [PATCH 07/10] ARM: defconfig: Update RealView defconfig
In-Reply-To: <20180311135307.6271-1-linus.walleij@linaro.org>
References: <20180311135307.6271-1-linus.walleij@linaro.org>
Message-ID: <20180311135307.6271-8-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Just update with some new results from savedefconfig so we are
in sync with what has happened in Kconfig upstream.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/realview_defconfig | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/arm/configs/realview_defconfig b/arch/arm/configs/realview_defconfig
index 2a6d69d896bd..95bd20b2a4d2 100644
--- a/arch/arm/configs/realview_defconfig
+++ b/arch/arm/configs/realview_defconfig
@@ -11,19 +11,16 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_MULTI_V6=y
 CONFIG_ARCH_REALVIEW=y
-CONFIG_REALVIEW_DT=y
 CONFIG_MACH_REALVIEW_EB=y
 CONFIG_REALVIEW_EB_ARM1136=y
 CONFIG_REALVIEW_EB_ARM1176=y
 CONFIG_REALVIEW_EB_A9MP=y
 CONFIG_REALVIEW_EB_ARM11MP=y
-CONFIG_REALVIEW_EB_ARM11MP_REVB=y
 CONFIG_MACH_REALVIEW_PB11MP=y
 CONFIG_MACH_REALVIEW_PB1176=y
 CONFIG_MACH_REALVIEW_PBA8=y
 CONFIG_MACH_REALVIEW_PBX=y
 CONFIG_SMP=y
-CONFIG_AEABI=y
 CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="root=/dev/nfs nfsroot=10.1.69.3:/work/nfsroot ip=dhcp console=ttyAMA0 mem=128M"
@@ -46,7 +43,7 @@ CONFIG_MTD_CFI_INTELEXT=y
 CONFIG_MTD_CFI_AMDSTD=y
 CONFIG_MTD_ROM=y
 CONFIG_MTD_PHYSMAP=y
-CONFIG_ARM_CHARLCD=y
+CONFIG_MTD_PHYSMAP_OF=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_NETDEVICES=y
@@ -59,7 +56,6 @@ CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_AMBA_PL011=y
 CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_I2C=y
 CONFIG_I2C_VERSATILE=y
 CONFIG_SPI=y
 CONFIG_GPIOLIB=y
@@ -72,8 +68,6 @@ CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_VGA16 is not set
 CONFIG_SOUND=y
 CONFIG_SND=y
-CONFIG_SND_MIXER_OSS=y
-CONFIG_SND_PCM_OSS=y
 # CONFIG_SND_DRIVERS is not set
 CONFIG_SND_ARMAACI=y
 CONFIG_USB=y
@@ -83,13 +77,14 @@ CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
-CONFIG_LEDS_VERSATILE=y
 CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_CPU=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_PL031=y
+CONFIG_AUXDISPLAY=y
+CONFIG_ARM_CHARLCD=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_CRAMFS=y
-- 
2.14.3
