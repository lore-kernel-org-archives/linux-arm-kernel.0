From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Nov 2013 16:20:48 -0200
Subject: [PATCH] ARM: dts: imx6q-sabrelite: Place 'status' as the last node
Message-ID: <1384971648-27056-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

In order to follow the standard approach used on other imx dts files, place the
'status' node as the last one.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6q-sabrelite.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index ec9e4c1..75760ed 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -71,9 +71,9 @@
 };
 
 &audmux {
-	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_audmux>;
+	status = "okay";
 };
 
 &ecspi1 {
@@ -99,10 +99,10 @@
 };
 
 &i2c1 {
-	status = "okay";
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
 
 	codec: sgtl5000 at 0a {
 		compatible = "fsl,sgtl5000";
@@ -200,9 +200,9 @@
 };
 
 &uart2 {
-	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
+	status = "okay";
 };
 
 &usbh1 {
-- 
1.8.1.2
