From: mhei@heimpold.de (Michael Heimpold)
Date: Tue,  7 Oct 2014 23:00:39 +0200
Subject: [PATCH] ARM: dts: imx28-evk: remove duplicate property
Message-ID: <1412715639-9565-1-git-send-email-mhei@heimpold.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Seems to be a left-over from an automatic merge.

Signed-off-by: Michael Heimpold <mhei@heimpold.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 09664fc..2944d39 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -182,7 +182,6 @@
 			};
 
 			lradc at 80050000 {
-				fsl,lradc-touchscreen-wires = <4>;
 				status = "okay";
 				fsl,lradc-touchscreen-wires = <4>;
 				fsl,ave-ctrl = <4>;
-- 
1.7.10.4
