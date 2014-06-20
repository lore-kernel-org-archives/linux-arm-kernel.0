From: b20788@freescale.com (Anson Huang)
Date: Fri, 20 Jun 2014 13:12:44 +0800
Subject: [PATCH 1/3] ARM: imx: defconfig: select SOC_IMX6SX by default
Message-ID: <1403241164-31417-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable i.MX6SX SOC support.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index a6f182e..e9f481e 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -37,6 +37,7 @@ CONFIG_SOC_IMX50=y
 CONFIG_SOC_IMX53=y
 CONFIG_SOC_IMX6Q=y
 CONFIG_SOC_IMX6SL=y
+CONFIG_SOC_IMX6SX=y
 CONFIG_SOC_VF610=y
 CONFIG_PCI=y
 CONFIG_PCI_IMX6=y
-- 
1.7.9.5
