From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue, 12 Jan 2016 18:21:22 +0100
Subject: [PATCH 05/14] ARM: dts: imx6ul: specify proper clocks for the PWM
 nodes
In-Reply-To: <1452619291-13625-5-git-send-email-LW@KARO-electronics.de>
References: <1452619291-13625-1-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-2-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-3-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-4-git-send-email-LW@KARO-electronics.de>
 <1452619291-13625-5-git-send-email-LW@KARO-electronics.de>
Message-ID: <1452619291-13625-6-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6ul.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index e6e3e54..3aba0bb 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -508,8 +508,8 @@
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x020f0000 0x4000>;
 				interrupts = <GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_DUMMY>,
-					 <&clks IMX6UL_CLK_DUMMY>;
+				clocks = <&clks IMX6UL_CLK_PWM5>,
+					 <&clks IMX6UL_CLK_PWM5>;
 				clock-names = "ipg", "per";
 				#pwm-cells = <2>;
 			};
@@ -518,8 +518,8 @@
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x020f4000 0x4000>;
 				interrupts = <GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_DUMMY>,
-					 <&clks IMX6UL_CLK_DUMMY>;
+				clocks = <&clks IMX6UL_CLK_PWM6>,
+					 <&clks IMX6UL_CLK_PWM6>;
 				clock-names = "ipg", "per";
 				#pwm-cells = <2>;
 			};
@@ -528,8 +528,8 @@
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x020f8000 0x4000>;
 				interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_DUMMY>,
-					 <&clks IMX6UL_CLK_DUMMY>;
+				clocks = <&clks IMX6UL_CLK_PWM7>,
+					 <&clks IMX6UL_CLK_PWM7>;
 				clock-names = "ipg", "per";
 				#pwm-cells = <2>;
 			};
@@ -538,8 +538,8 @@
 				compatible = "fsl,imx6ul-pwm", "fsl,imx27-pwm";
 				reg = <0x020fc000 0x4000>;
 				interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clks IMX6UL_CLK_DUMMY>,
-					 <&clks IMX6UL_CLK_DUMMY>;
+				clocks = <&clks IMX6UL_CLK_PWM8>,
+					 <&clks IMX6UL_CLK_PWM8>;
 				clock-names = "ipg", "per";
 				#pwm-cells = <2>;
 			};
-- 
2.1.4
