From: marex@denx.de (Marek Vasut)
Date: Sat, 23 Jun 2012 20:45:18 +0200
Subject: [PATCH] ARM: mx28: Add LCD pinmux
Message-ID: <1340477119-2835-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Detlev Zundel <dzu@denx.de>
CC: Dong Aisheng <b29396@freescale.com>
CC: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
CC: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
---
 arch/arm/boot/dts/imx28.dtsi |   45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 464303c..ab29cbe 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -221,6 +221,51 @@
 					fsl,pull-up = <0>;
 				};
 
+				lcd_data_pins_8bpp_a: lcd at 0 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x1000 0x1010 0x1020 0x1030
+						0x1040 0x1050 0x1060 0x1070>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				lcd_data_pins_16bpp_a: lcd at 1 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x1000 0x1010 0x1020 0x1030
+						0x1040 0x1050 0x1060 0x1070
+						0x1080 0x1090 0x10a0 0x10b0
+						0x10c0 0x10d0 0x10e0 0x10f0>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				lcd_data_pins_18bpp_a: lcd at 2 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x1000 0x1010 0x1020 0x1030
+						0x1040 0x1050 0x1060 0x1070
+						0x1080 0x1090 0x10a0 0x10b0
+						0x10c0 0x10d0 0x10e0 0x10f0
+						0x1100 0x1110>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
+				lcd_data_pins_24bpp_a: lcd at 3 {
+					reg = <0>;
+					fsl,pinmux-ids = <0x1000 0x1010 0x1020 0x1030
+						0x1040 0x1050 0x1060 0x1070
+						0x1080 0x1090 0x10a0 0x10b0
+						0x10c0 0x10d0 0x10e0 0x10f0
+						0x1100 0x1110 0x1120 0x1130
+						0x1140 0x1150 0x1160 0x1170>;
+					fsl,drive-strength = <0>;
+					fsl,voltage = <1>;
+					fsl,pull-up = <0>;
+				};
+
 				mac0_pins_a: mac0 at 0 {
 					reg = <0>;
 					fsl,pinmux-ids = <0x4000 0x4010 0x4020
-- 
1.7.10
