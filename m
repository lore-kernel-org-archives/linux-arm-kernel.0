From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun, 16 Oct 2011 20:44:14 +0200
Subject: [PATCH 4/4] ARM: at91: rename at91sam9rlek_defconfig to
	at91sam9rl_defconfig
In-Reply-To: <20111016181548.GH1459@game.jcrosoft.org>
References: <20111016181548.GH1459@game.jcrosoft.org>
Message-ID: <1318790654-20402-4-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 ...at91sam9rlek_defconfig => at91sam9rl_defconfig} |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)
 rename arch/arm/configs/{at91sam9rlek_defconfig => at91sam9rl_defconfig} (94%)

diff --git a/arch/arm/configs/at91sam9rlek_defconfig b/arch/arm/configs/at91sam9rl_defconfig
similarity index 94%
rename from arch/arm/configs/at91sam9rlek_defconfig
rename to arch/arm/configs/at91sam9rl_defconfig
index 75621e4..ad562ee 100644
--- a/arch/arm/configs/at91sam9rlek_defconfig
+++ b/arch/arm/configs/at91sam9rl_defconfig
@@ -23,8 +23,6 @@ CONFIG_NET=y
 CONFIG_UNIX=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_MTD=y
-CONFIG_MTD_CONCAT=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CMDLINE_PARTS=y
 CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
@@ -35,7 +33,6 @@ CONFIG_BLK_DEV_LOOP=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=4
 CONFIG_BLK_DEV_RAM_SIZE=24576
-CONFIG_ATMEL_SSC=y
 CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_SCSI_MULTI_LUN=y
@@ -62,13 +59,11 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 CONFIG_AT91SAM9X_WATCHDOG=y
 CONFIG_FB=y
 CONFIG_FB_ATMEL=y
-# CONFIG_VGA_CONSOLE is not set
 CONFIG_MMC=y
 CONFIG_MMC_AT91=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_AT91SAM9=y
 CONFIG_EXT2_FS=y
-CONFIG_INOTIFY=y
 CONFIG_MSDOS_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
-- 
1.7.7
