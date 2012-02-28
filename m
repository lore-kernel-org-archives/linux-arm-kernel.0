From: zhaoy@marvell.com (Zhao Ye)
Date: Mon, 27 Feb 2012 23:42:34 -0800
Subject: [PATCH 13/13] DMA:update defconfig for mmp2
In-Reply-To: <1330414065-2949-14-git-send-email-zhaoy@marvell.com>
References: <Y> <1330414065-2949-14-git-send-email-zhaoy@marvell.com>
Message-ID: <A63A0DC671D719488CD1A6CD8BDC16CF1A0E95FF51@SC-VEXCH4.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry! Please ignore these patches. I will send a new version.

Best Regard
Zhao Ye
+61942433
Marvell Tech (SH) Co. Ltd.

-----Original Message-----
From: zhaoy [mailto:zhaoy at marvell.com] 
Sent: 2012?2?28? 15:28
To: linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; nicolas.pitre at linaro.org; linux at arm.linux.org.uk; Haojian Zhuang; Chao Xie; Leo Yan
Cc: Zhao Ye
Subject: [PATCH 13/13] DMA:update defconfig for mmp2

	1.open DMAC and TDMA config in mmp2 defconfig

Change-Id: Ie253d527e481f376edf4cc5e56fbad7a7da4fefa
Signed-off-by: zhaoy <zhaoy@marvell.com>
---
 arch/arm/configs/mmp2_defconfig |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/mmp2_defconfig b/arch/arm/configs/mmp2_defconfig
index 138c95a..b975779 100644
--- a/arch/arm/configs/mmp2_defconfig
+++ b/arch/arm/configs/mmp2_defconfig
@@ -1919,8 +1919,25 @@ CONFIG_RTC_DRV_MAX8925=y
 #
 # on-CPU RTC drivers
 #
-CONFIG_RTC_DRV_MMP=y
-# CONFIG_DMADEVICES is not set
+# CONFIG_RTC_DRV_MMP is not set
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
