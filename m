From: marex@denx.de (Marek Vasut)
Date: Fri,  6 Jul 2012 08:17:29 +0200
Subject: [PATCH 10/10] ARM: mx28: Add SPI pinmux into imx28.dtsi
In-Reply-To: <1341555449-17507-1-git-send-email-marex@denx.de>
References: <1341555449-17507-1-git-send-email-marex@denx.de>
Message-ID: <1341555449-17507-10-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Chris Ball <cjb@laptop.org>
Cc: Detlev Zundel <dzu@denx.de>
CC: Dong Aisheng <b29396@freescale.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <rob.herring@calxeda.com>
CC: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
---
 arch/arm/boot/dts/imx28.dtsi |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 01625e2..da5ce86 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -339,6 +339,45 @@
 					fsl,voltage = <1>;
 					fsl,pull-up = <1>;
 				};
+
+				spi0_pins_a: spi0 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids =
+						<0x2000 0x2010 0x2020 0x2030
+						0x2040 0x2050 0x2060 0x2070
+						0x2080 0x2090 0x20a0>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
+				spi1_pins_a: spi1 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids =
+						<0x20c0 0x20d0 0x20e0 0x20f0>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
+				spi2_pins_a: spi2 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids =
+						<0x2100 0x2110 0x2120
+						0x2130 0x2140 0x2150>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
+
+				spi3_pins_a: spi3 at 0 {
+					reg = <0>;
+					fsl,pinmux-ids =
+						<0x2180 0x2190 0x21a0 0x21b0>;
+					fsl,drive-strength = <1>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <1>;
+				};
 			};
 
 			digctl at 8001c000 {
-- 
1.7.10
