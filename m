From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:18 +0900
Subject: [PATCH 10/26] ARM: dts: silk: use generic pinctrl properties
In-Reply-To: <cover.1459731908.git.horms+renesas@verge.net.au>
References: <cover.1459731908.git.horms+renesas@verge.net.au>
Message-ID: <4386ed21e5c1944f9b666f405796499526c5e59b.1459731908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
groups properties") renesas pfc drivers accept generic "function", "pins"
and "groups" properties.

This patch updates the silk device tree to use the generic properties.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7794-silk.dts | 44 +++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7794-silk.dts b/arch/arm/boot/dts/r8a7794-silk.dts
index 66f077a3ca41..56d98d5b2185 100644
--- a/arch/arm/boot/dts/r8a7794-silk.dts
+++ b/arch/arm/boot/dts/r8a7794-silk.dts
@@ -130,58 +130,58 @@
 	pinctrl-names = "default";
 
 	scif2_pins: serial2 {
-		renesas,groups = "scif2_data";
-		renesas,function = "scif2";
+		groups = "scif2_data";
+		function = "scif2";
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
-		renesas,groups = "intc_irq8";
-		renesas,function = "intc";
+		groups = "intc_irq8";
+		function = "intc";
 	};
 
 	i2c1_pins: i2c1 {
-		renesas,groups = "i2c1";
-		renesas,function = "i2c1";
+		groups = "i2c1";
+		function = "i2c1";
 	};
 
 	mmcif0_pins: mmcif0 {
-		renesas,groups = "mmc_data8", "mmc_ctrl";
-		renesas,function = "mmc";
+		groups = "mmc_data8", "mmc_ctrl";
+		function = "mmc";
 	};
 
 	sdhi1_pins: sd1 {
-		renesas,groups = "sdhi1_data4", "sdhi1_ctrl";
-		renesas,function = "sdhi1";
+		groups = "sdhi1_data4", "sdhi1_ctrl";
+		function = "sdhi1";
 	};
 
 	qspi_pins: spi0 {
-		renesas,groups = "qspi_ctrl", "qspi_data4";
-		renesas,function = "qspi";
+		groups = "qspi_ctrl", "qspi_data4";
+		function = "qspi";
 	};
 
 	vin0_pins: vin0 {
-		renesas,groups = "vin0_data8", "vin0_clk";
-		renesas,function = "vin0";
+		groups = "vin0_data8", "vin0_clk";
+		function = "vin0";
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
 };
 
-- 
2.1.4
