From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  6 Mar 2017 13:18:36 -0300
Subject: [PATCH] ARM: dts: imx6sx: Make UART compatible to 'imx6q-uart'
Message-ID: <1488817116-6079-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

UART on i.MX6SX (like all other i.MX6 SoC variants) has the same
programming model as the 'imx6q-uart' type, so add it to the compatible
UART string.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index dd4ec85..f58d7f5 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -297,7 +297,8 @@
 				};
 
 				uart1: serial at 02020000 {
-					compatible = "fsl,imx6sx-uart", "fsl,imx21-uart";
+					compatible = "fsl,imx6sx-uart",
+						     "fsl,imx6q-uart", "fsl,imx21-uart";
 					reg = <0x02020000 0x4000>;
 					interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>;
 					clocks = <&clks IMX6SX_CLK_UART_IPG>,
@@ -1053,7 +1054,8 @@
 			};
 
 			uart2: serial at 021e8000 {
-				compatible = "fsl,imx6sx-uart", "fsl,imx21-uart";
+				compatible = "fsl,imx6sx-uart",
+					     "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021e8000 0x4000>;
 				interrupts = <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_UART_IPG>,
@@ -1065,7 +1067,8 @@
 			};
 
 			uart3: serial at 021ec000 {
-				compatible = "fsl,imx6sx-uart", "fsl,imx21-uart";
+				compatible = "fsl,imx6sx-uart",
+					     "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021ec000 0x4000>;
 				interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_UART_IPG>,
@@ -1077,7 +1080,8 @@
 			};
 
 			uart4: serial at 021f0000 {
-				compatible = "fsl,imx6sx-uart", "fsl,imx21-uart";
+				compatible = "fsl,imx6sx-uart",
+					     "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021f0000 0x4000>;
 				interrupts = <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_UART_IPG>,
@@ -1089,7 +1093,8 @@
 			};
 
 			uart5: serial at 021f4000 {
-				compatible = "fsl,imx6sx-uart", "fsl,imx21-uart";
+				compatible = "fsl,imx6sx-uart",
+					     "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x021f4000 0x4000>;
 				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_UART_IPG>,
@@ -1229,7 +1234,8 @@
 			};
 
 			uart6: serial at 022a0000 {
-				compatible = "fsl,imx6sx-uart", "fsl,imx21-uart";
+				compatible = "fsl,imx6sx-uart",
+					     "fsl,imx6q-uart", "fsl,imx21-uart";
 				reg = <0x022a0000 0x4000>;
 				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6SX_CLK_UART_IPG>,
-- 
2.7.4
