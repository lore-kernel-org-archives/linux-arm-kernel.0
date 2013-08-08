From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu,  8 Aug 2013 14:51:21 +0200
Subject: [PATCH 2/8] ARM: dts: mxs: add labels to most nodes for easier
 reference
In-Reply-To: <1375966287-6784-1-git-send-email-LW@KARO-electronics.de>
References: <1375966287-6784-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1375966287-6784-3-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx28.dtsi |   48 +++++++++++++++++++++---------------------
 1 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index e8e5d49..546fd7a 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -64,7 +64,7 @@
 				reg = <0x80000000 0x2000>;
 			};
 
-			hsadc at 80002000 {
+			hsadc: hsadc at 80002000 {
 				reg = <0x80002000 0x2000>;
 				interrupts = <13>;
 				dmas = <&dma_apbh 12>;
@@ -88,13 +88,13 @@
 				clocks = <&clks 25>;
 			};
 
-			perfmon at 80006000 {
+			perfmon: perfmon at 80006000 {
 				reg = <0x80006000 0x800>;
 				interrupts = <27>;
 				status = "disabled";
 			};
 
-			gpmi-nand at 8000c000 {
+			gpmi: gpmi-nand at 8000c000 {
 				compatible = "fsl,imx28-gpmi-nand";
 				#address-cells = <1>;
 				#size-cells = <1>;
@@ -153,7 +153,7 @@
 				status = "disabled";
 			};
 
-			pinctrl at 80018000 {
+			pinctrl: pinctrl at 80018000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
 				compatible = "fsl,imx28-pinctrl", "simple-bus";
@@ -702,14 +702,14 @@
 				};
 			};
 
-			digctl at 8001c000 {
+			digctl: digctl at 8001c000 {
 				compatible = "fsl,imx28-digctl", "fsl,imx23-digctl";
 				reg = <0x8001c000 0x2000>;
 				interrupts = <89>;
 				status = "disabled";
 			};
 
-			etm at 80022000 {
+			etm: etm at 80022000 {
 				reg = <0x80022000 0x2000>;
 				status = "disabled";
 			};
@@ -730,19 +730,19 @@
 				clocks = <&clks 26>;
 			};
 
-			dcp at 80028000 {
+			dcp: dcp at 80028000 {
 				reg = <0x80028000 0x2000>;
 				interrupts = <52 53 54>;
 				compatible = "fsl-dcp";
 			};
 
-			pxp at 8002a000 {
+			pxp: pxp at 8002a000 {
 				reg = <0x8002a000 0x2000>;
 				interrupts = <39>;
 				status = "disabled";
 			};
 
-			ocotp at 8002c000 {
+			ocotp: ocotp at 8002c000 {
 				compatible = "fsl,ocotp";
 				reg = <0x8002c000 0x2000>;
 				status = "disabled";
@@ -753,7 +753,7 @@
 				status = "disabled";
 			};
 
-			lcdif at 80030000 {
+			lcdif: lcdif at 80030000 {
 				compatible = "fsl,imx28-lcdif";
 				reg = <0x80030000 0x2000>;
 				interrupts = <38>;
@@ -781,37 +781,37 @@
 				status = "disabled";
 			};
 
-			simdbg at 8003c000 {
+			simdbg: simdbg at 8003c000 {
 				reg = <0x8003c000 0x200>;
 				status = "disabled";
 			};
 
-			simgpmisel at 8003c200 {
+			simgpmisel: simgpmisel at 8003c200 {
 				reg = <0x8003c200 0x100>;
 				status = "disabled";
 			};
 
-			simsspsel at 8003c300 {
+			simsspsel: simsspsel at 8003c300 {
 				reg = <0x8003c300 0x100>;
 				status = "disabled";
 			};
 
-			simmemsel at 8003c400 {
+			simmemsel: simmemsel at 8003c400 {
 				reg = <0x8003c400 0x100>;
 				status = "disabled";
 			};
 
-			gpiomon at 8003c500 {
+			gpiomon: gpiomon at 8003c500 {
 				reg = <0x8003c500 0x100>;
 				status = "disabled";
 			};
 
-			simenet at 8003c700 {
+			simenet: simenet at 8003c700 {
 				reg = <0x8003c700 0x100>;
 				status = "disabled";
 			};
 
-			armjtag at 8003c800 {
+			armjtag: armjtag at 8003c800 {
 				reg = <0x8003c800 0x100>;
 				status = "disabled";
 			};
@@ -841,7 +841,7 @@
 				status = "disabled";
 			};
 
-			power at 80044000 {
+			power: power at 80044000 {
 				reg = <0x80044000 0x2000>;
 				status = "disabled";
 			};
@@ -856,7 +856,7 @@
 				status = "disabled";
 			};
 
-			lradc at 80050000 {
+			lradc: lradc at 80050000 {
 				compatible = "fsl,imx28-lradc";
 				reg = <0x80050000 0x2000>;
 				interrupts = <10 14 15 16 17 18 19
@@ -864,7 +864,7 @@
 				status = "disabled";
 			};
 
-			spdif at 80054000 {
+			spdif: spdif@80054000 {
 				reg = <0x80054000 0x2000>;
 				interrupts = <45>;
 				dmas = <&dma_apbx 2>;
@@ -872,7 +872,7 @@
 				status = "disabled";
 			};
 
-			rtc at 80056000 {
+			mxs_rtc: rtc at 80056000 {
 				compatible = "fsl,imx28-rtc", "fsl,stmp3xxx-rtc";
 				reg = <0x80056000 0x2000>;
 				interrupts = <29>;
@@ -911,7 +911,7 @@
 				status = "disabled";
 			};
 
-			timrot at 80068000 {
+			timer: timrot at 80068000 {
 				compatible = "fsl,imx28-timrot", "fsl,timrot";
 				reg = <0x80068000 0x2000>;
 				interrupts = <48 49 50 51>;
@@ -1018,7 +1018,7 @@
 			status = "disabled";
 		};
 
-		dflpt at 800c0000 {
+		dflpt: dflpt at 800c0000 {
 			reg = <0x800c0000 0x10000>;
 			status = "disabled";
 		};
@@ -1041,7 +1041,7 @@
 			status = "disabled";
 		};
 
-		switch at 800f8000 {
+		etn_switch: switch at 800f8000 {
 			reg = <0x800f8000 0x8000>;
 			status = "disabled";
 		};
-- 
1.7.2.5
