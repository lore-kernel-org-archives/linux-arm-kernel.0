From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Sat,  9 Mar 2013 10:06:10 +0100
Subject: [PATCH] ARM: imx51: Add pinctrl for ecspi2
Message-ID: <1362819970-24442-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ecspi2 group of pins for imx51.

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx51.dtsip | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsip b/arch/arm/boot/dts/imx51.dtsip
index 6e14b75..819f710 100644
--- a/arch/arm/boot/dts/imx51.dtsip
+++ b/arch/arm/boot/dts/imx51.dtsip
@@ -317,6 +317,16 @@
 					};
 				};
 
+				ecspi2 {
+					pinctrl_ecspi2_1: ecspi2grp-1 {
+						fsl,pins = <
+							MX51_PAD_NANDF_RB3__ECSPI2_MISO 212 0x185
+							MX51_PAD_NANDF_D15__ECSPI2_MOSI 264 0x185
+							MX51_PAD_NANDF_RB2__ECSPI2_SCLK 205 0x185
+						>;
+					};
+				};
+
 				esdhc1 {
 					pinctrl_esdhc1_1: esdhc1grp-1 {
 						fsl,pins = <
-- 
1.8.1.5
