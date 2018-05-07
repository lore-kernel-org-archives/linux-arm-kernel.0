From: festevam@gmail.com (Fabio Estevam)
Date: Sun,  6 May 2018 22:03:39 -0300
Subject: [PATCH 1/2] ARM: dts: imx28-cfa10049: Remove unnecessary
 #address/#size-cells
Message-ID: <1525655020-31260-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Remove unnecessary #address-cells/#size-cells to fix the following
DTC warnings:

arch/arm/boot/dts/imx28-cfa10049.dtb: Warning (avoid_unnecessary_addr_size): /gpio_keys: unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Cc: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx28-cfa10049.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index 60e5c7f..f1c8315 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -398,8 +398,6 @@
 		compatible = "gpio-keys";
 		pinctrl-names = "default";
 		pinctrl-0 = <&rotary_btn_pins_cfa10049>;
-		#address-cells = <1>;
-		#size-cells = <0>;
 
 		rotary_button {
 			label = "rotary_button";
-- 
2.7.4
