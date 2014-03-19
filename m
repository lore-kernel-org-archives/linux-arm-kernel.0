From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 19 Mar 2014 14:28:40 +0100
Subject: [PATCH 4/5] ARM: dts: tx53: add simple-panel support
In-Reply-To: <1395235721-13847-1-git-send-email-LW@KARO-electronics.de>
References: <1395235721-13847-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1395235721-13847-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53-tx53-x13x.dts |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
index 26b918e..86a964d 100644
--- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
@@ -63,6 +63,18 @@
 		default-brightness-level = <50>;
 	};
 
+	panel0 {
+		compatible = "simple-panel";
+		power-supply = <&reg_lcd_pwr0>;
+		backlight = <&backlight0>;
+	};
+
+	panel1 {
+		compatible = "simple-panel";
+		power-supply = <&reg_lcd_pwr1>;
+		backlight = <&backlight1>;
+	};
+
 	regulators {
 		reg_lcd_pwr0: regulator at 5 {
 			compatible = "regulator-fixed";
-- 
1.7.10.4
