From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 29 Apr 2014 14:20:10 +0800
Subject: [PATCH] ARM: imx_v4_v5_defconfig: drop CONFIG_COMMON_CLK_DEBUG option
Message-ID: <1398752410-20308-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The option COMMON_CLK_DEBUG was removed by commit ea72dc2 (clk: remove
CONFIG_COMMON_CLK_DEBUG), so let's remove CONFIG_COMMON_CLK_DEBUG from
the defconfig.

Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
---
Thanks to Lad Prabhakar <prabhakar.csengg@gmail.com> for the reminding.

 arch/arm/configs/imx_v4_v5_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 54bc649..bada59d 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -182,7 +182,6 @@ CONFIG_RTC_DRV_MXC=y
 CONFIG_DMADEVICES=y
 CONFIG_IMX_SDMA=y
 CONFIG_IMX_DMA=y
-CONFIG_COMMON_CLK_DEBUG=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-- 
1.8.3.2
