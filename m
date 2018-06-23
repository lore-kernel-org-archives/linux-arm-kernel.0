From: daniel@zonque.org (Daniel Mack)
Date: Sat, 23 Jun 2018 21:37:45 +0200
Subject: [PATCH] ARM: dts: pxa: add label to lcd controller node
Message-ID: <20180623193745.12605-1-daniel@zonque.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So it can be referenced and filled with more details from board files.

Signed-off-by: Daniel Mack <daniel@zonque.org>
---
 arch/arm/boot/dts/pxa2xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index e4ebcde17837..a520b4c14ea9 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -141,7 +141,7 @@
 			interrupts = <30 31>;
 		};
 
-		lcd-controller at 40500000 {
+		lcdc: lcd-controller at 40500000 {
 			compatible = "marvell,pxa2xx-lcdc";
 			reg = <0x44000000 0x10000>;
 			interrupts = <17>;
-- 
2.17.1
