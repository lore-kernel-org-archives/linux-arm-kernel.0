From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 28 Nov 2013 18:08:54 +0900
Subject: [PATCH 15/16] ARM: shmobile: bockw: enable HPB-DMAC in defconfig
In-Reply-To: <cover.1385629477.git.horms+renesas@verge.net.au>
References: <cover.1385629477.git.horms+renesas@verge.net.au>
Message-ID: <885484af398d11c21e4927dc33a2994927de6c5a.1385629477.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Enable HPB-DMAC driver in 'bockw_defconfig'.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/bockw_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/bockw_defconfig b/arch/arm/configs/bockw_defconfig
index 191decb..8110d8a 100644
--- a/arch/arm/configs/bockw_defconfig
+++ b/arch/arm/configs/bockw_defconfig
@@ -107,6 +107,8 @@ CONFIG_MMC_SDHI=y
 CONFIG_MMC_SH_MMCIF=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_RX8581=y
+CONFIG_DMADEVICES=y
+CONFIG_RCAR_HPB_DMAE=y
 CONFIG_UIO=y
 CONFIG_UIO_PDRV_GENIRQ=y
 # CONFIG_IOMMU_SUPPORT is not set
-- 
1.8.4
