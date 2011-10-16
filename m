From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 20:44:11 +0200
Subject: [PATCH 1/4] ARM: at91: rename at91sam9260ek_defconfig to
	at91sam9260_defconfig
In-Reply-To: <20111016181548.GH1459@game.jcrosoft.org>
References: <20111016181548.GH1459@game.jcrosoft.org>
Message-ID: <1318790654-20402-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable all at91sam9260 board in it

keep the board specifc config for now on

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 ...91sam9260ek_defconfig => at91sam9260_defconfig} |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)
 rename arch/arm/configs/{at91sam9260ek_defconfig => at91sam9260_defconfig} (89%)

diff --git a/arch/arm/configs/at91sam9260ek_defconfig b/arch/arm/configs/at91sam9260_defconfig
similarity index 89%
rename from arch/arm/configs/at91sam9260ek_defconfig
rename to arch/arm/configs/at91sam9260_defconfig
index f8a9226..fb7fca7 100644
--- a/arch/arm/configs/at91sam9260ek_defconfig
+++ b/arch/arm/configs/at91sam9260_defconfig
@@ -12,7 +12,16 @@ CONFIG_MODULE_UNLOAD=y
 # CONFIG_IOSCHED_CFQ is not set
 CONFIG_ARCH_AT91=y
 CONFIG_ARCH_AT91SAM9260=y
+CONFIG_ARCH_AT91SAM9260_SAM9XE=y
 CONFIG_MACH_AT91SAM9260EK=y
+CONFIG_MACH_CAM60=y
+CONFIG_MACH_SAM9_L9260=y
+CONFIG_MACH_AFEB9260=y
+CONFIG_MACH_USB_A9260=y
+CONFIG_MACH_QIL_A9260=y
+CONFIG_MACH_CPU9260=y
+CONFIG_MACH_FLEXIBITY=y
+CONFIG_MACH_SNAPPER_9260=y
 CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_ZBOOT_ROM_TEXT=0x0
@@ -33,13 +42,12 @@ CONFIG_IP_PNP_BOOTP=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_ATMEL_SSC=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_MULTI_LUN=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+CONFIG_NET_ETHERNET=y
 CONFIG_MACB=y
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_KEYBOARD is not set
@@ -55,7 +63,6 @@ CONFIG_I2C_GPIO=y
 CONFIG_WATCHDOG=y
 CONFIG_WATCHDOG_NOWAYOUT=y
 CONFIG_AT91SAM9X_WATCHDOG=y
-# CONFIG_VGA_CONSOLE is not set
 # CONFIG_USB_HID is not set
 CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
@@ -71,7 +78,6 @@ CONFIG_USB_G_SERIAL=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_EXT2_FS=y
-CONFIG_INOTIFY=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_CRAMFS=y
-- 
1.7.7
