From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:16 +0900
Subject: [PATCH 08/26] ARM: dts: gose: use generic pinctrl properties
In-Reply-To: <cover.1459731908.git.horms+renesas@verge.net.au>
References: <cover.1459731908.git.horms+renesas@verge.net.au>
Message-ID: <2e207c1cd0f883a7d89b5241295c167e45f994b2.1459731908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
groups properties") renesas pfc drivers accept generic "function", "pins"
and "groups" properties.

This patch updates the gose device tree to use the generic

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7793-gose.dts | 40 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7793-gose.dts b/arch/arm/boot/dts/r8a7793-gose.dts
index 87e89ec9dd47..c61df8b316ee 100644
--- a/arch/arm/boot/dts/r8a7793-gose.dts
+++ b/arch/arm/boot/dts/r8a7793-gose.dts
@@ -240,53 +240,53 @@
 	pinctrl-names = "default";
 
 	i2c2_pins: i2c2 {
-		renesas,groups = "i2c2";
-		renesas,function = "i2c2";
+		groups = "i2c2";
+		function = "i2c2";
 	};
 
 	du_pins: du {
-		renesas,groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
-		renesas,function = "du";
+		groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
+		function = "du";
 	};
 
 	scif0_pins: serial0 {
-		renesas,groups = "scif0_data_d";
-		renesas,function = "scif0";
+		groups = "scif0_data_d";
+		function = "scif0";
 	};
 
 	scif1_pins: serial1 {
-		renesas,groups = "scif1_data_d";
-		renesas,function = "scif1";
+		groups = "scif1_data_d";
+		function = "scif1";
 	};
 
 	scif_clk_pins: scif_clk {
-		renesas,groups = "scif_clk";
-		renesas,function = "scif_clk";
+		groups = "scif_clk";
+		function = "scif_clk";
 	};
 
 	ether_pins: ether {
-		renesas,groups = "eth_link", "eth_mdio", "eth_rmii";
-		renesas,function = "eth";
+		groups = "eth_link", "eth_mdio", "eth_rmii";
+		function = "eth";
 	};
 
 	phy1_pins: phy1 {
-		renesas,groups = "intc_irq0";
-		renesas,function = "intc";
+		groups = "intc_irq0";
+		function = "intc";
 	};
 
 	qspi_pins: spi0 {
-		renesas,groups = "qspi_ctrl", "qspi_data4";
-		renesas,function = "qspi";
+		groups = "qspi_ctrl", "qspi_data4";
+		function = "qspi";
 	};
 
 	sound_pins: sound {
-		renesas,groups = "ssi0129_ctrl", "ssi0_data", "ssi1_data";
-		renesas,function = "ssi";
+		groups = "ssi0129_ctrl", "ssi0_data", "ssi1_data";
+		function = "ssi";
 	};
 
 	sound_clk_pins: sound_clk {
-		renesas,groups = "audio_clk_a";
-		renesas,function = "audio_clk";
+		groups = "audio_clk_a";
+		function = "audio_clk";
 	};
 };
 
-- 
2.1.4
