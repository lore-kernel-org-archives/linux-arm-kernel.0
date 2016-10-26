From: jagan@openedev.com (Jagan Teki)
Date: Wed, 26 Oct 2016 15:31:01 +0530
Subject: [PATCH] ARM: dts: imx: Fix "ERROR: code indent should use tabs where
 possible"
Message-ID: <1477476061-30442-1-git-send-email-jagan@openedev.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed code indent tabs in respetcive imx23, imx51, imx53, imx6dl, imx6q
and imx6sx dtsi and dts files.

Signed-off-by: Jagan Teki <jagan@openedev.com>
---
 arch/arm/boot/dts/imx23.dtsi                 |  2 +-
 arch/arm/boot/dts/imx50.dtsi                 | 44 +++++++++---------
 arch/arm/boot/dts/imx51.dtsi                 | 44 +++++++++---------
 arch/arm/boot/dts/imx53.dtsi                 | 68 ++++++++++++++--------------
 arch/arm/boot/dts/imx6dl-riotboard.dts       |  2 +-
 arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts    |  2 +-
 arch/arm/boot/dts/imx6dl-tx6u-801x.dts       |  2 +-
 arch/arm/boot/dts/imx6q-phytec-pbab01.dts    |  2 +-
 arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts |  2 +-
 arch/arm/boot/dts/imx6q-tx6q-1010.dts        |  2 +-
 arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts |  2 +-
 arch/arm/boot/dts/imx6q-tx6q-1020.dts        |  2 +-
 arch/arm/boot/dts/imx6sx-sdb.dtsi            |  8 ++--
 arch/arm/boot/dts/imx6sx.dtsi                |  6 +--
 14 files changed, 94 insertions(+), 94 deletions(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 440ee9a..8e1543f 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -464,7 +464,7 @@
 				reg = <0x80038000 0x2000>;
 				status = "disabled";
 			};
-                };
+		};
 
 		apbx at 80040000 {
 			compatible = "simple-bus";
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index 8fe8bee..92a03bc 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -103,8 +103,8 @@
 					reg = <0x50004000 0x4000>;
 					interrupts = <1>;
 					clocks = <&clks IMX5_CLK_ESDHC1_IPG_GATE>,
-					         <&clks IMX5_CLK_DUMMY>,
-					         <&clks IMX5_CLK_ESDHC1_PER_GATE>;
+						 <&clks IMX5_CLK_DUMMY>,
+						 <&clks IMX5_CLK_ESDHC1_PER_GATE>;
 					clock-names = "ipg", "ahb", "per";
 					bus-width = <4>;
 					status = "disabled";
@@ -115,8 +115,8 @@
 					reg = <0x50008000 0x4000>;
 					interrupts = <2>;
 					clocks = <&clks IMX5_CLK_ESDHC2_IPG_GATE>,
-					         <&clks IMX5_CLK_DUMMY>,
-					         <&clks IMX5_CLK_ESDHC2_PER_GATE>;
+						 <&clks IMX5_CLK_DUMMY>,
+						 <&clks IMX5_CLK_ESDHC2_PER_GATE>;
 					clock-names = "ipg", "ahb", "per";
 					bus-width = <4>;
 					status = "disabled";
@@ -127,7 +127,7 @@
 					reg = <0x5000c000 0x4000>;
 					interrupts = <33>;
 					clocks = <&clks IMX5_CLK_UART3_IPG_GATE>,
-					         <&clks IMX5_CLK_UART3_PER_GATE>;
+						 <&clks IMX5_CLK_UART3_PER_GATE>;
 					clock-names = "ipg", "per";
 					status = "disabled";
 				};
@@ -139,7 +139,7 @@
 					reg = <0x50010000 0x4000>;
 					interrupts = <36>;
 					clocks = <&clks IMX5_CLK_ECSPI1_IPG_GATE>,
-					         <&clks IMX5_CLK_ECSPI1_PER_GATE>;
+						 <&clks IMX5_CLK_ECSPI1_PER_GATE>;
 					clock-names = "ipg", "per";
 					status = "disabled";
 				};
@@ -164,8 +164,8 @@
 					reg = <0x50020000 0x4000>;
 					interrupts = <3>;
 					clocks = <&clks IMX5_CLK_ESDHC3_IPG_GATE>,
