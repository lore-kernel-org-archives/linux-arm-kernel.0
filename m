From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 30 Jul 2012 21:29:18 -0300
Subject: [PATCH 1/2] ARM: mx23: Fix registers range
Message-ID: <1343694559-3373-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix registers range.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx23.dtsi |   52 +++++++++++++++++++++---------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index a874dbf..e613831 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -51,11 +51,11 @@
 
 			dma-apbh at 80004000 {
 				compatible = "fsl,imx23-dma-apbh";
-				reg = <0x80004000 2000>;
+				reg = <0x80004000 0x2000>;
 			};
 
 			ecc at 80008000 {
-				reg = <0x80008000 2000>;
+				reg = <0x80008000 0x2000>;
 				status = "disabled";
 			};
 
@@ -63,7 +63,7 @@
 				compatible = "fsl,imx23-gpmi-nand";
 				#address-cells = <1>;
 				#size-cells = <1>;
-				reg = <0x8000c000 2000>, <0x8000a000 2000>;
+				reg = <0x8000c000 0x2000>, <0x8000a000 0x2000>;
 				reg-names = "gpmi-nand", "bch";
 				interrupts = <13>, <56>;
 				interrupt-names = "gpmi-dma", "bch";
@@ -72,14 +72,14 @@
 			};
 
 			ssp0: ssp at 80010000 {
-				reg = <0x80010000 2000>;
+				reg = <0x80010000 0x2000>;
 				interrupts = <15 14>;
 				fsl,ssp-dma-channel = <1>;
 				status = "disabled";
 			};
 
 			etm at 80014000 {
-				reg = <0x80014000 2000>;
+				reg = <0x80014000 0x2000>;
 				status = "disabled";
 			};
 
@@ -87,7 +87,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,imx23-pinctrl", "simple-bus";
-				reg = <0x80018000 2000>;
+				reg = <0x80018000 0x2000>;
 
 				gpio0: gpio at 0 {
 					compatible = "fsl,imx23-gpio", "fsl,mxs-gpio";
@@ -273,32 +273,32 @@
 			};
 
 			emi at 80020000 {
-				reg = <0x80020000 2000>;
+				reg = <0x80020000 0x2000>;
 				status = "disabled";
 			};
 
 			dma-apbx at 80024000 {
 				compatible = "fsl,imx23-dma-apbx";
-				reg = <0x80024000 2000>;
+				reg = <0x80024000 0x2000>;
 			};
 
 			dcp at 80028000 {
-				reg = <0x80028000 2000>;
+				reg = <0x80028000 0x2000>;
 				status = "disabled";
 			};
 
 			pxp at 8002a000 {
-				reg = <0x8002a000 2000>;
+				reg = <0x8002a000 0x2000>;
 				status = "disabled";
 			};
 
 			ocotp at 8002c000 {
-				reg = <0x8002c000 2000>;
+				reg = <0x8002c000 0x2000>;
 				status = "disabled";
 			};
 
 			axi-ahb at 8002e000 {
-				reg = <0x8002e000 2000>;
+				reg = <0x8002e000 0x2000>;
 				status = "disabled";
 			};
 
@@ -310,14 +310,14 @@
 			};
 
 			ssp1: ssp at 80034000 {
-				reg = <0x80034000 2000>;
+				reg = <0x80034000 0x2000>;
 				interrupts = <2 20>;
 				fsl,ssp-dma-channel = <2>;
 				status = "disabled";
 			};
 
 			tvenc at 80038000 {
-				reg = <0x80038000 2000>;
+				reg = <0x80038000 0x2000>;
 				status = "disabled";
 			};
                 };
@@ -330,37 +330,37 @@
 			ranges;
 
 			clkctl at 80040000 {
-				reg = <0x80040000 2000>;
+				reg = <0x80040000 0x2000>;
 				status = "disabled";
 			};
 
 			saif0: saif at 80042000 {
-				reg = <0x80042000 2000>;
+				reg = <0x80042000 0x2000>;
 				status = "disabled";
 			};
 
 			power at 80044000 {
-				reg = <0x80044000 2000>;
+				reg = <0x80044000 0x2000>;
 				status = "disabled";
 			};
 
 			saif1: saif at 80046000 {
-				reg = <0x80046000 2000>;
+				reg = <0x80046000 0x2000>;
 				status = "disabled";
 			};
 
 			audio-out at 80048000 {
-				reg = <0x80048000 2000>;
+				reg = <0x80048000 0x2000>;
 				status = "disabled";
 			};
 
 			audio-in at 8004c000 {
-				reg = <0x8004c000 2000>;
+				reg = <0x8004c000 0x2000>;
 				status = "disabled";
 			};
 
 			lradc at 80050000 {
-				reg = <0x80050000 2000>;
+				reg = <0x80050000 0x2000>;
 				status = "disabled";
 			};
 
@@ -370,26 +370,26 @@
 			};
 
 			i2c at 80058000 {
-				reg = <0x80058000 2000>;
+				reg = <0x80058000 0x2000>;
 				status = "disabled";
 			};
 
 			rtc at 8005c000 {
 				compatible = "fsl,imx23-rtc", "fsl,stmp3xxx-rtc";
-				reg = <0x8005c000 2000>;
+				reg = <0x8005c000 0x2000>;
 				interrupts = <22>;
 			};
 
 			pwm: pwm at 80064000 {
 				compatible = "fsl,imx23-pwm";
-				reg = <0x80064000 2000>;
+				reg = <0x80064000 0x2000>;
 				#pwm-cells = <2>;
 				fsl,pwm-number = <5>;
 				status = "disabled";
 			};
 
 			timrot at 80068000 {
-				reg = <0x80068000 2000>;
+				reg = <0x80068000 0x2000>;
 				status = "disabled";
 			};
 
@@ -429,7 +429,7 @@
 		ranges;
 
 		usbctrl at 80080000 {
-			reg = <0x80080000 0x10000>;
+			reg = <0x80080000 0x40000>;
 			status = "disabled";
 		};
 	};
-- 
1.7.1
