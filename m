From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 17 Jun 2017 18:02:54 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_IMX7D_ADC
Message-ID: <1497733374-14977-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Select CONFIG_IMX7D_ADC so that the i.MX7 ADC driver can be
built by default.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 2dbbc52..e74de69 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -345,6 +345,7 @@ CONFIG_IMX_SDMA=y
 CONFIG_MXS_DMA=y
 CONFIG_STAGING=y
 CONFIG_IIO=y
+CONFIG_IMX7D_ADC=y
 CONFIG_VF610_ADC=y
 CONFIG_MPL3115=y
 CONFIG_PWM=y
-- 
2.7.4
