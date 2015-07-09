From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Fri, 10 Jul 2015 01:16:43 +0800
Subject: [PATCH v3 6/7] ARM: imx: imx_v6_v7_defconfig enable imx6ul support
In-Reply-To: <1436462204-32654-1-git-send-email-Frank.Li@freescale.com>
References: <1436462204-32654-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1436462204-32654-7-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

default enable imx6ul support

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 4458554..dadb454 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -38,6 +38,7 @@ CONFIG_SOC_IMX53=y
 CONFIG_SOC_IMX6Q=y
 CONFIG_SOC_IMX6SL=y
 CONFIG_SOC_IMX6SX=y
+CONFIG_SOC_IMX6UL=y
 CONFIG_SOC_IMX7D=y
 CONFIG_SOC_VF610=y
 CONFIG_SOC_LS1021A=y
-- 
1.9.1
