From: festevam@gmail.com (Fabio Estevam)
Date: Fri, 24 Jan 2014 18:45:24 -0200
Subject: [PATCH] ARM: dts: imx28-m28cu3: Remove 'reset-active-high'
Message-ID: <1390596324-20904-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The 'reset-active-high' property is not defined anywhere, so just remove it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28-m28cu3.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
index d3958da..4174bb1 100644
--- a/arch/arm/boot/dts/imx28-m28cu3.dts
+++ b/arch/arm/boot/dts/imx28-m28cu3.dts
@@ -116,7 +116,6 @@
 				pinctrl-0 = <&lcdif_24bit_pins_a
 					     &lcdif_pins_m28>;
 				display = <&display>;
-				reset-active-high;
 				status = "okay";
 
 				display: display0 {
-- 
1.8.1.2
