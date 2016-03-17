From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Mar 2016 08:59:14 +0900
Subject: [PATCH 04/12] ARM: dts: marzen: use generic pinctrl properties
In-Reply-To: <1458259162-15706-1-git-send-email-horms+renesas@verge.net.au>
References: <1458259162-15706-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1458259162-15706-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
groups properties") renesas pfc drivers accept generic "function", "pins"
and "groups" properties.

This patch updates the marzen device tree to use the generic properties.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen.dts | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen.dts b/arch/arm/boot/dts/r8a7779-marzen.dts
index e111d35d02ae..b795da6f5503 100644
--- a/arch/arm/boot/dts/r8a7779-marzen.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen.dts
@@ -170,49 +170,49 @@
 
 	du_pins: du {
 		du0 {
-			renesas,groups = "du0_rgb888", "du0_sync_1", "du0_clk_out_0";
-			renesas,function = "du0";
+			groups = "du0_rgb888", "du0_sync_1", "du0_clk_out_0";
+			function = "du0";
 		};
 		du1 {
-			renesas,groups = "du1_rgb666", "du1_sync_1", "du1_clk_out";
-			renesas,function = "du1";
+			groups = "du1_rgb666", "du1_sync_1", "du1_clk_out";
+			function = "du1";
 		};
 	};
 
 	scif_clk_pins: scif_clk {
-		renesas,groups = "scif_clk_b";
-		renesas,function = "scif_clk";
+		groups = "scif_clk_b";
+		function = "scif_clk";
 	};
 
 	ethernet_pins: ethernet {
 		intc {
-			renesas,groups = "intc_irq1_b";
-			renesas,function = "intc";
+			groups = "intc_irq1_b";
+			function = "intc";
 		};
 		lbsc {
-			renesas,groups = "lbsc_ex_cs0";
-			renesas,function = "lbsc";
+			groups = "lbsc_ex_cs0";
+			function = "lbsc";
 		};
 	};
 
 	scif2_pins: serial2 {
-		renesas,groups = "scif2_data_c";
-		renesas,function = "scif2";
+		groups = "scif2_data_c";
+		function = "scif2";
 	};
 
 	scif4_pins: serial4 {
-		renesas,groups = "scif4_data";
-		renesas,function = "scif4";
+		groups = "scif4_data";
+		function = "scif4";
 	};
 
 	sdhi0_pins: sd0 {
-		renesas,groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
-		renesas,function = "sdhi0";
+		groups = "sdhi0_data4", "sdhi0_ctrl", "sdhi0_cd";
+		function = "sdhi0";
 	};
 
 	hspi0_pins: hspi0 {
-		renesas,groups = "hspi0";
-		renesas,function = "hspi0";
+		groups = "hspi0";
+		function = "hspi0";
 	};
 };
 
-- 
2.1.4
