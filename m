From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 27 May 2017 10:17:52 -0300
Subject: [PATCH] ARM: dts: imx7: Fix typo in watchdog pin name
Message-ID: <1495891072-31103-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Change "WDOD1" to "WDOG1" in watchdog pin names.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx7d-nitrogen7.dts | 2 +-
 arch/arm/boot/dts/imx7d-pico.dts      | 2 +-
 arch/arm/boot/dts/imx7d-pinfunc.h     | 6 +++---
 arch/arm/boot/dts/imx7d-sdb.dts       | 2 +-
 arch/arm/boot/dts/imx7s-warp.dts      | 2 +-
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-nitrogen7.dts b/arch/arm/boot/dts/imx7d-nitrogen7.dts
index dd40e49..e799830 100644
--- a/arch/arm/boot/dts/imx7d-nitrogen7.dts
+++ b/arch/arm/boot/dts/imx7d-nitrogen7.dts
@@ -738,7 +738,7 @@
 
 	pinctrl_wdog1: wdog1grp {
 		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO00__WDOD1_WDOG_B	0x75
+			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B	0x75
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx7d-pico.dts b/arch/arm/boot/dts/imx7d-pico.dts
index 79b5d83..e78c2c9 100644
--- a/arch/arm/boot/dts/imx7d-pico.dts
+++ b/arch/arm/boot/dts/imx7d-pico.dts
@@ -397,7 +397,7 @@
 &iomuxc_lpsr {
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO00__WDOD1_WDOG_B	0x74
+			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B	0x74
 		>;
 	};
 };
diff --git a/arch/arm/boot/dts/imx7d-pinfunc.h b/arch/arm/boot/dts/imx7d-pinfunc.h
index f6f7e78..f2493bc 100644
--- a/arch/arm/boot/dts/imx7d-pinfunc.h
+++ b/arch/arm/boot/dts/imx7d-pinfunc.h
@@ -17,9 +17,9 @@
 
 #define MX7D_PAD_LPSR_GPIO1_IO00__GPIO1_IO0                       0x0000 0x0030 0x0000 0x0 0x0
 #define MX7D_PAD_LPSR_GPIO1_IO00__PWM4_OUT                        0x0000 0x0030 0x0000 0x1 0x0
-#define MX7D_PAD_LPSR_GPIO1_IO00__WDOD1_WDOG_ANY                  0x0000 0x0030 0x0000 0x2 0x0
-#define MX7D_PAD_LPSR_GPIO1_IO00__WDOD1_WDOG_B                    0x0000 0x0030 0x0000 0x3 0x0
-#define MX7D_PAD_LPSR_GPIO1_IO00__WDOD1_WDOG__RST_B_DEB           0x0000 0x0030 0x0000 0x4 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_ANY                  0x0000 0x0030 0x0000 0x2 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B                    0x0000 0x0030 0x0000 0x3 0x0
+#define MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG__RST_B_DEB           0x0000 0x0030 0x0000 0x4 0x0
 #define MX7D_PAD_LPSR_GPIO1_IO01__GPIO1_IO1                       0x0004 0x0034 0x0000 0x0 0x0
 #define MX7D_PAD_LPSR_GPIO1_IO01__PWM1_OUT                        0x0004 0x0034 0x0000 0x1 0x0
 #define MX7D_PAD_LPSR_GPIO1_IO01__CCM_ENET_REF_CLK3               0x0004 0x0034 0x0000 0x2 0x0
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 77c400f..4a4b522 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -660,7 +660,7 @@
 &iomuxc_lpsr {
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO00__WDOD1_WDOG_B		0x74
+			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B		0x74
 		>;
 	};
 
diff --git a/arch/arm/boot/dts/imx7s-warp.dts b/arch/arm/boot/dts/imx7s-warp.dts
index 8dfed85..07b63f8 100644
--- a/arch/arm/boot/dts/imx7s-warp.dts
+++ b/arch/arm/boot/dts/imx7s-warp.dts
@@ -443,7 +443,7 @@
 &iomuxc_lpsr {
 	pinctrl_wdog: wdoggrp {
 		fsl,pins = <
-			MX7D_PAD_LPSR_GPIO1_IO00__WDOD1_WDOG_B	0x74
+			MX7D_PAD_LPSR_GPIO1_IO00__WDOG1_WDOG_B	0x74
 		>;
 	};
 };
-- 
2.7.4
