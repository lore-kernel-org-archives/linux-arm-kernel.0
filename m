From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  8 Feb 2013 13:36:41 -0200
Subject: [PATCH 1/3] ARM: dts: imx28-evk: Enable touchscreen support
Message-ID: <1360337803-19858-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Provide 'lradc-touchscreen-wires' property to the LRADC driver, so that 
touchscreen can be functional.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 2da316e..5960578 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -155,6 +155,7 @@
 			};
 
 			lradc at 80050000 {
+				fsl,lradc-touchscreen-wires = <4>;
 				status = "okay";
 			};
 
-- 
1.7.9.5