-					         <&clks IMX5_CLK_DUMMY>,
-					         <&clks IMX5_CLK_ESDHC3_PER_GATE>;
+						 <&clks IMX5_CLK_DUMMY>,
+						 <&clks IMX5_CLK_ESDHC3_PER_GATE>;
 					clock-names = "ipg", "ahb", "per";
 					bus-width = <4>;
 					status = "disabled";
@@ -176,8 +176,8 @@
 					reg = <0x50024000 0x4000>;
 					interrupts = <4>;
 					clocks = <&clks IMX5_CLK_ESDHC4_IPG_GATE>,
-					         <&clks IMX5_CLK_DUMMY>,
-					         <&clks IMX5_CLK_ESDHC4_PER_GATE>;
+						 <&clks IMX5_CLK_DUMMY>,
+						 <&clks IMX5_CLK_ESDHC4_PER_GATE>;
 					clock-names = "ipg", "ahb", "per";
 					bus-width = <4>;
 					status = "disabled";
@@ -279,7 +279,7 @@
 				reg = <0x53fa0000 0x4000>;
 				interrupts = <39>;
 				clocks = <&clks IMX5_CLK_GPT_IPG_GATE>,
-				         <&clks IMX5_CLK_GPT_HF_GATE>;
+					 <&clks IMX5_CLK_GPT_HF_GATE>;
 				clock-names = "ipg", "per";
 			};
 
@@ -298,7 +298,7 @@
 				compatible = "fsl,imx50-pwm", "fsl,imx27-pwm";
 				reg = <0x53fb4000 0x4000>;
 				clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
-				         <&clks IMX5_CLK_PWM1_HF_GATE>;
+					 <&clks IMX5_CLK_PWM1_HF_GATE>;
 				clock-names = "ipg", "per";
 				interrupts = <61>;
 			};
@@ -308,7 +308,7 @@
 				compatible = "fsl,imx50-pwm", "fsl,imx27-pwm";
 				reg = <0x53fb8000 0x4000>;
 				clocks = <&clks IMX5_CLK_PWM2_IPG_GATE>,
-				         <&clks IMX5_CLK_PWM2_HF_GATE>;
+					 <&clks IMX5_CLK_PWM2_HF_GATE>;
 				clock-names = "ipg", "per";
 				interrupts = <94>;
 			};
@@ -318,7 +318,7 @@
 				reg = <0x53fbc000 0x4000>;
 				interrupts = <31>;
 				clocks = <&clks IMX5_CLK_UART1_IPG_GATE>,
-				         <&clks IMX5_CLK_UART1_PER_GATE>;
+					 <&clks IMX5_CLK_UART1_PER_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -328,7 +328,7 @@
 				reg = <0x53fc0000 0x4000>;
 				interrupts = <32>;
 				clocks = <&clks IMX5_CLK_UART2_IPG_GATE>,
-				         <&clks IMX5_CLK_UART2_PER_GATE>;
+					 <&clks IMX5_CLK_UART2_PER_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -383,7 +383,7 @@
 				reg = <0x53ff0000 0x4000>;
 				interrupts = <13>;
 				clocks = <&clks IMX5_CLK_UART4_IPG_GATE>,
-				         <&clks IMX5_CLK_UART4_PER_GATE>;
+					 <&clks IMX5_CLK_UART4_PER_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -401,7 +401,7 @@
 				reg = <0x63f90000 0x4000>;
 				interrupts = <86>;
 				clocks = <&clks IMX5_CLK_UART5_IPG_GATE>,
-				         <&clks IMX5_CLK_UART5_PER_GATE>;
+					 <&clks IMX5_CLK_UART5_PER_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -420,7 +420,7 @@
 				reg = <0x63fac000 0x4000>;
 				interrupts = <37>;
 				clocks = <&clks IMX5_CLK_ECSPI2_IPG_GATE>,
-				         <&clks IMX5_CLK_ECSPI2_PER_GATE>;
+					 <&clks IMX5_CLK_ECSPI2_PER_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -430,7 +430,7 @@
 				reg = <0x63fb0000 0x4000>;
 				interrupts = <6>;
 				clocks = <&clks IMX5_CLK_SDMA_GATE>,
