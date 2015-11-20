From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 19 Nov 2015 17:05:46 -0800
Subject: [PATCH 2/6] arm64: renesas: r8a7795: Add dummy dma-controller nodes
In-Reply-To: <cover.1447980335.git.horms+renesas@verge.net.au>
References: <cover.1447980335.git.horms+renesas@verge.net.au>
Message-ID: <d920212667ecdceea144fae267f81cb119f5d8e7.1447980335.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add dummy nodes for the 3 DMA controllers.
This allows to start describing DMA channels for DMA slaves now.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 8d7552020daf..9e1de4d6615c 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -79,5 +79,17 @@
 			#clock-cells = <2>;
 			#power-domain-cells = <0>;
 		};
+
+		dmac0: dma-controller at e6700000 {
+			/* Empty node for now */
+		};
+
+		dmac1: dma-controller at e7300000 {
+			/* Empty node for now */
+		};
+
+		dmac2: dma-controller at e7310000 {
+			/* Empty node for now */
+		};
 	};
 };
-- 
2.1.4
