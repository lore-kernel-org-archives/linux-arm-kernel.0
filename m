From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 6 Aug 2012 13:59:06 -0300
Subject: [PATCH] ARM: mxs_defconfig: Add LED, PWM and MTD_CHAR support
Message-ID: <1344272346-22797-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add LED, PWM and MTD_CHAR support.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/mxs_defconfig |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index e3487e4..4cb6170 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -60,6 +60,7 @@ CONFIG_DEVTMPFS=y
 # CONFIG_FIRMWARE_IN_KERNEL is not set
 # CONFIG_BLK_DEV is not set
 CONFIG_MTD=y
+CONFIG_MTD_CHAR=y
 CONFIG_MTD_NAND=y
 CONFIG_MTD_NAND_GPMI_NAND=y
 CONFIG_NETDEVICES=y
@@ -118,12 +119,23 @@ CONFIG_SCSI=y
 CONFIG_BLK_DEV_SD=y
 CONFIG_MMC=y
 CONFIG_MMC_MXS=y
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
+CONFIG_LEDS_GPIO=y
+CONFIG_LEDS_TRIGGERS=y
+CONFIG_LEDS_TRIGGER_TIMER=y
+CONFIG_LEDS_TRIGGER_ONESHOT=y
+CONFIG_LEDS_TRIGGER_HEARTBEAT=y
+CONFIG_LEDS_TRIGGER_BACKLIGHT=y
+CONFIG_LEDS_TRIGGER_GPIO=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=m
 CONFIG_RTC_DRV_STMP=y
 CONFIG_DMADEVICES=y
 CONFIG_MXS_DMA=y
 CONFIG_COMMON_CLK_DEBUG=y
+CONFIG_PWM=y
+CONFIG_PWM_MXS=y
 CONFIG_EXT3_FS=y
 # CONFIG_DNOTIFY is not set
 CONFIG_FSCACHE=m
-- 
1.7.1
