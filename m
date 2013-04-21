From: marex@denx.de (Marek Vasut)
Date: Sun, 21 Apr 2013 23:30:04 +0200
Subject: [PATCH 4/8] ARM: mx5: Add I2C2 pinctrl data
In-Reply-To: <1366579808-12067-1-git-send-email-marex@denx.de>
References: <1366579808-12067-1-git-send-email-marex@denx.de>
Message-ID: <1366579808-12067-4-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds pinctrl data for different mux of I2C2 on MX53.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx53.dtsi |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 1f6868d..09145e2 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -487,6 +487,13 @@
 							MX53_PAD_KEY_COL3__I2C2_SCL 0xc0000000
 						>;
 					};
+
+					pinctrl_i2c2_2: i2c2grp-2 {
+						fsl,pins = <
+							MX53_PAD_EIM_D16__I2C2_SDA	0xc0000000
+							MX53_PAD_EIM_EB2__I2C2_SCL	0xc0000000
+						>;
+					};
 				};
 
 				i2c3 {
-- 
1.7.10.4
