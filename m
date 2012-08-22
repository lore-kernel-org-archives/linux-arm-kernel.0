From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 22 Aug 2012 13:25:31 -0300
Subject: [PATCH 1/3] ARM: mxs: Rename 'hog-gpios'
Message-ID: <1345652733-13265-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

hog_pins is used to setup the pin functions, and it is not neccesarily used only
for GPIO pins, so use only 'hog' to describe a more generic term.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx23-evk.dts           |    2 +-
 arch/arm/boot/dts/imx23-stmp378x_devb.dts |    2 +-
 arch/arm/boot/dts/imx28-apx4devkit.dts    |    2 +-
 arch/arm/boot/dts/imx28-evk.dts           |    2 +-
 arch/arm/boot/dts/imx28-m28evk.dts        |    2 +-
 arch/arm/boot/dts/imx28-tx28.dts          |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index e3486f4..1093dd5 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -42,7 +42,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog-gpios at 0 {
+				hog_pins_a: hog at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
 						0x1123 /* MX23_PAD_LCD_RESET__GPIO_1_18 */
diff --git a/arch/arm/boot/dts/imx23-stmp378x_devb.dts b/arch/arm/boot/dts/imx23-stmp378x_devb.dts
index 757a327..85c3864 100644
--- a/arch/arm/boot/dts/imx23-stmp378x_devb.dts
+++ b/arch/arm/boot/dts/imx23-stmp378x_devb.dts
@@ -36,7 +36,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog-gpios at 0 {
+				hog_pins_a: hog at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
 						0x11d3 /* MX23_PAD_PWM3__GPIO_1_29 */
diff --git a/arch/arm/boot/dts/imx28-apx4devkit.dts b/arch/arm/boot/dts/imx28-apx4devkit.dts
index b383417..5171667 100644
--- a/arch/arm/boot/dts/imx28-apx4devkit.dts
+++ b/arch/arm/boot/dts/imx28-apx4devkit.dts
@@ -37,7 +37,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog-gpios at 0 {
+				hog_pins_a: hog at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
 						0x0113 /* MX28_PAD_GPMI_CE1N__GPIO_0_17 */
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 773c0e8..ab78ee5 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -50,7 +50,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog-gpios at 0 {
+				hog_pins_a: hog at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
 						0x20d3 /* MX28_PAD_SSP1_CMD__GPIO_2_13 */
diff --git a/arch/arm/boot/dts/imx28-m28evk.dts b/arch/arm/boot/dts/imx28-m28evk.dts
index 183a3fd..ac3eff9 100644
--- a/arch/arm/boot/dts/imx28-m28evk.dts
+++ b/arch/arm/boot/dts/imx28-m28evk.dts
@@ -69,7 +69,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog-gpios at 0 {
+				hog_pins_a: hog at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
 						0x30a3 /* MX28_PAD_AUART2_CTS__GPIO_3_10 */
diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
index a56ae05..37be532 100644
--- a/arch/arm/boot/dts/imx28-tx28.dts
+++ b/arch/arm/boot/dts/imx28-tx28.dts
@@ -25,7 +25,7 @@
 				pinctrl-names = "default";
 				pinctrl-0 = <&hog_pins_a>;
 
-				hog_pins_a: hog-gpios at 0 {
+				hog_pins_a: hog at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <
 						0x40a3 /* MX28_PAD_ENET0_RXD3__GPIO_4_10 */
-- 
1.7.9.5
