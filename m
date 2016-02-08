From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon,  8 Feb 2016 14:53:01 -0300
Subject: [PATCH 1/3] ARM: omap2plus_defconfig: Enable OMAP IOMMU support
In-Reply-To: <1454953983-8894-1-git-send-email-javier@osg.samsung.com>
References: <1454953983-8894-1-git-send-email-javier@osg.samsung.com>
Message-ID: <1454953983-8894-2-git-send-email-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP3 media platform drivers (i.e: omap3isp) needs IOMMU support so
enable it to be able to test the OMAP3 Image Signal Processor (ISP).

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 arch/arm/configs/omap2plus_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index a7151744b85c..c53d21c30b20 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -412,7 +412,8 @@ CONFIG_RTC_DRV_OMAP=m
 CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
 CONFIG_DMA_OMAP=y
-# CONFIG_IOMMU_SUPPORT is not set
+CONFIG_IOMMU_SUPPORT=y
+CONFIG_OMAP_IOMMU=y
 CONFIG_EXTCON=m
 CONFIG_EXTCON_USB_GPIO=m
 CONFIG_EXTCON_PALMAS=m
-- 
2.5.0
