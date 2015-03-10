From: festevam@gmail.com (Fabio Estevam)
Date: Mon,  9 Mar 2015 23:33:22 -0300
Subject: [PATCH] ARM: dts: imx6sl-warp: Pass 'bus-width' property
Message-ID: <1425954802-14206-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

USDHC2 port uses all the 8 data signals, so pass the 'bus-width' property
accordingly.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sl-warp.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6sl-warp.dts b/arch/arm/boot/dts/imx6sl-warp.dts
index 904efc4..8adc843 100644
--- a/arch/arm/boot/dts/imx6sl-warp.dts
+++ b/arch/arm/boot/dts/imx6sl-warp.dts
@@ -122,6 +122,7 @@
 	pinctrl-0 = <&pinctrl_usdhc2>;
 	pinctrl-1 = <&pinctrl_usdhc2_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc2_200mhz>;
+	bus-width = <8>;
 	non-removable;
 	status = "okay";
 };
-- 
1.9.1
