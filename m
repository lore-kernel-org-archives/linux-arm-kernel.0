From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 30 Jul 2012 21:29:19 -0300
Subject: [PATCH 2/2] ARM: mx28: Fix registers range
In-Reply-To: <1343694559-3373-1-git-send-email-festevam@gmail.com>
References: <1343694559-3373-1-git-send-email-festevam@gmail.com>
Message-ID: <1343694559-3373-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix registers range.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28.dtsi |   74 +++++++++++++++++++++---------------------
 1 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 787efac..3fa6d19 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -57,18 +57,18 @@
 			};
 
 			hsadc at 80002000 {
-				reg = <0x80002000 2000>;
+				reg = <0x80002000 0x2000>;
 				interrupts = <13 87>;
 				status = "disabled";
 			};
 
 			dma-apbh at 80004000 {
 				compatible = "fsl,imx28-dma-apbh";
-				reg = <0x80004000 2000>;
+				reg = <0x80004000 0x2000>;
 			};
 
 			perfmon at 80006000 {
-				reg = <0x80006000 800>;
+				reg = <0x80006000 0x800>;
 				interrupts = <27>;
 				status = "disabled";
 			};
@@ -77,7 +77,7 @@
 				compatible = "fsl,imx28-gpmi-nand";
 				#address-cells = <1>;
 				#size-cells = <1>;
-				reg = <0x8000c000 2000>, <0x8000a000 2000>;
+				reg = <0x8000c000 0x2000>, <0x8000a000 0x2000>;
 				reg-names = "gpmi-nand", "bch";
 				interrupts = <88>, <41>;
 				interrupt-names = "gpmi-dma", "bch";