-				         <&clks IMX5_CLK_SDMA_GATE>;
+					 <&clks IMX5_CLK_SDMA_GATE>;
 				clock-names = "ipg", "ahb";
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx50.bin";
 			};
@@ -442,7 +442,7 @@
 				reg = <0x63fc0000 0x4000>;
 				interrupts = <38>;
 				clocks = <&clks IMX5_CLK_CSPI_IPG_GATE>,
-				         <&clks IMX5_CLK_CSPI_IPG_GATE>;
+					 <&clks IMX5_CLK_CSPI_IPG_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -492,8 +492,8 @@
 				reg = <0x63fec000 0x4000>;
 				interrupts = <87>;
 				clocks = <&clks IMX5_CLK_FEC_GATE>,
-				         <&clks IMX5_CLK_FEC_GATE>,
-				         <&clks IMX5_CLK_FEC_GATE>;
+					 <&clks IMX5_CLK_FEC_GATE>,
+					 <&clks IMX5_CLK_FEC_GATE>;
 				clock-names = "ipg", "ahb", "ptp";
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index f46fe9b..d8efdab 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -130,8 +130,8 @@
 			reg = <0x40000000 0x20000000>;
 			interrupts = <11 10>;
 			clocks = <&clks IMX5_CLK_IPU_GATE>,
-			         <&clks IMX5_CLK_IPU_DI0_GATE>,
-			         <&clks IMX5_CLK_IPU_DI1_GATE>;
+				 <&clks IMX5_CLK_IPU_DI0_GATE>,
+				 <&clks IMX5_CLK_IPU_DI1_GATE>;
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 2>;
 
@@ -169,8 +169,8 @@
 					reg = <0x70004000 0x4000>;
 					interrupts = <1>;
 					clocks = <&clks IMX5_CLK_ESDHC1_IPG_GATE>,
-					         <&clks IMX5_CLK_DUMMY>,
-					         <&clks IMX5_CLK_ESDHC1_PER_GATE>;
+						 <&clks IMX5_CLK_DUMMY>,
+						 <&clks IMX5_CLK_ESDHC1_PER_GATE>;
 					clock-names = "ipg", "ahb", "per";
 					status = "disabled";
 				};
@@ -180,8 +180,8 @@
 					reg = <0x70008000 0x4000>;
 					interrupts = <2>;
 					clocks = <&clks IMX5_CLK_ESDHC2_IPG_GATE>,
-					         <&clks IMX5_CLK_DUMMY>,
-					         <&clks IMX5_CLK_ESDHC2_PER_GATE>;
+						 <&clks IMX5_CLK_DUMMY>,
+						 <&clks IMX5_CLK_ESDHC2_PER_GATE>;
 					clock-names = "ipg", "ahb", "per";
 					bus-width = <4>;
 					status = "disabled";
@@ -192,7 +192,7 @@
 					reg = <0x7000c000 0x4000>;
 					interrupts = <33>;
 					clocks = <&clks IMX5_CLK_UART3_IPG_GATE>,
-					         <&clks IMX5_CLK_UART3_PER_GATE>;
+						 <&clks IMX5_CLK_UART3_PER_GATE>;
 					clock-names = "ipg", "per";
 					status = "disabled";
 				};
@@ -204,7 +204,7 @@
 					reg = <0x70010000 0x4000>;
 					interrupts = <36>;
 					clocks = <&clks IMX5_CLK_ECSPI1_IPG_GATE>,
-					         <&clks IMX5_CLK_ECSPI1_PER_GATE>;
+						 <&clks IMX5_CLK_ECSPI1_PER_GATE>;
 					clock-names = "ipg", "per";
 					status = "disabled";
 				};
@@ -229,8 +229,8 @@
 					reg = <0x70020000 0x4000>;
 					interrupts = <3>;
 					clocks = <&clks IMX5_CLK_ESDHC3_IPG_GATE>,
-					         <&clks IMX5_CLK_DUMMY>,
-					         <&clks IMX5_CLK_ESDHC3_PER_GATE>;
+						 <&clks IMX5_CLK_DUMMY>,
+						 <&clks IMX5_CLK_ESDHC3_PER_GATE>;
 					clock-names = "ipg", "ahb", "per";
 					bus-width = <4>;
 					status = "disabled";
