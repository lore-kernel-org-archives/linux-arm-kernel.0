From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 7 May 2015 14:31:18 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select LS1021A
Message-ID: <1431019878-32311-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable CONFIG_SOC_LS1021A by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index fdeb1c8..6204a04 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -39,6 +39,7 @@ CONFIG_SOC_IMX6Q=y
 CONFIG_SOC_IMX6SL=y
 CONFIG_SOC_IMX6SX=y
 CONFIG_SOC_VF610=y
+CONFIG_SOC_LS1021A=y
 CONFIG_PCI=y
 CONFIG_PCI_IMX6=y
 CONFIG_SMP=y
-- 
1.9.1
