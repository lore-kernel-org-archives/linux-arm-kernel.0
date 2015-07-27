From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 27 Jul 2015 11:10:44 -0300
Subject: [PATCH] ARM: multi_v7_defconfig: Select MX6UL and MX7D
Message-ID: <1438006244-10191-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Let MX6UL and MX7D SoCs be selected by default.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index c7fd51a..a12d80c 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -49,6 +49,8 @@ CONFIG_SOC_IMX53=y
 CONFIG_SOC_IMX6Q=y
 CONFIG_SOC_IMX6SL=y
 CONFIG_SOC_IMX6SX=y
+CONFIG_SOC_IMX6UL=y
+CONFIG_SOC_IMX7D=y
 CONFIG_SOC_VF610=y
 CONFIG_SOC_LS1021A=y
 CONFIG_ARCH_OMAP3=y
-- 
1.9.1
