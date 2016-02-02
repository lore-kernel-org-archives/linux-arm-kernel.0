From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  2 Feb 2016 12:24:14 +0100
Subject: [PATCH] ARM: dts: r8a7795: use GIC_* defines
Message-ID: <1454412254-11911-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use GIC_* defines for GIC interrupt cells in r8a7795 device tree.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
* Based on renesas-devel-20160129-v4.5-rc1
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 108 +++++++++++++++----------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 119549e6502d..d351f2c4b40e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -266,23 +266,23 @@
 		audma0: dma-controller at ec700000 {
 			compatible = "renesas,rcar-dmac";
 			reg = <0 0xec700000 0 0x10000>;
-			interrupts =	<0 350 IRQ_TYPE_LEVEL_HIGH
-					 0 320 IRQ_TYPE_LEVEL_HIGH
-					 0 321 IRQ_TYPE_LEVEL_HIGH
-					 0 322 IRQ_TYPE_LEVEL_HIGH
-					 0 323 IRQ_TYPE_LEVEL_HIGH
-					 0 324 IRQ_TYPE_LEVEL_HIGH
-					 0 325 IRQ_TYPE_LEVEL_HIGH
-					 0 326 IRQ_TYPE_LEVEL_HIGH
-					 0 327 IRQ_TYPE_LEVEL_HIGH
-					 0 328 IRQ_TYPE_LEVEL_HIGH
-					 0 329 IRQ_TYPE_LEVEL_HIGH
-					 0 330 IRQ_TYPE_LEVEL_HIGH
-					 0 331 IRQ_TYPE_LEVEL_HIGH
-					 0 332 IRQ_TYPE_LEVEL_HIGH
-					 0 333 IRQ_TYPE_LEVEL_HIGH
-					 0 334 IRQ_TYPE_LEVEL_HIGH
-					 0 335 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 350 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 320 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 321 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 322 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 323 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 324 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 325 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 326 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 327 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 328 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 329 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 330 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 331 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 332 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 333 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 334 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 335 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "error",
 					"ch0", "ch1", "ch2", "ch3",
 					"ch4", "ch5", "ch6", "ch7",
@@ -298,23 +298,23 @@
 		audma1: dma-controller at ec720000 {
 			compatible = "renesas,rcar-dmac";
 			reg = <0 0xec720000 0 0x10000>;
-			interrupts =	<0 351 IRQ_TYPE_LEVEL_HIGH
-					 0 336 IRQ_TYPE_LEVEL_HIGH
-					 0 337 IRQ_TYPE_LEVEL_HIGH
-					 0 338 IRQ_TYPE_LEVEL_HIGH
-					 0 339 IRQ_TYPE_LEVEL_HIGH
-					 0 340 IRQ_TYPE_LEVEL_HIGH
-					 0 341 IRQ_TYPE_LEVEL_HIGH
-					 0 342 IRQ_TYPE_LEVEL_HIGH
-					 0 343 IRQ_TYPE_LEVEL_HIGH
-					 0 344 IRQ_TYPE_LEVEL_HIGH
-					 0 345 IRQ_TYPE_LEVEL_HIGH
-					 0 346 IRQ_TYPE_LEVEL_HIGH
-					 0 347 IRQ_TYPE_LEVEL_HIGH
-					 0 348 IRQ_TYPE_LEVEL_HIGH
-					 0 349 IRQ_TYPE_LEVEL_HIGH
-					 0 382 IRQ_TYPE_LEVEL_HIGH
-					 0 383 IRQ_TYPE_LEVEL_HIGH>;
+			interrupts = <GIC_SPI 351 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 338 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 339 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 340 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 341 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 342 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 343 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 344 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 345 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 346 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 347 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 348 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 349 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 382 IRQ_TYPE_LEVEL_HIGH
+				      GIC_SPI 383 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "error",
 					"ch0", "ch1", "ch2", "ch3",
 					"ch4", "ch5", "ch6", "ch7",
@@ -750,52 +750,52 @@
 
 			rcar_sound,src {
 				src0: src at 0 {
-					interrupts = <0 352 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x85>, <&audma1 0x9a>;
 					dma-names = "rx", "tx";
 				};
 				src1: src at 1 {
-					interrupts = <0 353 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x87>, <&audma1 0x9c>;
 					dma-names = "rx", "tx";
 				};
 				src2: src at 2 {
-					interrupts = <0 354 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x89>, <&audma1 0x9e>;
 					dma-names = "rx", "tx";
 				};
 				src3: src at 3 {
-					interrupts = <0 355 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x8b>, <&audma1 0xa0>;
 					dma-names = "rx", "tx";
 				};
 				src4: src at 4 {
-					interrupts = <0 356 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x8d>, <&audma1 0xb0>;
 					dma-names = "rx", "tx";
 				};
 				src5: src at 5 {
-					interrupts = <0 357 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x8f>, <&audma1 0xb2>;
 					dma-names = "rx", "tx";
 				};
 				src6: src at 6 {
-					interrupts = <0 358 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x91>, <&audma1 0xb4>;
 					dma-names = "rx", "tx";
 				};
 				src7: src at 7 {
-					interrupts = <0 359 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x93>, <&audma1 0xb6>;
 					dma-names = "rx", "tx";
 				};
 				src8: src at 8 {
-					interrupts = <0 360 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x95>, <&audma1 0xb8>;
 					dma-names = "rx", "tx";
 				};
 				src9: src at 9 {
-					interrupts = <0 361 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x97>, <&audma1 0xba>;
 					dma-names = "rx", "tx";
 				};
@@ -803,52 +803,52 @@
 
 			rcar_sound,ssi {
 				ssi0: ssi at 0 {
-					interrupts = <0 370 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 370 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x01>, <&audma1 0x02>, <&audma0 0x15>, <&audma1 0x16>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi1: ssi at 1 {
-					 interrupts = <0 371 IRQ_TYPE_LEVEL_HIGH>;
+					 interrupts = <GIC_SPI 371 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x03>, <&audma1 0x04>, <&audma0 0x49>, <&audma1 0x4a>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi2: ssi at 2 {
-					interrupts = <0 372 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 372 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x05>, <&audma1 0x06>, <&audma0 0x63>, <&audma1 0x64>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi3: ssi at 3 {
-					interrupts = <0 373 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x07>, <&audma1 0x08>, <&audma0 0x6f>, <&audma1 0x70>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi4: ssi at 4 {
-					interrupts = <0 374 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 374 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x09>, <&audma1 0x0a>, <&audma0 0x71>, <&audma1 0x72>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi5: ssi at 5 {
-					interrupts = <0 375 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 375 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x0b>, <&audma1 0x0c>, <&audma0 0x73>, <&audma1 0x74>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi6: ssi at 6 {
-					interrupts = <0 376 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 376 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x0d>, <&audma1 0x0e>, <&audma0 0x75>, <&audma1 0x76>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi7: ssi at 7 {
-					interrupts = <0 377 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 377 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x0f>, <&audma1 0x10>, <&audma0 0x79>, <&audma1 0x7a>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi8: ssi at 8 {
-					interrupts = <0 378 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 378 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x11>, <&audma1 0x12>, <&audma0 0x7b>, <&audma1 0x7c>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
 				ssi9: ssi at 9 {
-					interrupts = <0 379 IRQ_TYPE_LEVEL_HIGH>;
+					interrupts = <GIC_SPI 379 IRQ_TYPE_LEVEL_HIGH>;
 					dmas = <&audma0 0x13>, <&audma1 0x14>, <&audma0 0x7d>, <&audma1 0x7e>;
 					dma-names = "rx", "tx", "rxu", "txu";
 				};
-- 
2.7.0.rc3.207.g0ac5344
