From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 13 Apr 2012 15:05:03 +0100
Subject: [PATCH 1/7] ARM: ux500: Rename the DT compatible entry for i2c
 devices on Snowball
In-Reply-To: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
References: <1334325909-5779-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1334325909-5779-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is believed that the i2c compatible match entry is too long
and cumbersome in its current form. This patch takes steps to
decrease its length by using ST-Mircroelectrics' abbreviation ST.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/db8500.dtsi |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/db8500.dtsi b/arch/arm/boot/dts/db8500.dtsi
index d73dce6..f482845 100644
--- a/arch/arm/boot/dts/db8500.dtsi
+++ b/arch/arm/boot/dts/db8500.dtsi
@@ -56,7 +56,7 @@
 
 		gpio0: gpio at 8012e000 {
 			compatible = "stericsson,db8500-gpio",
-				"stmicroelectronics,nomadik-gpio";
+				"st,nomadik-gpio";
 			reg =  <0x8012e000 0x80>;
 			interrupts = <0 119 0x4>;
 			supports-sleepmode;
@@ -65,7 +65,7 @@
 
 		gpio1: gpio at 8012e080 {
 			compatible = "stericsson,db8500-gpio",
-				"stmicroelectronics,nomadik-gpio";
+				"st,nomadik-gpio";
 			reg =  <0x8012e080 0x80>;
 			interrupts = <0 120 0x4>;
 			supports-sleepmode;
@@ -74,7 +74,7 @@
 
 		gpio2: gpio at 8000e000 {
 			compatible = "stericsson,db8500-gpio",
-				"stmicroelectronics,nomadik-gpio";
+				"st,nomadik-gpio";
 			reg =  <0x8000e000 0x80>;
 			interrupts = <0 121 0x4>;
 			supports-sleepmode;
@@ -83,7 +83,7 @@
 
 		gpio3: gpio at 8000e080 {
 			compatible = "stericsson,db8500-gpio",
-				"stmicroelectronics,nomadik-gpio";
+				"st,nomadik-gpio";
 			reg =  <0x8000e080 0x80>;
 			interrupts = <0 122 0x4>;
 			supports-sleepmode;
@@ -92,7 +92,7 @@
 
 		gpio4: gpio at 8000e100 {
 			compatible = "stericsson,db8500-gpio",
-				"stmicroelectronics,nomadik-gpio";
+				"st,nomadik-gpio";
 			reg =  <0x8000e100 0x80>;
 			interrupts = <0 123 0x4>;
 			supports-sleepmode;
@@ -101,7 +101,7 @@
 
 		gpio5: gpio at 8000e180 {
 			compatible = "stericsson,db8500-gpio",
-				"stmicroelectronics,nomadik-gpio";
+				"st,nomadik-gpio";
 			reg =  <0x8000e180 0x80>;
 			interrupts = <0 124 0x4>;
 			supports-sleepmode;
@@ -110,7 +110,7 @@
 
 		gpio6: gpio at 8011e000 {
 			compatible = "stericsson,db8500-gpio",
-				"stmicroelectronics,nomadik-gpio";
+				"st,nomadik-gpio";
 			reg =  <0x8011e000 0x80>;
 			interrupts = <0 125 0x4>;
 			supports-sleepmode;
@@ -119,7 +119,7 @@
 
 		gpio7: gpio at 8011e080 {
 			compatible = "stericsson,db8500-gpio",
-				"stmicroelectronics,nomadik-gpio";
+				"st,nomadik-gpio";
 			reg =  <0x8011e080 0x80>;
 			interrupts = <0 126 0x4>;
 			supports-sleepmode;
@@ -128,7 +128,7 @@
 
 		gpio8: gpio at a03fe000 {
 			compatible = "stericsson,db8500-gpio",
-				"stmicroelectronics,nomadik-gpio";
+				"st,nomadik-gpio";
 			reg =  <0xa03fe000 0x80>;
 			interrupts = <0 127 0x4>;
 			supports-sleepmode;
-- 
1.7.9.1
