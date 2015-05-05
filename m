From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 5 May 2015 14:35:49 -0300
Subject: [PATCH] ARM: multi_v7_defconfig: Select more FSL SoCs
Message-ID: <1430847349-28413-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select IMX50, IMX6SX and LS1021A SoC support.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 22df002..2ba0b39 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -39,11 +39,14 @@ CONFIG_ARCH_HIP04=y
 CONFIG_ARCH_KEYSTONE=y
 CONFIG_ARCH_MESON=y
 CONFIG_ARCH_MXC=y
+CONFIG_SOC_IMX50=y
 CONFIG_SOC_IMX51=y
 CONFIG_SOC_IMX53=y
 CONFIG_SOC_IMX6Q=y
 CONFIG_SOC_IMX6SL=y
+CONFIG_SOC_IMX6SX=y
 CONFIG_SOC_VF610=y
+CONFIG_SOC_LS1021A=y
 CONFIG_ARCH_OMAP3=y
 CONFIG_ARCH_OMAP4=y
 CONFIG_SOC_OMAP5=y
-- 
1.9.1
