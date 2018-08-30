From: embed3d@gmail.com (Philipp Rossak)
Date: Thu, 30 Aug 2018 17:45:01 +0200
Subject: [PATCH v3 13/30] arm: config: Enable SUN4I_GPADC in defconfig
In-Reply-To: <20180830154518.29507-1-embed3d@gmail.com>
References: <20180830154518.29507-1-embed3d@gmail.com>
Message-ID: <20180830154518.29507-14-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since we have now new compatibles we can enable the SUN4I_GPADC driver
next to the sun4i-ts driver.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/configs/sunxi_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index df433abfcb02..2189349820ac 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -132,6 +132,7 @@ CONFIG_DMA_SUN6I=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXTCON=y
 CONFIG_IIO=y
+CONFIG_SUN4I_GPADC=y
 CONFIG_AXP20X_ADC=y
 CONFIG_PWM=y
 CONFIG_PWM_SUN4I=y
-- 
2.11.0