@@ -86,28 +86,28 @@
 			};
 
 			ssp0: ssp at 80010000 {
-				reg = <0x80010000 2000>;
+				reg = <0x80010000 0x2000>;
 				interrupts = <96 82>;
 				fsl,ssp-dma-channel = <0>;
 				status = "disabled";
 			};
 
 			ssp1: ssp at 80012000 {
-				reg = <0x80012000 2000>;
+				reg = <0x80012000 0x2000>;
 				interrupts = <97 83>;
 				fsl,ssp-dma-channel = <1>;
 				status = "disabled";
 			};
 
 			ssp2: ssp at 80014000 {
-				reg = <0x80014000 2000>;
+				reg = <0x80014000 0x2000>;
 				interrupts = <98 84>;
 				fsl,ssp-dma-channel = <2>;
 				status = "disabled";
 			};
 
 			ssp3: ssp at 80016000 {
-				reg = <0x80016000 2000>;
+				reg = <0x80016000 0x2000>;
 				interrupts = <99 85>;
 				fsl,ssp-dma-channel = <3>;
 				status = "disabled";
@@ -117,7 +117,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,imx28-pinctrl", "simple-bus";
-				reg = <0x80018000 2000>;
+				reg = <0x80018000 0x2000>;
 
 				gpio0: gpio at 0 {
 					compatible = "fsl,imx28-gpio", "fsl,mxs-gpio";
@@ -510,96 +510,96 @@
 			};
 
 			digctl at 8001c000 {
-				reg = <0x8001c000 2000>;
+				reg = <0x8001c000 0x2000>;
 				interrupts = <89>;
 				status = "disabled";
 			};
 
 			etm at 80022000 {
-				reg = <0x80022000 2000>;
+				reg = <0x80022000 0x2000>;
 				status = "disabled";
 			};
 
 			dma-apbx at 80024000 {
 				compatible = "fsl,imx28-dma-apbx";
-				reg = <0x80024000 2000>;
+				reg = <0x80024000 0x2000>;
 			};
 
 			dcp at 80028000 {
-				reg = <0x80028000 2000>;
+				reg = <0x80028000 0x2000>;
 				interrupts = <52 53 54>;
 				status = "disabled";
 			};
 
 			pxp at 8002a000 {
-				reg = <0x8002a000 2000>;
+				reg = <0x8002a000 0x2000>;
 				interrupts = <39>;
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
 
 			lcdif at 80030000 {
 				compatible = "fsl,imx28-lcdif";
-				reg = <0x80030000 2000>;
+				reg = <0x80030000 0x2000>;
 				interrupts = <38 86>;
 				status = "disabled";
 			};
 
 			can0: can at 80032000 {
 				compatible = "fsl,imx28-flexcan", "fsl,p1010-flexcan";
-				reg = <0x80032000 2000>;
+				reg = <0x80032000 0x2000>;
 				interrupts = <8>;
 				status = "disabled";
 			};
 
 			can1: can at 80034000 {
 				compatible = "fsl,imx28-flexcan", "fsl,p1010-flexcan";
-				reg = <0x80034000 2000>;
+				reg = <0x80034000 0x2000>;
 				interrupts = <9>;
 				status = "disabled";
 			};
 
 			simdbg at 8003c000 {
-				reg = <0x8003c000 200>;
+				reg = <0x8003c000 0x200>;
 				status = "disabled";
 			};
 
 			simgpmisel at 8003c200 {
-				reg = <0x8003c200 100>;
+				reg = <0x8003c200 0x100>;
 				status = "disabled";
 			};
 
 			simsspsel at 8003c300 {
-				reg = <0x8003c300 100>;
+				reg = <0x8003c300 0x100>;
 				status = "disabled";
 			};
 
 			simmemsel at 8003c400 {
-				reg = <0x8003c400 100>;
+				reg = <0x8003c400 0x100>;
 				status = "disabled";
 			};
 
 			gpiomon at 8003c500 {
-				reg = <0x8003c500 100>;
+				reg = <0x8003c500 0x100>;
 				status = "disabled";
 			};
 
 			simenet at 8003c700 {
-				reg = <0x8003c700 100>;
+				reg = <0x8003c700 0x100>;
 				status = "disabled";
 			};
 
 			armjtag at 8003c800 {
-				reg = <0x8003c800 100>;
+				reg = <0x8003c800 0x100>;
 				status = "disabled";
 			};
                 };
@@ -612,45 +612,45 @@
 			ranges;
 
 			clkctl at 80040000 {
-				reg = <0x80040000 2000>;
+				reg = <0x80040000 0x2000>;
 				status = "disabled";
 			};
 
 			saif0: saif at 80042000 {
 				compatible = "fsl,imx28-saif";
-				reg = <0x80042000 2000>;
+				reg = <0x80042000 0x2000>;
 				interrupts = <59 80>;
 				fsl,saif-dma-channel = <4>;
 				status = "disabled";
 			};
 
 			power at 80044000 {
-				reg = <0x80044000 2000>;
+				reg = <0x80044000 0x2000>;
 				status = "disabled";
 			};
 
 			saif1: saif at 80046000 {
 				compatible = "fsl,imx28-saif";
-				reg = <0x80046000 2000>;
+				reg = <0x80046000 0x2000>;
 				interrupts = <58 81>;
 				fsl,saif-dma-channel = <5>;
 				status = "disabled";
 			};
 
 			lradc at 80050000 {
-				reg = <0x80050000 2000>;
+				reg = <0x80050000 0x2000>;
 				status = "disabled";
 			};
 
 			spdif at 80054000 {
-				reg = <0x80054000 2000>;
+				reg = <0x80054000 0x2000>;
 				interrupts = <45 66>;
 				status = "disabled";
 			};
 
 			rtc at 80056000 {
 				compatible = "fsl,imx28-rtc", "fsl,stmp3xxx-rtc";
-				reg = <0x80056000 2000>;
+				reg = <0x80056000 0x2000>;
 				interrupts = <29>;
 			};
 
@@ -658,7 +658,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,imx28-i2c";
-				reg = <0x80058000 2000>;
+				reg = <0x80058000 0x2000>;
 				interrupts = <111 68>;
 				clock-frequency = <100000>;
 				status = "disabled";
@@ -668,7 +668,7 @@
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,imx28-i2c";
-				reg = <0x8005a000 2000>;
+				reg = <0x8005a000 0x2000>;
 				interrupts = <110 69>;
 				clock-frequency = <100000>;
 				status = "disabled";
@@ -676,14 +676,14 @@
 
 			pwm: pwm at 80064000 {
 				compatible = "fsl,imx28-pwm", "fsl,imx23-pwm";
-				reg = <0x80064000 2000>;
+				reg = <0x80064000 0x2000>;
 				#pwm-cells = <2>;
 				fsl,pwm-number = <8>;
 				status = "disabled";
 			};
 
 			timrot at 80068000 {
-				reg = <0x80068000 2000>;
+				reg = <0x80068000 0x2000>;
 				status = "disabled";
 			};
 
-- 
1.7.1
