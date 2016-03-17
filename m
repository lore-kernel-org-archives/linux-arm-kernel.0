From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 18 Mar 2016 08:59:15 +0900
Subject: [PATCH 05/12] ARM: dts: koelsch: use generic pinctrl properties
In-Reply-To: <1458259162-15706-1-git-send-email-horms+renesas@verge.net.au>
References: <1458259162-15706-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1458259162-15706-6-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
groups properties") renesas pfc drivers accept generic "function", "pins"
and "groups" properties.

This patch updates the koelsch device tree to use the generic properties.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 68 +++++++++++++++++------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 0ad71b81d3a2..c6b43c85a0b1 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -324,89 +324,89 @@
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
 
 	sdhi0_pins: sd0 {
-		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
-		renesas,function = "sdhi0";
+		groups = "sdhi0_data4", "sdhi0_ctrl";
+		function = "sdhi0";
 	};
 
 	sdhi1_pins: sd1 {
-		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
-		renesas,function = "sdhi1";
+		groups = "sdhi1_data4", "sdhi1_ctrl";
+		function = "sdhi1";
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
 
 	msiof0_pins: spi1 {
-		renesas,groups = "msiof0_clk", "msiof0_sync", "msiof0_rx",
+		groups = "msiof0_clk", "msiof0_sync", "msiof0_rx",
 				 "msiof0_tx";
-		renesas,function = "msiof0";
+		function = "msiof0";
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
 
 	vin1_pins: vin1 {
-		renesas,groups = "vin1_data8", "vin1_clk";
-		renesas,function = "vin1";
+		groups = "vin1_data8", "vin1_clk";
+		function = "vin1";
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
