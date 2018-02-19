From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Mon, 19 Feb 2018 11:47:05 +0100
Subject: [PATCH] ARM: dts: imx6dl: remove 'lcdif' node
Message-ID: <1519037225-22872-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to the "i.MX 6Solo/6DualLite Applications Processor
Reference Manual" Rev. 3, 09/2017 there is no LCDIF unit on the
i.MX6DL.

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx6dl.dtsi | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl.dtsi b/arch/arm/boot/dts/imx6dl.dtsi
index c01674f..d9c502a 100644
--- a/arch/arm/boot/dts/imx6dl.dtsi
+++ b/arch/arm/boot/dts/imx6dl.dtsi
@@ -80,11 +80,6 @@
 				reg = <0x020f4000 0x4000>;
 				interrupts = <0 97 IRQ_TYPE_LEVEL_HIGH>;
 			};
-
-			lcdif: lcdif at 20f8000 {
-				reg = <0x020f8000 0x4000>;
-				interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
-			};
 		};
 
 		aips2: aips-bus at 2100000 {
-- 
2.1.4
