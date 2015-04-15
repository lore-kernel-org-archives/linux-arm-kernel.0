From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Thu, 16 Apr 2015 06:30:16 +0800
Subject: [PATCH 7/7] ARM: config: imx_v6_v7_defconfig add imx7d support
In-Reply-To: <1429137016-21816-1-git-send-email-Frank.Li@freescale.com>
References: <1429137016-21816-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1429137016-21816-8-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

Add imx7d support

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index fdeb1c8..c9c51e1f 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -38,6 +38,7 @@ CONFIG_SOC_IMX53=y
 CONFIG_SOC_IMX6Q=y
 CONFIG_SOC_IMX6SL=y
 CONFIG_SOC_IMX6SX=y
+CONFIG_SOC_IMX7D=y
 CONFIG_SOC_VF610=y
 CONFIG_PCI=y
 CONFIG_PCI_IMX6=y
-- 
1.9.1
