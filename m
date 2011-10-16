From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 20:44:13 +0200
Subject: [PATCH 3/4] ARM: at91: rename at91cap9adk_defconfig to
	at91cap9_defconfig
In-Reply-To: <20111016181548.GH1459@game.jcrosoft.org>
References: <20111016181548.GH1459@game.jcrosoft.org>
Message-ID: <1318790654-20402-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 .../{at91cap9adk_defconfig => at91cap9_defconfig}  |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)
 rename arch/arm/configs/{at91cap9adk_defconfig => at91cap9_defconfig} (95%)

diff --git a/arch/arm/configs/at91cap9adk_defconfig b/arch/arm/configs/at91cap9_defconfig
similarity index 95%
rename from arch/arm/configs/at91cap9adk_defconfig
rename to arch/arm/configs/at91cap9_defconfig
index ffb1edd..d8c3793 100644
--- a/arch/arm/configs/at91cap9adk_defconfig
+++ b/arch/arm/configs/at91cap9_defconfig
@@ -38,7 +38,6 @@ CONFIG_IP_PNP_RARP=y
 # CONFIG_IPV6 is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
@@ -52,12 +51,10 @@ CONFIG_MTD_NAND_ATMEL=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_SIZE=8192
-CONFIG_ATMEL_SSC=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_MULTI_LUN=y
 CONFIG_NETDEVICES=y
-CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
 CONFIG_MACB=y
 # CONFIG_NETDEV_1000 is not set
@@ -81,7 +78,6 @@ CONFIG_WATCHDOG=y
 CONFIG_WATCHDOG_NOWAYOUT=y
 CONFIG_FB=y
 CONFIG_FB_ATMEL=y
-# CONFIG_VGA_CONSOLE is not set
 CONFIG_LOGO=y
 # CONFIG_LOGO_LINUX_MONO is not set
 # CONFIG_LOGO_LINUX_CLUT224 is not set
@@ -99,7 +95,6 @@ CONFIG_MMC_AT91=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_EXT2_FS=y
-CONFIG_INOTIFY=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
 CONFIG_JFFS2_FS=y
-- 
1.7.7
