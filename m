From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 15 Jun 2013 19:14:33 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable Vybrid VF610
Message-ID: <1371334473-24885-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Let VF610 SoC support be built by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index ac3470c..6c18e4d 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -38,6 +38,7 @@ CONFIG_MACH_EUKREA_CPUIMX51SD=y
 CONFIG_SOC_IMX53=y
 CONFIG_SOC_IMX6Q=y
 CONFIG_SOC_IMX6SL=y
+CONFIG_SOC_VF610=y
 CONFIG_MXC_PWM=y
 CONFIG_SMP=y
 CONFIG_VMSPLIT_2G=y
-- 
1.8.1.2
