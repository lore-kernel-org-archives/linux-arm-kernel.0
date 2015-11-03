From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 3 Nov 2015 14:25:37 -0200
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Select VF610_ADC
In-Reply-To: <1446567937-15025-1-git-send-email-fabio.estevam@freescale.com>
References: <1446567937-15025-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1446567937-15025-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The vf610 adc driver is present on Vybrid, MX6SX, MX6UL and MX7D.

Select it by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 4187f69..e528955 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -315,6 +315,8 @@ CONFIG_MXS_DMA=y
 CONFIG_FSL_EDMA=y
 CONFIG_STAGING=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_IIO=y
+CONFIG_VF610_ADC=y
 CONFIG_PWM=y
 CONFIG_PWM_IMX=y
 CONFIG_EXT2_FS=y
-- 
1.9.1
