From: jonas@microbit.se (Jonas Andersson)
Date: Mon, 27 May 2013 10:52:45 +0200
Subject: [PATCH] ARM: dts: imx53: add ecspi2 pinctrl
Message-ID: <1369644765-17189-1-git-send-email-jonas@microbit.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ecspi2 pinctrl.

Signed-off-by: Jonas Andersson <jonas@microbit.se>
---
 arch/arm/boot/dts/imx53.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 024616c..dd59ace 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -342,6 +342,16 @@
 					};
 				};
 
+				ecspi2 {
+					pinctrl_ecspi2_1: ecspi2grp-1 {
+						fsl,pins = <
+							MX53_PAD_EIM_OE__ECSPI2_MISO  0x80000000
+							MX53_PAD_EIM_CS1__ECSPI2_MOSI 0x80000000
+							MX53_PAD_EIM_CS0__ECSPI2_SCLK 0x80000000
+						>;
+					};
+				};
+
 				esdhc1 {
 					pinctrl_esdhc1_1: esdhc1grp-1 {
 						fsl,pins = <
-- 
1.8.1.4