@@ -241,8 +241,8 @@
 					reg = <0x70024000 0x4000>;
 					interrupts = <4>;
 					clocks = <&clks IMX5_CLK_ESDHC4_IPG_GATE>,
-					         <&clks IMX5_CLK_DUMMY>,
-					         <&clks IMX5_CLK_ESDHC4_PER_GATE>;
+						 <&clks IMX5_CLK_DUMMY>,
+						 <&clks IMX5_CLK_ESDHC4_PER_GATE>;
 					clock-names = "ipg", "ahb", "per";
 					bus-width = <4>;
 					status = "disabled";
@@ -364,7 +364,7 @@
 				reg = <0x73fa0000 0x4000>;
 				interrupts = <39>;
 				clocks = <&clks IMX5_CLK_GPT_IPG_GATE>,
-				         <&clks IMX5_CLK_GPT_HF_GATE>;
+					 <&clks IMX5_CLK_GPT_HF_GATE>;
 				clock-names = "ipg", "per";
 			};
 
@@ -378,7 +378,7 @@
 				compatible = "fsl,imx51-pwm", "fsl,imx27-pwm";
 				reg = <0x73fb4000 0x4000>;
 				clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
-				         <&clks IMX5_CLK_PWM1_HF_GATE>;
+					 <&clks IMX5_CLK_PWM1_HF_GATE>;
 				clock-names = "ipg", "per";
 				interrupts = <61>;
 			};
@@ -388,7 +388,7 @@
 				compatible = "fsl,imx51-pwm", "fsl,imx27-pwm";
 				reg = <0x73fb8000 0x4000>;
 				clocks = <&clks IMX5_CLK_PWM2_IPG_GATE>,
-				         <&clks IMX5_CLK_PWM2_HF_GATE>;
+					 <&clks IMX5_CLK_PWM2_HF_GATE>;
 				clock-names = "ipg", "per";
 				interrupts = <94>;
 			};
@@ -398,7 +398,7 @@
 				reg = <0x73fbc000 0x4000>;
 				interrupts = <31>;
 				clocks = <&clks IMX5_CLK_UART1_IPG_GATE>,
-				         <&clks IMX5_CLK_UART1_PER_GATE>;
+					 <&clks IMX5_CLK_UART1_PER_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -408,7 +408,7 @@
 				reg = <0x73fc0000 0x4000>;
 				interrupts = <32>;
 				clocks = <&clks IMX5_CLK_UART2_IPG_GATE>,
-				         <&clks IMX5_CLK_UART2_PER_GATE>;
+					 <&clks IMX5_CLK_UART2_PER_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -456,7 +456,7 @@
 				reg = <0x83fac000 0x4000>;
 				interrupts = <37>;
 				clocks = <&clks IMX5_CLK_ECSPI2_IPG_GATE>,
-				         <&clks IMX5_CLK_ECSPI2_PER_GATE>;
+					 <&clks IMX5_CLK_ECSPI2_PER_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -466,7 +466,7 @@
 				reg = <0x83fb0000 0x4000>;
 				interrupts = <6>;
 				clocks = <&clks IMX5_CLK_SDMA_GATE>,
-				         <&clks IMX5_CLK_SDMA_GATE>;
+					 <&clks IMX5_CLK_SDMA_GATE>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx51.bin";
@@ -479,7 +479,7 @@
 				reg = <0x83fc0000 0x4000>;
 				interrupts = <38>;
 				clocks = <&clks IMX5_CLK_CSPI_IPG_GATE>,
-				         <&clks IMX5_CLK_CSPI_IPG_GATE>;
+					 <&clks IMX5_CLK_CSPI_IPG_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -582,8 +582,8 @@
 				reg = <0x83fec000 0x4000>;
 				interrupts = <87>;
 				clocks = <&clks IMX5_CLK_FEC_GATE>,
-				         <&clks IMX5_CLK_FEC_GATE>,
-				         <&clks IMX5_CLK_FEC_GATE>;
+					 <&clks IMX5_CLK_FEC_GATE>,
+					 <&clks IMX5_CLK_FEC_GATE>;
 				clock-names = "ipg", "ahb", "ptp";
 				status = "disabled";
 			};
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 0777b41..88f9e09e 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -131,8 +131,8 @@
 			reg = <0x18000000 0x08000000>;
 			interrupts = <11 10>;
 			clocks = <&clks IMX5_CLK_IPU_GATE>,
