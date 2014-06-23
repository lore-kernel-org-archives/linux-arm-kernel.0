From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 23 Jun 2014 11:21:04 -0300
Subject: [PATCH 1/3] ARM: dts: imx6sx: Fix usbmisc compatible string
Message-ID: <1403533266-16021-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix usbmisc compatible string so that usbmisc node can be found and USB 
functionality can be functional.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6sx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index 78ccf61..d3ed62c 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -753,7 +753,7 @@
 
 			usbmisc: usbmisc at 02184800 {
 				#index-cells = <1>;
-				compatible = "fsl,imx6sx-usbmisc";
+				compatible = "fsl,imx6sx-usbmisc", "fsl,imx6q-usbmisc";
 				reg = <0x02184800 0x200>;
 				clocks = <&clks IMX6SX_CLK_USBOH3>;
 			};
-- 
1.8.3.2
