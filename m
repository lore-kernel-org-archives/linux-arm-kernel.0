From: marex@denx.de (Marek Vasut)
Date: Sat,  9 Jun 2012 01:21:55 +0200
Subject: [PATCH] MXS: Fix the gpmi/gpmi-nand DT name
Message-ID: <1339197715-19721-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace "gpmi" with "gpmi-nand" to get the
GPMI interface probing with DT instead of
failing to get clock.

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Detlev Zundel <dzu@denx.de>
CC: Dong Aisheng <b29396@freescale.com>
CC: Fabio Estevam <fabio.estevam@freescale.com>
Cc: Linux ARM kernel <linux-arm-kernel@lists.infradead.org>
CC: Shawn Guo <shawn.guo@linaro.org>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Wolfgang Denk <wd@denx.de>
---
 arch/arm/boot/dts/imx23.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 8c5f999..0af43c0 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -62,7 +62,7 @@
 				status = "disabled";
 			};
 
-			gpmi at 8000c000 {
+			gpmi-nand at 8000c000 {
 				reg = <0x8000c000 2000>;
 				status = "disabled";
 			};
-- 
1.7.10
