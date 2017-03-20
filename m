From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 20 Mar 2017 09:57:42 +0100
Subject: [PATCH 03/31] ARM: dts: r8a7745: Fix SCIFB0 dmas indentation
In-Reply-To: <cover.1489999062.git.horms+renesas@verge.net.au>
References: <cover.1489999062.git.horms+renesas@verge.net.au>
Message-ID: <ad20bb6868f1d29f9c911f14087be4f93c098604.1489999062.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Fixes: e0d2da54c4d01ba2 ("ARM: dts: r8a7745: add [H]SCIF{|A|B} support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7745.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7745.dtsi b/arch/arm/boot/dts/r8a7745.dtsi
index 1f65ff68a469..25175a74b6b7 100644
--- a/arch/arm/boot/dts/r8a7745.dtsi
+++ b/arch/arm/boot/dts/r8a7745.dtsi
@@ -277,7 +277,7 @@
 			clocks = <&cpg CPG_MOD 206>;
 			clock-names = "fck";
 			dmas = <&dmac0 0x3d>, <&dmac0 0x3e>,
-		       <&dmac1 0x3d>, <&dmac1 0x3e>;
+			       <&dmac1 0x3d>, <&dmac1 0x3e>;
 			dma-names = "tx", "rx", "tx", "rx";
 			power-domains = <&sysc R8A7745_PD_ALWAYS_ON>;
 			status = "disabled";
-- 
2.7.0.rc3.207.g0ac5344
