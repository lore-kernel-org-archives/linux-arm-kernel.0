From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:09 +0900
Subject: [PATCH 01/26] ARM: dts: lager: use generic pinctrl properties
In-Reply-To: <cover.1459731908.git.horms+renesas@verge.net.au>
References: <cover.1459731908.git.horms+renesas@verge.net.au>
Message-ID: <2ffc224f3ab047f16d2dc73b90a6fe148c03f946.1459731908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
groups properties") renesas pfc drivers accept generic "function", "pins"
and "groups" properties.

This patch updates the lager device tree to use the generic
rather than renesas-specific properties.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7790-lager.dts | 92 ++++++++++++++++++-------------------
 1 file changed, 46 insertions(+), 46 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
index aa6ca92a9485..a5828721ab7c 100644
--- a/arch/arm/boot/dts/r8a7790-lager.dts
+++ b/arch/arm/boot/dts/r8a7790-lager.dts
@@ -314,119 +314,119 @@
 	pinctrl-names = "default";
 
 	du_pins: du {
-		renesas,groups = "du_rgb666", "du_sync_1", "du_clk_out_0";
-		renesas,function = "du";
+		groups = "du_rgb666", "du_sync_1", "du_clk_out_0";
+		function = "du";
 	};
 
 	scif0_pins: serial0 {
-		renesas,groups = "scif0_data";
-		renesas,function = "scif0";
+		groups = "scif0_data";
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
 
 	scifa1_pins: serial1 {
-		renesas,groups = "scifa1_data";
-		renesas,function = "scifa1";
+		groups = "scifa1_data";
+		function = "scifa1";
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
 
 	mmc1_pins: mmc1 {
-		renesas,groups = "mmc1_data8", "mmc1_ctrl";
-		renesas,function = "mmc1";
+		groups = "mmc1_data8", "mmc1_ctrl";
+		function = "mmc1";
 	};
 
 	qspi_pins: spi0 {
-		renesas,groups = "qspi_ctrl", "qspi_data4";
-		renesas,function = "qspi";
+		groups = "qspi_ctrl", "qspi_data4";
+		function = "qspi";
 	};
 
 	msiof1_pins: spi2 {
-		renesas,groups = "msiof1_clk", "msiof1_sync", "msiof1_rx",
+		groups = "msiof1_clk", "msiof1_sync", "msiof1_rx",
 				 "msiof1_tx";
-		renesas,function = "msiof1";
+		function = "msiof1";
 	};
 
 	i2c0_pins: i2c0 {
-		renesas,groups = "i2c0";
-		renesas,function = "i2c0";
+		groups = "i2c0";
+		function = "i2c0";
 	};
 
 	iic0_pins: iic0 {
-		renesas,groups = "iic0";
-		renesas,function = "iic0";
+		groups = "iic0";
+		function = "iic0";
 	};
 
 	iic1_pins: iic1 {
-		renesas,groups = "iic1";
-		renesas,function = "iic1";
+		groups = "iic1";
+		function = "iic1";
 	};
 
 	iic2_pins: iic2 {
-		renesas,groups = "iic2";
-		renesas,function = "iic2";
+		groups = "iic2";
+		function = "iic2";
 	};
 
 	iic3_pins: iic3 {
-		renesas,groups = "iic3";
-		renesas,function = "iic3";
+		groups = "iic3";
+		function = "iic3";
 	};
 
 	hsusb_pins: hsusb {
-		renesas,groups = "usb0_ovc_vbus";
-		renesas,function = "usb0";
+		groups = "usb0_ovc_vbus";
+		function = "usb0";
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
 
 	usb2_pins: usb2 {
-		renesas,groups = "usb2";
-		renesas,function = "usb2";
+		groups = "usb2";
+		function = "usb2";
 	};
 
 	vin1_pins: vin {
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
