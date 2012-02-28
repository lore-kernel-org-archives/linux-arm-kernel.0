From: zhaoy@marvell.com (zhaoy)
Date: Tue, 28 Feb 2012 15:27:43 +0800
Subject: [PATCH 11/13] DMA:update defconfig for mmp3
In-Reply-To: <Y>
References: <Y>
Message-ID: <1330414065-2949-12-git-send-email-zhaoy@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1.open DMAC and TDMA config in defconfig

Change-Id: I78876368e43472fe6e86314c438b98e518cfcb87
Signed-off-by: zhaoy <zhaoy@marvell.com>
---
 arch/arm/configs/mmp3_defconfig |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/mmp3_defconfig b/arch/arm/configs/mmp3_defconfig
index 4f8b160..3a363f4 100644
--- a/arch/arm/configs/mmp3_defconfig
+++ b/arch/arm/configs/mmp3_defconfig
@@ -2038,7 +2038,24 @@ CONFIG_RTC_INTF_ALARM_DEV=y
 # on-CPU RTC drivers
 #
 CONFIG_RTC_DRV_MMP=y
-# CONFIG_DMADEVICES is not set
+CONFIG_DMADEVICES=y
+# CONFIG_DMADEVICES_DEBUG is not set
+
+#
+# DMA Devices
+#
+# CONFIG_DW_DMAC is not set
+# CONFIG_TIMB_DMA is not set
+CONFIG_PXA_DMAC=y
+CONFIG_MMP_TDMA=y
+CONFIG_DMA_ENGINE=y
+
+#
+# DMA Clients
+#
+# CONFIG_NET_DMA is not set
+# CONFIG_ASYNC_TX_DMA is not set
+# CONFIG_DMATEST is not set
 # CONFIG_AUXDISPLAY is not set
 CONFIG_UIO=y
 # CONFIG_UIO_PDRV is not set
-- 
1.7.0.4