-			         <&clks IMX5_CLK_IPU_DI0_GATE>,
-			         <&clks IMX5_CLK_IPU_DI1_GATE>;
+				 <&clks IMX5_CLK_IPU_DI0_GATE>,
+				 <&clks IMX5_CLK_IPU_DI1_GATE>;
 			clock-names = "bus", "di0", "di1";
 			resets = <&src 2>;
 
@@ -199,8 +199,8 @@
 					reg = <0x50004000 0x4000>;
 					interrupts = <1>;
 					clocks = <&clks IMX5_CLK_ESDHC1_IPG_GATE>,
-					         <&clks IMX5_CLK_DUMMY>,
-					         <&clks IMX5_CLK_ESDHC1_PER_GATE>;
+						 <&clks IMX5_CLK_DUMMY>,
+						 <&clks IMX5_CLK_ESDHC1_PER_GATE>;
 					clock-names = "ipg", "ahb", "per";
 					bus-width = <4>;
 					status = "disabled";
@@ -211,8 +211,8 @@
 					reg = <0x50008000 0x4000>;
 					interrupts = <2>;
 					clocks = <&clks IMX5_CLK_ESDHC2_IPG_GATE>,
-					         <&clks IMX5_CLK_DUMMY>,
-					         <&clks IMX5_CLK_ESDHC2_PER_GATE>;
+						 <&clks IMX5_CLK_DUMMY>,
+						 <&clks IMX5_CLK_ESDHC2_PER_GATE>;
 					clock-names = "ipg", "ahb", "per";
 					bus-width = <4>;
 					status = "disabled";
@@ -223,7 +223,7 @@
 					reg = <0x5000c000 0x4000>;
 					interrupts = <33>;
 					clocks = <&clks IMX5_CLK_UART3_IPG_GATE>,
-					         <&clks IMX5_CLK_UART3_PER_GATE>;
+						 <&clks IMX5_CLK_UART3_PER_GATE>;
 					clock-names = "ipg", "per";
 					dmas = <&sdma 42 4 0>, <&sdma 43 4 0>;
 					dma-names = "rx", "tx";
@@ -237,7 +237,7 @@
 					reg = <0x50010000 0x4000>;
 					interrupts = <36>;
 					clocks = <&clks IMX5_CLK_ECSPI1_IPG_GATE>,
-					         <&clks IMX5_CLK_ECSPI1_PER_GATE>;
+						 <&clks IMX5_CLK_ECSPI1_PER_GATE>;
 					clock-names = "ipg", "per";
 					status = "disabled";
 				};
@@ -264,8 +264,8 @@
 					reg = <0x50020000 0x4000>;
 					interrupts = <3>;
 					clocks = <&clks IMX5_CLK_ESDHC3_IPG_GATE>,
-					         <&clks IMX5_CLK_DUMMY>,
-					         <&clks IMX5_CLK_ESDHC3_PER_GATE>;
+						 <&clks IMX5_CLK_DUMMY>,
+						 <&clks IMX5_CLK_ESDHC3_PER_GATE>;
 					clock-names = "ipg", "ahb", "per";
 					bus-width = <4>;
 					status = "disabled";
@@ -276,8 +276,8 @@
 					reg = <0x50024000 0x4000>;
 					interrupts = <4>;
 					clocks = <&clks IMX5_CLK_ESDHC4_IPG_GATE>,
-					         <&clks IMX5_CLK_DUMMY>,
-					         <&clks IMX5_CLK_ESDHC4_PER_GATE>;
+						 <&clks IMX5_CLK_DUMMY>,
+						 <&clks IMX5_CLK_ESDHC4_PER_GATE>;
 					clock-names = "ipg", "ahb", "per";
 					bus-width = <4>;
 					status = "disabled";
@@ -419,7 +419,7 @@
 				reg = <0x53fa0000 0x4000>;
 				interrupts = <39>;
 				clocks = <&clks IMX5_CLK_GPT_IPG_GATE>,
-				         <&clks IMX5_CLK_GPT_HF_GATE>;
+					 <&clks IMX5_CLK_GPT_HF_GATE>;
 				clock-names = "ipg", "per";
 			};
 
