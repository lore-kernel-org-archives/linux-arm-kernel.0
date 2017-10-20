From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 20 Oct 2017 12:28:58 +0200
Subject: [PATCH 31/42] ARM: dts: r8a7778: Add clock for CA9 CPU core
In-Reply-To: <cover.1508493785.git.horms+renesas@verge.net.au>
References: <cover.1508493785.git.horms+renesas@verge.net.au>
Message-ID: <d3e865a35a4f8cee0d0b86d7cd6d05908f01a874.1508493785.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Improve hardware description by adding a clock property to the device
node corresponding to the CA9 CPU core.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7778.dtsi b/arch/arm/boot/dts/r8a7778.dtsi
index a31817b2dda7..a39472aab867 100644
--- a/arch/arm/boot/dts/r8a7778.dtsi
+++ b/arch/arm/boot/dts/r8a7778.dtsi
@@ -33,6 +33,7 @@
 			compatible = "arm,cortex-a9";
 			reg = <0>;
 			clock-frequency = <800000000>;
+			clocks = <&z_clk>;
 		};
 	};
 
-- 
2.11.0
