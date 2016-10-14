From: jteki@openedev.com (Jagan Teki)
Date: Fri, 14 Oct 2016 15:09:29 +0530
Subject: [PATCH v2 2/3] arm: dts: imx6qdl: Fix "ERROR: code indent should use
 tabs where possible"
In-Reply-To: <1476437970-15800-1-git-send-email-jteki@openedev.com>
References: <1476437970-15800-1-git-send-email-jteki@openedev.com>
Message-ID: <1476437970-15800-3-git-send-email-jteki@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed code indent tabs in respetcive imx6qdl dtsi files.

Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Jagan Teki <jteki@openedev.com>
---
Changes for v2:
	- none

 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi        | 4 ++--
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi        | 4 ++--
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi        | 4 ++--
 arch/arm/boot/dts/imx6qdl-gw552x.dtsi        | 2 +-
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 6 +++---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi     | 2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi       | 4 ++--
 arch/arm/boot/dts/imx6qdl.dtsi               | 6 +++---
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
index a7100f9..54aca3a 100644
--- a/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw52xx.dtsi
@@ -153,9 +153,9 @@
 
 &clks {
 	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
-	                  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
+			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
 	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
-	                  <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
+				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
 };
 
 &ecspi3 {
diff --git a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
index 8953eba..88e5cb3b 100644
--- a/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw53xx.dtsi
@@ -154,9 +154,9 @@
 
 &clks {
 	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
-	                  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
+			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
 	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
-	                  <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
+				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
 };
 
 &fec {
diff --git a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
index 6ac41c7..1753ab7 100644
--- a/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw54xx.dtsi
@@ -144,9 +144,9 @@
 
 &clks {
 	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
-	                  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
+			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
 	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
-	                  <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
+				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
 };
 
 &fec {
diff --git a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
index 805e236..ee83161 100644
--- a/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-gw552x.dtsi
@@ -291,7 +291,7 @@
 				MX6QDL_PAD_KEY_COL1__UART5_TX_DATA	0x1b0b1
 				MX6QDL_PAD_KEY_ROW1__UART5_RX_DATA	0x1b0b1
 			>;
-                };
+		};
 
 		pinctrl_wdog: wdoggrp {
 			fsl,pins = <
diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index e0280cac2..e9801a2 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -427,10 +427,10 @@
 };
 
 &usdhc3 {
-        pinctrl-names = "default";
-        pinctrl-0 = <&pinctrl_usdhc3
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usdhc3
 		     &pinctrl_usdhc3_cdwp>;
 	cd-gpios = <&gpio1 27 GPIO_ACTIVE_LOW>;
 	wp-gpios = <&gpio1 29 GPIO_ACTIVE_HIGH>;
-        status = "disabled";
+	status = "disabled";
 };
diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index e000e6f..8006467 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -283,7 +283,7 @@
 		VD-supply = <&reg_audio>;
 		VLS-supply = <&reg_audio>;
 		VLC-supply = <&reg_audio>;
-        };
+	};
 
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 8e9e0d9..55ef535 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -129,8 +129,8 @@
 		pinctrl-0 = <&pinctrl_gpio_leds>;
 
 		red {
-		        gpios = <&gpio1 2 0>;
-		        default-state = "on";
+			gpios = <&gpio1 2 0>;
+			default-state = "on";
 		};
 	};
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b13b0b2..1bbd36f 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -204,9 +204,9 @@
 			#interrupt-cells = <1>;
 			interrupt-map-mask = <0 0 0 0x7>;
 			interrupt-map = <0 0 0 1 &gpc GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>,
-			                <0 0 0 2 &gpc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
-			                <0 0 0 3 &gpc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
-			                <0 0 0 4 &gpc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
+					<0 0 0 2 &gpc GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 3 &gpc GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+					<0 0 0 4 &gpc GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clks IMX6QDL_CLK_PCIE_AXI>,
 				 <&clks IMX6QDL_CLK_LVDS1_GATE>,
 				 <&clks IMX6QDL_CLK_PCIE_REF_125M>;
-- 
2.7.4
