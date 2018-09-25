From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 25 Sep 2018 13:24:08 -0300
Subject: [PATCH] ARM: dts: imx53-ppd: Remove 'num-chipselects' property
Message-ID: <1537892648-30414-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'num-chipselects' property is not a valid property according
to Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt, so
let's remove it.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/imx53-ppd.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx53-ppd.dts b/arch/arm/boot/dts/imx53-ppd.dts
index cdb90be..b560ff8 100644
--- a/arch/arm/boot/dts/imx53-ppd.dts
+++ b/arch/arm/boot/dts/imx53-ppd.dts
@@ -319,7 +319,6 @@
 &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_ecspi2>;
-	num-chipselects = <1>;
 	cs-gpios = <&gpio2 26 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
-- 
2.7.4
