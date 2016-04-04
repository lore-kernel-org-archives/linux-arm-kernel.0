From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:15 +0900
Subject: [PATCH 07/26] ARM: dts: porter: use generic pinctrl properties
In-Reply-To: <cover.1459731908.git.horms+renesas@verge.net.au>
References: <cover.1459731908.git.horms+renesas@verge.net.au>
Message-ID: <b2abb296ad8cb576ea90e813842fa204bc21aebb.1459731908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
groups properties") renesas pfc drivers accept generic "function", "pins"
and "groups" properties.

This patch updates the porter device tree to use the generic properties.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7791-porter.dts | 60 ++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-porter.dts b/arch/arm/boot/dts/r8a7791-porter.dts
index 6c08314427d6..af3751ff519a 100644
--- a/arch/arm/boot/dts/r8a7791-porter.dts
+++ b/arch/arm/boot/dts/r8a7791-porter.dts
@@ -147,78 +147,78 @@
 	pinctrl-names = "default";
 
 	scif0_pins: serial0 {
-		renesas,groups = "scif0_data_d";
-		renesas,function = "scif0";
+		groups = "scif0_data_d";
+		function = "scif0";
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
 
 	sdhi0_pins: sd0 {
-		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
-		renesas,function = "sdhi0";
+		groups = "sdhi0_data4", "sdhi0_ctrl";
+		function = "sdhi0";
 	};
 
 	sdhi2_pins: sd2 {
-		renesas,groups = "sdhi2_data4", "sdhi2_ctrl";
-		renesas,function = "sdhi2";
+		groups = "sdhi2_data4", "sdhi2_ctrl";
+		function = "sdhi2";
 	};
 
 	qspi_pins: spi0 {
-		renesas,groups = "qspi_ctrl", "qspi_data4";
-		renesas,function = "qspi";
+		groups = "qspi_ctrl", "qspi_data4";
+		function = "qspi";
 	};
 
 	i2c2_pins: i2c2 {
-		renesas,groups = "i2c2";
-		renesas,function = "i2c2";
+		groups = "i2c2";
+		function = "i2c2";
 	};
 
 	usb0_pins: usb0 {
-		renesas,groups = "usb0";
-		renesas,function = "usb0";
+		groups = "usb0";
+		function = "usb0";
 	};
 
 	usb1_pins: usb1 {
-		renesas,groups = "usb1";
-		renesas,function = "usb1";
+		groups = "usb1";
+		function = "usb1";
 	};
 
 	vin0_pins: vin0 {
-		renesas,groups = "vin0_data8", "vin0_clk";
-		renesas,function = "vin0";
+		groups = "vin0_data8", "vin0_clk";
+		function = "vin0";
 	};
 
 	can0_pins: can0 {
-		renesas,groups = "can0_data";
-		renesas,function = "can0";
+		groups = "can0_data";
+		function = "can0";
 	};
 
 	du_pins: du {
-		renesas,groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
-		renesas,function = "du";
+		groups = "du_rgb888", "du_sync", "du_disp", "du_clk_out_0";
+		function = "du";
 	};
 
 	ssi_pins: sound {
-		renesas,groups = "ssi0129_ctrl", "ssi0_data", "ssi1_data";
-		renesas,function = "ssi";
+		groups = "ssi0129_ctrl", "ssi0_data", "ssi1_data";
+		function = "ssi";
 	};
 
 	audio_clk_pins: audio_clk {
-		renesas,groups = "audio_clk_a";
-		renesas,function = "audio_clk";
+		groups = "audio_clk_a";
+		function = "audio_clk";
 	};
 };
 
-- 
2.1.4
