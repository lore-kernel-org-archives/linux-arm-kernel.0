From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  4 Sep 2014 10:12:27 +0900
Subject: [PATCH 4/5] ARM: shmobile: r8a7779 dtsi: Use tabs for indentation
In-Reply-To: <cover.1409792871.git.horms+renesas@verge.net.au>
References: <cover.1409792871.git.horms+renesas@verge.net.au>
Message-ID: <99e544c782ba03855b9b6762b73915565065dbf8.1409792871.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Checkpatch says:

ERROR: code indent should use tabs where possible

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index b749101..05b68f4 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -398,10 +398,10 @@
 		/* Gate clocks */
 		mstp0_clks: clocks at ffc80030 {
 			compatible = "renesas,r8a7779-mstp-clocks",
-			             "renesas,cpg-mstp-clocks";
+				     "renesas,cpg-mstp-clocks";
 			reg = <0xffc80030 4>;
 			clocks = <&cpg_clocks R8A7779_CLK_S>,
-			         <&cpg_clocks R8A7779_CLK_P>,
+				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_S>,
@@ -435,7 +435,7 @@
 		};
 		mstp1_clks: clocks at ffc80034 {
 			compatible = "renesas,r8a7779-mstp-clocks",
-			             "renesas,cpg-mstp-clocks";
+				     "renesas,cpg-mstp-clocks";
 			reg = <0xffc80034 4>, <0xffc80044 4>;
 			clocks = <&cpg_clocks R8A7779_CLK_P>,
 				 <&cpg_clocks R8A7779_CLK_P>,
@@ -464,7 +464,7 @@
 		};
 		mstp3_clks: clocks at ffc8003c {
 			compatible = "renesas,r8a7779-mstp-clocks",
-			             "renesas,cpg-mstp-clocks";
+				     "renesas,cpg-mstp-clocks";
 			reg = <0xffc8003c 4>;
 			clocks = <&s4_clk>, <&s4_clk>, <&s4_clk>, <&s4_clk>,
 				 <&s4_clk>, <&s4_clk>;
-- 
2.0.1
