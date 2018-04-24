From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 24 Apr 2018 17:22:44 -0300
Subject: [PATCH] ARM: dts: imx6q-pistachio: Use 'uart-has-rtscts' property
Message-ID: <1524601364-23342-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

The 'fsl,uart-has-rtscts' property is deprecated and it is recommended
to use the generic 'uart-has-rtscts' property instead.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/boot/dts/imx6q-pistachio.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-pistachio.dts b/arch/arm/boot/dts/imx6q-pistachio.dts
index bd57b3b..a31e83c 100644
--- a/arch/arm/boot/dts/imx6q-pistachio.dts
+++ b/arch/arm/boot/dts/imx6q-pistachio.dts
@@ -614,7 +614,7 @@
 &uart5 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart5>;
-	fsl,uart-has-rtscts;
+	uart-has-rtscts;
 	status = "okay";
 };
 
-- 
2.7.4
