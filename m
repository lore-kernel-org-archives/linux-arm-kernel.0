From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 25 May 2016 10:11:40 +0900
Subject: [PATCH] rm64: dts: r8a7795: Drop 0x from unit address of gic
Message-ID: <1464138700-12219-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Drop 0x from unit address of gic as this is the desired form for
a unit address.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
As suggested by Geert Uytterhoeven
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index a4f4ec8daa21..04eb0bc65634 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -153,7 +153,7 @@
 		#size-cells = <2>;
 		ranges;
 
-		gic: interrupt-controller at 0xf1010000 {
+		gic: interrupt-controller at f1010000 {
 			compatible = "arm,gic-400";
 			#interrupt-cells = <3>;
 			#address-cells = <0>;
-- 
2.1.4
