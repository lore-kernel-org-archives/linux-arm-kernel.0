From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 29 Oct 2015 12:37:05 -0200
Subject: [PATCH] ARM: multi_v7_defconfig: Remove CONFIG_SOC_LS1021A
Message-ID: <1446129425-11899-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx_v6_v7_defconfig is not suitable for booting LS1021 as it needs
LPAE.

Remove this option.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index cb0f35d..ed0f631 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -53,7 +53,6 @@ CONFIG_SOC_IMX6SX=y
 CONFIG_SOC_IMX6UL=y
 CONFIG_SOC_IMX7D=y
 CONFIG_SOC_VF610=y
-CONFIG_SOC_LS1021A=y
 CONFIG_ARCH_OMAP3=y
 CONFIG_ARCH_OMAP4=y
 CONFIG_SOC_OMAP5=y
-- 
1.9.1