@@ -440,11 +440,11 @@
 				reg = <0x53fa8008 0x4>;
 				gpr = <&gpr>;
 				clocks = <&clks IMX5_CLK_LDB_DI0_SEL>,
-				         <&clks IMX5_CLK_LDB_DI1_SEL>,
-				         <&clks IMX5_CLK_IPU_DI0_SEL>,
-				         <&clks IMX5_CLK_IPU_DI1_SEL>,
-				         <&clks IMX5_CLK_LDB_DI0_GATE>,
-				         <&clks IMX5_CLK_LDB_DI1_GATE>;
+					 <&clks IMX5_CLK_LDB_DI1_SEL>,
+					 <&clks IMX5_CLK_IPU_DI0_SEL>,
+					 <&clks IMX5_CLK_IPU_DI1_SEL>,
+					 <&clks IMX5_CLK_LDB_DI0_GATE>,
+					 <&clks IMX5_CLK_LDB_DI1_GATE>;
 				clock-names = "di0_pll", "di1_pll",
 					      "di0_sel", "di1_sel",
 					      "di0", "di1";
@@ -486,7 +486,7 @@
 				compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
 				reg = <0x53fb4000 0x4000>;
 				clocks = <&clks IMX5_CLK_PWM1_IPG_GATE>,
-				         <&clks IMX5_CLK_PWM1_HF_GATE>;
+					 <&clks IMX5_CLK_PWM1_HF_GATE>;
 				clock-names = "ipg", "per";
 				interrupts = <61>;
 			};
@@ -496,7 +496,7 @@
 				compatible = "fsl,imx53-pwm", "fsl,imx27-pwm";
 				reg = <0x53fb8000 0x4000>;
 				clocks = <&clks IMX5_CLK_PWM2_IPG_GATE>,
-				         <&clks IMX5_CLK_PWM2_HF_GATE>;
+					 <&clks IMX5_CLK_PWM2_HF_GATE>;
 				clock-names = "ipg", "per";
 				interrupts = <94>;
 			};
@@ -506,7 +506,7 @@
 				reg = <0x53fbc000 0x4000>;
 				interrupts = <31>;
 				clocks = <&clks IMX5_CLK_UART1_IPG_GATE>,
-				         <&clks IMX5_CLK_UART1_PER_GATE>;
+					 <&clks IMX5_CLK_UART1_PER_GATE>;
 				clock-names = "ipg", "per";
 				dmas = <&sdma 18 4 0>, <&sdma 19 4 0>;
 				dma-names = "rx", "tx";
@@ -518,7 +518,7 @@
 				reg = <0x53fc0000 0x4000>;
 				interrupts = <32>;
 				clocks = <&clks IMX5_CLK_UART2_IPG_GATE>,
-				         <&clks IMX5_CLK_UART2_PER_GATE>;
+					 <&clks IMX5_CLK_UART2_PER_GATE>;
 				clock-names = "ipg", "per";
 				dmas = <&sdma 12 4 0>, <&sdma 13 4 0>;
 				dma-names = "rx", "tx";
@@ -530,7 +530,7 @@
 				reg = <0x53fc8000 0x4000>;
 				interrupts = <82>;
 				clocks = <&clks IMX5_CLK_CAN1_IPG_GATE>,
-				         <&clks IMX5_CLK_CAN1_SERIAL_GATE>;
+					 <&clks IMX5_CLK_CAN1_SERIAL_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -540,7 +540,7 @@
 				reg = <0x53fcc000 0x4000>;
 				interrupts = <83>;
 				clocks = <&clks IMX5_CLK_CAN2_IPG_GATE>,
-				         <&clks IMX5_CLK_CAN2_SERIAL_GATE>;
+					 <&clks IMX5_CLK_CAN2_SERIAL_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -603,7 +603,7 @@
 				reg = <0x53ff0000 0x4000>;
 				interrupts = <13>;
 				clocks = <&clks IMX5_CLK_UART4_IPG_GATE>,
-				         <&clks IMX5_CLK_UART4_PER_GATE>;
+					 <&clks IMX5_CLK_UART4_PER_GATE>;
 				clock-names = "ipg", "per";
 				dmas = <&sdma 2 4 0>, <&sdma 3 4 0>;
 				dma-names = "rx", "tx";
