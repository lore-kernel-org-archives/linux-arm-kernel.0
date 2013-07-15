From: denis@eukrea.com (Denis Carikli)
Date: Mon, 15 Jul 2013 16:56:56 +0200
Subject: [PATCH 11/22] arm/dts: imx51.dtsi: i2c1 : Add pinctrl configuration.
In-Reply-To: <1373900227-341-1-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
Message-ID: <1373900227-341-12-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
 arch/arm/boot/dts/imx51.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index fb5c2c3..60b2a8e 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -410,6 +410,15 @@
 					};
 				};
 
+				i2c1 {
+					pinctrl_i2c1_1: i2c1grp-1 {
+						fsl,pins = <
+							MX51_PAD_SD2_CMD__I2C1_SCL 0x400001ed
+							MX51_PAD_SD2_CLK__I2C1_SDA 0x400001ed
+						>;
+					};
+				};
+
 				i2c2 {
 					pinctrl_i2c2_1: i2c2grp-1 {
 						fsl,pins = <
-- 
1.7.9.5
