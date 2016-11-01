From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue,  1 Nov 2016 18:10:04 +0100
Subject: [PATCH v2 3/5] ARM: dts: imx6qdl-nitrogen6x: use hyphens for nodes
 name
In-Reply-To: <20161101171006.24594-1-gary.bisson@boundarydevices.com>
References: <20161025211955.5345-1-gary.bisson@boundarydevices.com>
 <20161101171006.24594-1-gary.bisson@boundarydevices.com>
Message-ID: <20161101171006.24594-4-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also aligning the panel nodes name across all platforms.

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index db868bc..e476d01 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -167,7 +167,7 @@
 		mux-ext-port = <3>;
 	};
 
-	backlight_lcd: backlight_lcd {
+	backlight_lcd: backlight-lcd {
 		compatible = "pwm-backlight";
 		pwms = <&pwm1 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -176,7 +176,7 @@
 		status = "okay";
 	};
 
-	backlight_lvds: backlight_lvds {
+	backlight_lvds: backlight-lvds {
 		compatible = "pwm-backlight";
 		pwms = <&pwm4 0 5000000>;
 		brightness-levels = <0 4 8 16 32 64 128 255>;
@@ -211,7 +211,7 @@
 		};
 	};
 
-	lcd_panel {
+	panel-lcd {
 		compatible = "okaya,rs800480t-7x0gp";
 		backlight = <&backlight_lcd>;
 
@@ -222,7 +222,7 @@
 		};
 	};
 
-	panel {
+	panel-lvds0 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds>;
 
@@ -413,7 +413,7 @@
 			>;
 		};
 
-		pinctrl_gpio_keys: gpio_keysgrp {
+		pinctrl_gpio_keys: gpio-keysgrp {
 			fsl,pins = <
 				/* Power Button */
 				MX6QDL_PAD_NANDF_D3__GPIO2_IO03		0x1b0b0
@@ -561,7 +561,7 @@
 			>;
 		};
 
-		pinctrl_wlan_vmmc: wlan_vmmcgrp {
+		pinctrl_wlan_vmmc: wlan-vmmcgrp {
 			fsl,pins = <
 				MX6QDL_PAD_NANDF_CS0__GPIO6_IO11	0x100b0
 				MX6QDL_PAD_NANDF_CS2__GPIO6_IO15	0x000b0
-- 
2.9.3
