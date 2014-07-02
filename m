From: stefan@agner.ch (Stefan Agner)
Date: Wed,  2 Jul 2014 21:13:19 +0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: add FSL_EDMA and PRINTK_TIME
Message-ID: <1404328399-17632-1-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EDMA for DMA support for Vybrid SoCs. Also add printk time.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 59b7e45..88ade54 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -242,6 +242,7 @@ CONFIG_RTC_DRV_SNVS=y
 CONFIG_DMADEVICES=y
 CONFIG_IMX_SDMA=y
 CONFIG_MXS_DMA=y
+CONFIG_FSL_EDMA=y
 CONFIG_STAGING=y
 CONFIG_DRM_IMX=y
 CONFIG_DRM_IMX_FB_HELPER=y
@@ -288,6 +289,7 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=y
+CONFIG_PRINTK_TIME=y
 CONFIG_DEBUG_FS=y
 CONFIG_MAGIC_SYSRQ=y
 # CONFIG_SCHED_DEBUG is not set
-- 
2.0.1
