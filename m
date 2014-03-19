From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 19 Mar 2014 14:28:37 +0100
Subject: [PATCH 1/5] ARM: dts: tx53: remove redundant regulator-boot-on
Message-ID: <1395235721-13847-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53-tx53-x13x.dts |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
index 6480471..c8a3473 100644
--- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
@@ -72,7 +72,6 @@
 			regulator-max-microvolt = <3300000>;
 			gpio = <&gpio3 29 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
-			regulator-boot-on;
 		};
 
 		reg_lcd_pwr1: regulator at 6 {
@@ -83,7 +82,6 @@
 			regulator-max-microvolt = <3300000>;
 			gpio = <&gpio2 31 GPIO_ACTIVE_HIGH>;
 			enable-active-high;
-			regulator-boot-on;
 		};
 	};
 };
-- 
1.7.10.4
