From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 17 Jan 2015 09:58:39 +0900
Subject: [PATCH 06/11] ARM: shmobile: r8a7791: add SRC interrupt number on DTSI
In-Reply-To: <cover.1421380713.git.horms+renesas@verge.net.au>
References: <cover.1421380713.git.horms+renesas@verge.net.au>
Message-ID: <8856102dd30897e608331521f4286163700c4d59.1421380713.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 946cd3a..e3a60a2 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1420,16 +1420,16 @@
 		};
 
 		rcar_sound,src {
-			src0: src at 0 { };
-			src1: src at 1 { };
-			src2: src at 2 { };
-			src3: src at 3 { };
-			src4: src at 4 { };
-			src5: src at 5 { };
-			src6: src at 6 { };
-			src7: src at 7 { };
-			src8: src at 8 { };
-			src9: src at 9 { };
+			src0: src at 0 { interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>; };
+			src1: src at 1 { interrupts = <0 353 IRQ_TYPE_LEVEL_HIGH>; };
+			src2: src at 2 { interrupts = <0 354 IRQ_TYPE_LEVEL_HIGH>; };
+			src3: src at 3 { interrupts = <0 355 IRQ_TYPE_LEVEL_HIGH>; };
+			src4: src at 4 { interrupts = <0 356 IRQ_TYPE_LEVEL_HIGH>; };
+			src5: src at 5 { interrupts = <0 357 IRQ_TYPE_LEVEL_HIGH>; };
+			src6: src at 6 { interrupts = <0 358 IRQ_TYPE_LEVEL_HIGH>; };
+			src7: src at 7 { interrupts = <0 359 IRQ_TYPE_LEVEL_HIGH>; };
+			src8: src at 8 { interrupts = <0 360 IRQ_TYPE_LEVEL_HIGH>; };
+			src9: src at 9 { interrupts = <0 361 IRQ_TYPE_LEVEL_HIGH>; };
 		};
 
 		rcar_sound,ssi {
-- 
2.1.4
