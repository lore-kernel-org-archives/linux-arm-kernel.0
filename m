From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Fri, 11 Dec 2015 07:12:11 +0800
Subject: [PATCH 2/3] ARM: imx: select HAVE_ARM_ARCH_TIMER if selected i.MX7D
In-Reply-To: <1449789132-18976-1-git-send-email-Frank.Li@freescale.com>
References: <1449789132-18976-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1449789132-18976-2-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

i.MX7D Supported ARCH Timer.

Signed-off-by: Frank Li <Frank.Li@freescale.com>
---
 arch/arm/mach-imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 0ac180f..061dea4 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -563,6 +563,7 @@ config SOC_IMX7D
 	select ARM_GIC
 	select HAVE_IMX_ANATOP
 	select HAVE_IMX_MMDC
+	select HAVE_ARM_ARCH_TIMER
 	help
 		This enables support for Freescale i.MX7 Dual processor.
 
-- 
2.5.2
