From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri,  4 Nov 2016 10:44:00 +0100
Subject: [PATCH 05/12] arm64: dts: r8a7795: Remove FCP SoC-specific compatible
 strings
In-Reply-To: <cover.1478251192.git.horms+renesas@verge.net.au>
References: <cover.1478251192.git.horms+renesas@verge.net.au>
Message-ID: <ab33da0bd8f9b6a8b16a61bb5baae365a87cd52c.1478251192.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The SoC-specific compatible strings have been removed from the FCP DT
bindings, removed them from the device tree.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 8c15040f2540..681f54422375 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -1306,28 +1306,28 @@
 		};
 
 		fcpvb1: fcp at fe92f000 {
-			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
+			compatible = "renesas,fcpv";
 			reg = <0 0xfe92f000 0 0x200>;
 			clocks = <&cpg CPG_MOD 606>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 		};
 
 		fcpf0: fcp at fe950000 {
-			compatible = "renesas,r8a7795-fcpf", "renesas,fcpf";
+			compatible = "renesas,fcpf";
 			reg = <0 0xfe950000 0 0x200>;
 			clocks = <&cpg CPG_MOD 615>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 		};
 
 		fcpf1: fcp at fe951000 {
-			compatible = "renesas,r8a7795-fcpf", "renesas,fcpf";
+			compatible = "renesas,fcpf";
 			reg = <0 0xfe951000 0 0x200>;
 			clocks = <&cpg CPG_MOD 614>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
 		};
 
 		fcpf2: fcp at fe952000 {
-			compatible = "renesas,r8a7795-fcpf", "renesas,fcpf";
+			compatible = "renesas,fcpf";
 			reg = <0 0xfe952000 0 0x200>;
 			clocks = <&cpg CPG_MOD 613>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
@@ -1344,7 +1344,7 @@
 		};
 
 		fcpvb0: fcp at fe96f000 {
-			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
+			compatible = "renesas,fcpv";
 			reg = <0 0xfe96f000 0 0x200>;
 			clocks = <&cpg CPG_MOD 607>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
@@ -1361,7 +1361,7 @@
 		};
 
 		fcpvi0: fcp at fe9af000 {
-			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
+			compatible = "renesas,fcpv";
 			reg = <0 0xfe9af000 0 0x200>;
 			clocks = <&cpg CPG_MOD 611>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
@@ -1378,7 +1378,7 @@
 		};
 
 		fcpvi1: fcp at fe9bf000 {
-			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
+			compatible = "renesas,fcpv";
 			reg = <0 0xfe9bf000 0 0x200>;
 			clocks = <&cpg CPG_MOD 610>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
@@ -1395,7 +1395,7 @@
 		};
 
 		fcpvi2: fcp at fe9cf000 {
-			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
+			compatible = "renesas,fcpv";
 			reg = <0 0xfe9cf000 0 0x200>;
 			clocks = <&cpg CPG_MOD 609>;
 			power-domains = <&sysc R8A7795_PD_A3VP>;
@@ -1412,7 +1412,7 @@
 		};
 
 		fcpvd0: fcp at fea27000 {
-			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
+			compatible = "renesas,fcpv";
 			reg = <0 0xfea27000 0 0x200>;
 			clocks = <&cpg CPG_MOD 603>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
@@ -1429,7 +1429,7 @@
 		};
 
 		fcpvd1: fcp at fea2f000 {
-			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
+			compatible = "renesas,fcpv";
 			reg = <0 0xfea2f000 0 0x200>;
 			clocks = <&cpg CPG_MOD 602>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
@@ -1446,7 +1446,7 @@
 		};
 
 		fcpvd2: fcp at fea37000 {
-			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
+			compatible = "renesas,fcpv";
 			reg = <0 0xfea37000 0 0x200>;
 			clocks = <&cpg CPG_MOD 601>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
@@ -1463,7 +1463,7 @@
 		};
 
 		fcpvd3: fcp at fea3f000 {
-			compatible = "renesas,r8a7795-fcpv", "renesas,fcpv";
+			compatible = "renesas,fcpv";
 			reg = <0 0xfea3f000 0 0x200>;
 			clocks = <&cpg CPG_MOD 600>;
 			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
-- 
2.7.0.rc3.207.g0ac5344
