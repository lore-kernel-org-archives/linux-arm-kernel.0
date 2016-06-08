From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  8 Jun 2016 09:59:43 +0900
Subject: [PATCH 13/30] ARM: dts: r8a7778: Fix W=1 dtc warnings
In-Reply-To: <cover.1465346599.git.horms+renesas@verge.net.au>
References: <cover.1465346599.git.horms+renesas@verge.net.au>
Message-ID: <51f20c93383805cd4ec9c2f7e180c3dea7aefa81.1465346599.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Warning (unit_address_vs_reg): Node /sound at ffd90000/rcar_sound,src/src at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ffd90000/rcar_sound,src/src at 4 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ffd90000/rcar_sound,src/src at 5 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ffd90000/rcar_sound,src/src at 6 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ffd90000/rcar_sound,src/src at 7 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ffd90000/rcar_sound,src/src at 8 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ffd90000/rcar_sound,src/src at 9 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ffd90000/rcar_sound,ssi/ssi at 3 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ffd90000/rcar_sound,ssi/ssi at 4 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ffd90000/rcar_sound,ssi/ssi at 5 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ffd90000/rcar_sound,ssi/ssi at 6 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ffd90000/rcar_sound,ssi/ssi at 7 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ffd90000/rcar_sound,ssi/ssi at 8 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /sound at ffd90000/rcar_sound,ssi/ssi at 9 has a unit name, but no reg property

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index fe787b4751d2..e571d66ea0fe 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -276,23 +276,23 @@
 		status = "disabled";
 
 		rcar_sound,src {
-			src3: src at 3 { };
-			src4: src at 4 { };
-			src5: src at 5 { };
-			src6: src at 6 { };
-			src7: src at 7 { };
-			src8: src at 8 { };
-			src9: src at 9 { };
+			src3: src-3 { };
+			src4: src-4 { };
+			src5: src-5 { };
+			src6: src-6 { };
+			src7: src-7 { };
+			src8: src-8 { };
+			src9: src-9 { };
 		};
 
 		rcar_sound,ssi {
-			ssi3: ssi at 3 { interrupts = <GIC_SPI 0x85 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi4: ssi at 4 { interrupts = <GIC_SPI 0x85 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi5: ssi at 5 { interrupts = <GIC_SPI 0x86 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi6: ssi at 6 { interrupts = <GIC_SPI 0x86 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi7: ssi at 7 { interrupts = <GIC_SPI 0x86 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi8: ssi at 8 { interrupts = <GIC_SPI 0x86 IRQ_TYPE_LEVEL_HIGH>; };
-			ssi9: ssi at 9 { interrupts = <GIC_SPI 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi3: ssi-3 { interrupts = <GIC_SPI 0x85 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi4: ssi-4 { interrupts = <GIC_SPI 0x85 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi5: ssi-5 { interrupts = <GIC_SPI 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi6: ssi-6 { interrupts = <GIC_SPI 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi7: ssi-7 { interrupts = <GIC_SPI 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi8: ssi-8 { interrupts = <GIC_SPI 0x86 IRQ_TYPE_LEVEL_HIGH>; };
+			ssi9: ssi-9 { interrupts = <GIC_SPI 0x86 IRQ_TYPE_LEVEL_HIGH>; };
 		};
 	};
 
-- 
2.1.4
