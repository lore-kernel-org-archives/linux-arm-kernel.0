From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  3 Jan 2018 13:41:03 +0100
Subject: [PATCH v3 1/3] arm64: dts: renesas: r8a7795: move scif node into
 alphabetical order
In-Reply-To: <20180103124105.1999-1-horms+renesas@verge.net.au>
References: <20180103124105.1999-1-horms+renesas@verge.net.au>
Message-ID: <20180103124105.1999-2-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move scif node so that sub-nodes of the root node are in
alphabetical order.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index d12df6f2ff09..24e9209ea54e 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -165,13 +165,6 @@
 		clock-frequency = <0>;
 	};
 
-	/* External SCIF clock - to be overridden by boards that provide it */
-	scif_clk: scif {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
-
 	/* External PCIe clock - can be overridden by the board */
 	pcie_bus_clk: pcie_bus {
 		compatible = "fixed-clock";
@@ -208,6 +201,13 @@
 		method = "smc";
 	};
 
+	/* External SCIF clock - to be overridden by boards that provide it */
+	scif_clk: scif {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <0>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		interrupt-parent = <&gic>;
-- 
2.11.0