@@ -635,7 +635,7 @@
 				reg = <0x63f90000 0x4000>;
 				interrupts = <86>;
 				clocks = <&clks IMX5_CLK_UART5_IPG_GATE>,
-				         <&clks IMX5_CLK_UART5_PER_GATE>;
+					 <&clks IMX5_CLK_UART5_PER_GATE>;
 				clock-names = "ipg", "per";
 				dmas = <&sdma 16 4 0>, <&sdma 17 4 0>;
 				dma-names = "rx", "tx";
@@ -656,7 +656,7 @@
 				reg = <0x63fac000 0x4000>;
 				interrupts = <37>;
 				clocks = <&clks IMX5_CLK_ECSPI2_IPG_GATE>,
-				         <&clks IMX5_CLK_ECSPI2_PER_GATE>;
+					 <&clks IMX5_CLK_ECSPI2_PER_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -666,7 +666,7 @@
 				reg = <0x63fb0000 0x4000>;
 				interrupts = <6>;
 				clocks = <&clks IMX5_CLK_SDMA_GATE>,
-				         <&clks IMX5_CLK_SDMA_GATE>;
+					 <&clks IMX5_CLK_SDMA_GATE>;
 				clock-names = "ipg", "ahb";
 				#dma-cells = <3>;
 				fsl,sdma-ram-script-name = "imx/sdma/sdma-imx53.bin";
@@ -679,7 +679,7 @@
 				reg = <0x63fc0000 0x4000>;
 				interrupts = <38>;
 				clocks = <&clks IMX5_CLK_CSPI_IPG_GATE>,
-				         <&clks IMX5_CLK_CSPI_IPG_GATE>;
+					 <&clks IMX5_CLK_CSPI_IPG_GATE>;
 				clock-names = "ipg", "per";
 				status = "disabled";
 			};
@@ -755,8 +755,8 @@
 				reg = <0x63fec000 0x4000>;
 				interrupts = <87>;
 				clocks = <&clks IMX5_CLK_FEC_GATE>,
-				         <&clks IMX5_CLK_FEC_GATE>,
-				         <&clks IMX5_CLK_FEC_GATE>;
+					 <&clks IMX5_CLK_FEC_GATE>,
+					 <&clks IMX5_CLK_FEC_GATE>;
 				clock-names = "ipg", "ahb", "ptp";
 				status = "disabled";
 			};
@@ -766,7 +766,7 @@
 				reg = <0x63ff0000 0x1000>;
 				interrupts = <92>;
 				clocks = <&clks IMX5_CLK_TVE_GATE>,
-				         <&clks IMX5_CLK_IPU_DI1_SEL>;
+					 <&clks IMX5_CLK_IPU_DI1_SEL>;
 				clock-names = "tve", "di_sel";
 				status = "disabled";
 
@@ -782,7 +782,7 @@
 				reg = <0x63ff4000 0x1000>;
 				interrupts = <9>;
 				clocks = <&clks IMX5_CLK_VPU_REFERENCE_GATE>,
-				         <&clks IMX5_CLK_VPU_GATE>;
+					 <&clks IMX5_CLK_VPU_GATE>;
 				clock-names = "per", "ahb";
 				resets = <&src 1>;
 				iram = <&ocram>;
@@ -793,7 +793,7 @@
 				reg = <0x63ff8000 0x4000>;
 				interrupts = <19 20>;
 				clocks = <&clks IMX5_CLK_SAHARA_IPG_GATE>,
-				         <&clks IMX5_CLK_SAHARA_IPG_GATE>;
+					 <&clks IMX5_CLK_SAHARA_IPG_GATE>;
 				clock-names = "ipg", "ahb";
 			};
 		};
diff --git a/arch/arm/boot/dts/imx6dl-riotboard.dts b/arch/arm/boot/dts/imx6dl-riotboard.dts
index 75d7343..2cb7282 100644
--- a/arch/arm/boot/dts/imx6dl-riotboard.dts
+++ b/arch/arm/boot/dts/imx6dl-riotboard.dts
@@ -390,7 +390,7 @@
 				MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b030		/* AR8035 pin strapping: MODE#3: pull up */
 				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x130b0		/* AR8035 pin strapping: MODE#0: pull down */
 				MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8	/* GPIO16 -> AR8035 25MHz */
