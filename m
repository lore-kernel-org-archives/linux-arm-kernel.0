From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Sat,  9 Mar 2013 15:04:19 +0100
Subject: [PATCH] ARM: imx51: Add a second pinctrl group for i2c2
Message-ID: <1362837859-5558-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a second pinctrl group of pins for i2c2.

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/boot/dts/imx51.dtsip | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsip b/arch/arm/boot/dts/imx51.dtsip
index 7e09ccf..edc7746 100644
--- a/arch/arm/boot/dts/imx51.dtsip
+++ b/arch/arm/boot/dts/imx51.dtsip
@@ -360,6 +360,13 @@
 							MX51_PAD_KEY_COL5__I2C2_SDA 0x400001ed
 						>;
 					};
+
+					pinctrl_i2c2_2: i2c2grp-2 {
+						fsl,pins = <
+							MX51_PAD_EIM_D27__I2C2_SCL 0x400001ed
+							MX51_PAD_EIM_D24__I2C2_SDA 0x400001ed
+						>;
+					};
 				};
 
 				ipu_disp1 {
-- 
1.8.1.5
