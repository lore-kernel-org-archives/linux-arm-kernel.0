From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue,  1 Nov 2016 18:10:06 +0100
Subject: [PATCH v2 5/5] ARM: dts: imx6qdl-nitrogen6_max: use hyphens for nodes
 name
In-Reply-To: <20161101171006.24594-1-gary.bisson@boundarydevices.com>
References: <20161025211955.5345-1-gary.bisson@boundarydevices.com>
 <20161101171006.24594-1-gary.bisson@boundarydevices.com>
Message-ID: <20161101171006.24594-6-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Therefore aligning the panel nodes name across all platforms.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
index b0b3220..34887a1 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi
@@ -229,7 +229,7 @@
 		};
 	};
 
-	backlight_lcd: backlight_lcd {
+	backlight_lcd: backlight-lcd {
 		compatible = "pwm-backlight";
 		pwms = <&pwm1 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -238,7 +238,7 @@
 		status = "okay";
 	};
 
-	backlight_lvds0: backlight_lvds0 {
+	backlight_lvds0: backlight-lvds0 {
 		compatible = "pwm-backlight";
 		pwms = <&pwm4 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -247,7 +247,7 @@
 		status = "okay";
 	};
 
-	backlight_lvds1: backlight_lvds1 {
+	backlight_lvds1: backlight-lvds1 {
 		compatible = "pwm-backlight";
 		pwms = <&pwm2 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -282,7 +282,7 @@
 		};
 	};
 
-	panel_lcd {
+	panel-lcd {
 		compatible = "okaya,rs800480t-7x0gp";
 		backlight = <&backlight_lcd>;
 
@@ -293,7 +293,7 @@
 		};
 	};
 
-	panel_lvds0 {
+	panel-lvds0 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds0>;
 
@@ -304,7 +304,7 @@
 		};
 	};
 
-	panel_lvds1 {
+	panel-lvds1 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds1>;
 
@@ -447,7 +447,7 @@
 };
 
 &iomuxc {
-	imx6q-nitrogen6_max {
+	imx6q-nitrogen6-max {
 		pinctrl_audmux: audmuxgrp {
 			fsl,pins = <
 				MX6QDL_PAD_CSI0_DAT7__AUD3_RXD		0x130b0
@@ -504,7 +504,7 @@
 			>;
 		};
 
-		pinctrl_gpio_keys: gpio_keysgrp {
+		pinctrl_gpio_keys: gpio-keysgrp {
 			fsl,pins = <
 				/* Power Button */
 				MX6QDL_PAD_NANDF_D3__GPIO2_IO03		0x1b0b0
@@ -720,7 +720,7 @@
 			>;
 		};
 
-		pinctrl_wlan_vmmc: wlan_vmmcgrp {
+		pinctrl_wlan_vmmc: wlan-vmmcgrp {
 			fsl,pins = <
 				MX6QDL_PAD_NANDF_CS0__GPIO6_IO11	0x100b0
 				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15	0x000b0
-- 
2.9.3
