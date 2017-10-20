From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:29:06 +0200
Subject: [PATCH 39/42] ARM: dts: sh73a0: Add clocks for CA9 CPU cores
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <e5042d0b97be6a831f9f204f3574d73b3f947fa5.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Improve hardware description by adding clocks properties to the device
nodes corresponding to the CA9 CPU cores.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index 4ea5c5a16c57..88d7e5631d34 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -27,6 +27,7 @@
 			compatible = "arm,cortex-a9";
 			reg = <0>;
 			clock-frequency = <1196000000>;
+			clocks = <&cpg_clocks SH73A0_CLK_Z>;
 			power-domains = <&pd_a2sl>;
 			next-level-cache = <&L2>;
 		};
@@ -35,6 +36,7 @@
 			compatible = "arm,cortex-a9";
 			reg = <1>;
 			clock-frequency = <1196000000>;
+			clocks = <&cpg_clocks SH73A0_CLK_Z>;
 			power-domains = <&pd_a2sl>;
 			next-level-cache = <&L2>;
 		};
-- 
2.11.0