-			        MX6QDL_PAD_EIM_D31__GPIO3_IO31		0x130b0		/* RGMII_nRST */
+				MX6QDL_PAD_EIM_D31__GPIO3_IO31		0x130b0		/* RGMII_nRST */
 				MX6QDL_PAD_ENET_TX_EN__GPIO1_IO28	0x180b0		/* AR8035 interrupt */
 				MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
 			>;
diff --git a/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts b/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts
index 063fe75..aac42ac 100644
--- a/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6dl-comtft.dts
@@ -105,7 +105,7 @@
 				pixelclk-active = <1>;
 			};
 		};
-        };
+	};
 };
 
 &can1 {
diff --git a/arch/arm/boot/dts/imx6dl-tx6u-801x.dts b/arch/arm/boot/dts/imx6dl-tx6u-801x.dts
index b7a7284..d1f1298 100644
--- a/arch/arm/boot/dts/imx6dl-tx6u-801x.dts
+++ b/arch/arm/boot/dts/imx6dl-tx6u-801x.dts
@@ -199,7 +199,7 @@
 				pixelclk-active = <0>;
 			};
 		};
-        };
+	};
 };
 
 &ipu1_di0_disp0 {
diff --git a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
index c139ac0..1f47713 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
@@ -23,5 +23,5 @@
 };
 
 &sata {
-        status = "okay";
+	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts b/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
index 65e95ae..71746ed 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1010-comtft.dts
@@ -105,7 +105,7 @@
 				pixelclk-active = <1>;
 			};
 		};
-        };
+	};
 };
 
 &can1 {
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1010.dts b/arch/arm/boot/dts/imx6q-tx6q-1010.dts
index 20cd0e7..f9cd21a 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1010.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1010.dts
@@ -199,7 +199,7 @@
 				pixelclk-active = <0>;
 			};
 		};
-        };
+	};
 };
 
 &ipu1_di0_disp0 {
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts b/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
index 9ed243b..959ff3fb 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1020-comtft.dts
@@ -105,7 +105,7 @@
 				pixelclk-active = <1>;
 			};
 		};
-        };
+	};
 };
 
 &can1 {
diff --git a/arch/arm/boot/dts/imx6q-tx6q-1020.dts b/arch/arm/boot/dts/imx6q-tx6q-1020.dts
index 347b531..b49133d 100644
--- a/arch/arm/boot/dts/imx6q-tx6q-1020.dts
+++ b/arch/arm/boot/dts/imx6q-tx6q-1020.dts
@@ -199,7 +199,7 @@
 				pixelclk-active = <0>;
 			};
 		};
-        };
+	};
 };
 
 &ds1339 {
diff --git a/arch/arm/boot/dts/imx6sx-sdb.dtsi b/arch/arm/boot/dts/imx6sx-sdb.dtsi
index 9d70cfd..7327bcd 100644
--- a/arch/arm/boot/dts/imx6sx-sdb.dtsi
+++ b/arch/arm/boot/dts/imx6sx-sdb.dtsi
@@ -192,10 +192,10 @@
 };
 
 &i2c4 {
-        clock-frequency = <100000>;
-        pinctrl-names = "default";
-        pinctrl-0 = <&pinctrl_i2c4>;
-        status = "okay";
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c4>;
+	status = "okay";
 
 	codec: wm8962 at 1a {
 		compatible = "wlf,wm8962";
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 9526c38..bd9fe67 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -858,7 +858,7 @@
 				fsl,num-tx-queues=<3>;
 				fsl,num-rx-queues=<3>;
 				status = "disabled";
-                        };
+			};
 
 			mlb: mlb at 0218c000 {
 				reg = <0x0218c000 0x4000>;
@@ -1181,7 +1181,7 @@
 				fsl,adck-max-frequency = <30000000>, <40000000>,
 							 <20000000>;
 				status = "disabled";
-                        };
+			};
 
 			adc2: adc at 02284000 {
 				compatible = "fsl,imx6sx-adc", "fsl,vf610-adc";
@@ -1192,7 +1192,7 @@
 				fsl,adck-max-frequency = <30000000>, <40000000>,
 							 <20000000>;
 				status = "disabled";
-                        };
+			};
 
 			wdog3: wdog at 02288000 {
 				compatible = "fsl,imx6sx-wdt", "fsl,imx21-wdt";
-- 
2.7.4
