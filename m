From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:29:08 +0200
Subject: [PATCH 41/42] ARM: dts: r7s72100: Add clock for CA9 CPU core
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <f20d89ac0fefad2465e6ce6d64e9ff82e33889dd.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Improve hardware description by adding a clock property to the device
node corresponding to the CA9 CPU core.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r7s72100.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r7s72100.dtsi b/arch/arm/boot/dts/r7s72100.dtsi
index 4ed12a4d9d51..ab9645a42eca 100644
--- a/arch/arm/boot/dts/r7s72100.dtsi
+++ b/arch/arm/boot/dts/r7s72100.dtsi
@@ -203,6 +203,7 @@
 			compatible = "arm,cortex-a9";
 			reg = <0>;
 			clock-frequency = <400000000>;
+			clocks = <&cpg_clocks R7S72100_CLK_I>;
 			next-level-cache = <&L2>;
 		};
 	};
-- 
2.11.0
