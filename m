From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 28 Apr 2015 09:10:07 +0800
Subject: [PATCH] ARM: dts: imx6qdl-sabreauto: remove pinctrl-assert-gpios
Message-ID: <1430183407-24318-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pinctrl-assert-gpios is an invalid pinctrl property.  It was
probably sneaked from vendor tree.  Remove it.

Fixes: 4e18a2243a87 ("ARM: imx6qdl-sabreauto.dtsi: add max7310 support")
Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 46b2fed7c319..3b24b12651b2 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -185,7 +185,6 @@
 &i2c3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_i2c3>;
-	pinctrl-assert-gpios = <&gpio5 4 GPIO_ACTIVE_HIGH>;
 	status = "okay";
 
 	max7310_a: gpio at 30 {
-- 
1.9.1
