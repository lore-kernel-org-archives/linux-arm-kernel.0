From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 29 Oct 2015 12:34:55 -0200
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Remove CONFIG_SOC_LS1021A
Message-ID: <1446129295-11775-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

imx_v6_v7_defconfig is not suitable for booting LS1021 as it needs
LPAE.

Remove this option.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 4187f69..d83e775 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -42,7 +42,6 @@ CONFIG_SOC_IMX6SL=y
 CONFIG_SOC_IMX6SX=y
 CONFIG_SOC_IMX6UL=y
 CONFIG_SOC_IMX7D=y
-CONFIG_SOC_LS1021A=y
 CONFIG_SOC_VF610=y
 CONFIG_PCI=y
 CONFIG_PCI_IMX6=y
-- 
1.9.1
