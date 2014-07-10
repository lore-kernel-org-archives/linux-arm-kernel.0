From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 10 Jul 2014 11:56:08 -0700
Subject: [PATCH] ARM: multi_v7_defconfig: Enable Zynq GPIO driver
Message-ID: <1405018568-23835-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
The driver is staged in Linus' GPIO tree.

	S?ren

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 534836497998..a439b87d87e6 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -210,6 +210,7 @@ CONFIG_PINCTRL_PALMAS=y
 CONFIG_GPIO_SYSFS=y
 CONFIG_GPIO_GENERIC_PLATFORM=y
 CONFIG_GPIO_DWAPB=y
+CONFIG_GPIO_ZYNQ=y
 CONFIG_GPIO_PCA953X=y
 CONFIG_GPIO_PCA953X_IRQ=y
 CONFIG_GPIO_TWL4030=y
-- 
2.0.1.1.gfbfc394
