From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 20:44:12 +0200
Subject: [PATCH 2/4] ARM: at91: rename at91sam9g20ek_defconfig to
	at91sam9g20_defconfig
In-Reply-To: <20111016181548.GH1459@game.jcrosoft.org>
References: <20111016181548.GH1459@game.jcrosoft.org>
Message-ID: <1318790654-20402-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable all at91sam9g20 board in it

keep the board specifc config for now on

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 ...91sam9g20ek_defconfig => at91sam9g20_defconfig} |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)
 rename arch/arm/configs/{at91sam9g20ek_defconfig => at91sam9g20_defconfig} (93%)

diff --git a/arch/arm/configs/at91sam9g20ek_defconfig b/arch/arm/configs/at91sam9g20_defconfig
similarity index 93%
rename from arch/arm/configs/at91sam9g20ek_defconfig
rename to arch/arm/configs/at91sam9g20_defconfig
index 9e90e6d..d5d6c97 100644
--- a/arch/arm/configs/at91sam9g20ek_defconfig
+++ b/arch/arm/configs/at91sam9g20_defconfig
@@ -14,6 +14,14 @@ CONFIG_ARCH_AT91=y
 CONFIG_ARCH_AT91SAM9G20=y
 CONFIG_MACH_AT91SAM9G20EK=y
 CONFIG_MACH_AT91SAM9G20EK_2MMC=y
+CONFIG_MACH_CPU9G20=y
+CONFIG_MACH_ACMENETUSFOXG20=y
+CONFIG_MACH_PORTUXG20=y
+CONFIG_MACH_STAMP9G20=y
+CONFIG_MACH_PCONTROL_G20=y
+CONFIG_MACH_GSIA18S=y
+CONFIG_MACH_USB_A9G20=y
+CONFIG_MACH_SNAPPER_9260=y
 CONFIG_AT91_PROGRAMMABLE_CLOCKS=y
 # CONFIG_ARM_THUMB is not set
 CONFIG_AEABI=y
@@ -23,7 +31,6 @@ CONFIG_ZBOOT_ROM_TEXT=0x0
 CONFIG_ZBOOT_ROM_BSS=0x0
 CONFIG_CMDLINE="mem=64M console=ttyS0,115200 initrd=0x21100000,3145728 root=/dev/ram0 rw"
 CONFIG_FPE_NWFPE=y
-CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
@@ -37,8 +44,6 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_CONCAT=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
@@ -48,14 +53,13 @@ CONFIG_MTD_NAND_ATMEL=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_ATMEL_SSC=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_MULTI_LUN=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+CONFIG_NET_ETHERNET=y
 CONFIG_MACB=y
 # CONFIG_NETDEV_1000 is not set
 # CONFIG_NETDEV_10000 is not set
@@ -66,15 +70,14 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
 CONFIG_KEYBOARD_GPIO=y
 # CONFIG_INPUT_MOUSE is not set
+CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_SERIAL_ATMEL=y
 CONFIG_SERIAL_ATMEL_CONSOLE=y
-CONFIG_LEGACY_PTY_COUNT=16
 CONFIG_HW_RANDOM=y
 CONFIG_SPI=y
 CONFIG_SPI_ATMEL=y
 CONFIG_SPI_SPIDEV=y
 # CONFIG_HWMON is not set
-# CONFIG_VGA_CONSOLE is not set
 CONFIG_SOUND=y
 CONFIG_SND=y
 CONFIG_SND_SEQUENCER=y
@@ -82,7 +85,6 @@ CONFIG_SND_MIXER_OSS=y
 CONFIG_SND_PCM_OSS=y
 CONFIG_SND_SEQUENCER_OSS=y
 # CONFIG_SND_VERBOSE_PROCFS is not set
-CONFIG_SND_AT73C213=y
 CONFIG_USB=y
 CONFIG_USB_DEVICEFS=y
 # CONFIG_USB_DEVICE_CLASS is not set
@@ -105,7 +107,6 @@ CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_EXT2_FS=y
-CONFIG_INOTIFY=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-- 
1.7.7
