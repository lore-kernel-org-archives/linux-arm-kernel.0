From: joelf@ti.com (Joel Fernandes)
Date: Wed, 26 Jun 2013 22:42:03 -0500
Subject: [PATCH v2 1/2] ARM: configs: Enable TI_EDMA in omap2plus_defconfig
Message-ID: <1372304523-30742-1-git-send-email-joelf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Build EDMA in by default to avoid fewer people stepping on their toes
with broken DMA on drivers needing EDMA.

Signed-off-by: Joel Fernandes <joelf@ti.com>
---
 arch/arm/configs/omap2plus_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index abbe319..7e00deb 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -236,6 +236,7 @@ CONFIG_RTC_DRV_TWL92330=y
 CONFIG_RTC_DRV_TWL4030=y
 CONFIG_RTC_DRV_OMAP=y
 CONFIG_DMADEVICES=y
+CONFIG_TI_EDMA=y
 CONFIG_DMA_OMAP=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
-- 
1.7.9.5
