From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 26 Sep 2012 09:07:41 -0300
Subject: [PATCH] ARM: dts: imx27-3ds: Remove local watchdog inclusion
Message-ID: <1348661261-7124-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

imx27.dtsi already register the watchdog, so no need to do it in the board dts
file.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx27-3ds.dts |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-3ds.dts b/arch/arm/boot/dts/imx27-3ds.dts
index 0a8978a..b01c0d7 100644
--- a/arch/arm/boot/dts/imx27-3ds.dts
+++ b/arch/arm/boot/dts/imx27-3ds.dts
@@ -23,10 +23,6 @@
 	soc {
 		aipi at 10000000 { /* aipi */
 
-			wdog at 10002000 {
-				status = "okay";
-			};
-
 			uart1: serial at 1000a000 {
 				fsl,uart-has-rtscts;
 				status = "okay";
-- 
1.7.9.5
