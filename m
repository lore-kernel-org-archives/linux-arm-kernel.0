From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  4 Apr 2016 10:22:12 +0900
Subject: [PATCH 04/26] ARM: dts: bockw: use generic pinctrl properties
In-Reply-To: <cover.1459731908.git.horms+renesas@verge.net.au>
References: <cover.1459731908.git.horms+renesas@verge.net.au>
Message-ID: <ddf72563890a3361f7da82510ef8baca37a13830.1459731908.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since 16ccaf5bb5a5 ("pinctrl: sh-pfc: Accept standard function, pins and
groups properties") renesas pfc drivers accept generic "function", "pins"
and "groups" properties.

This patch updates the bockw device tree to use the generic properties.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/r8a7778-bockw.dts | 40 ++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw.dts b/arch/arm/boot/dts/r8a7778-bockw.dts
index 21e3b9dda2da..e0dab1464648 100644
--- a/arch/arm/boot/dts/r8a7778-bockw.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw.dts
@@ -130,53 +130,53 @@
 	pinctrl-names = "default";
 
 	scif0_pins: serial0 {
-		renesas,groups = "scif0_data_a", "scif0_ctrl";
-		renesas,function = "scif0";
+		groups = "scif0_data_a", "scif0_ctrl";
+		function = "scif0";
 	};
 
 	scif_clk_pins: scif_clk {
-		renesas,groups = "scif_clk";
-		renesas,function = "scif_clk";
+		groups = "scif_clk";
+		function = "scif_clk";
 	};
 
 	mmc_pins: mmc {
-		renesas,groups = "mmc_data8", "mmc_ctrl";
-		renesas,function = "mmc";
+		groups = "mmc_data8", "mmc_ctrl";
+		function = "mmc";
 	};
 
 	sdhi0_pins: sd0 {
-		renesas,groups = "sdhi0_data4", "sdhi0_ctrl";
-		renesas,function = "sdhi0";
+		groups = "sdhi0_data4", "sdhi0_ctrl";
+		function = "sdhi0";
 	};
 	sdhi0_pup_pins: sd0_pup {
-		renesas,groups = "sdhi0_cd", "sdhi0_wp";
-		renesas,function = "sdhi0";
+		groups = "sdhi0_cd", "sdhi0_wp";
+		function = "sdhi0";
 		bias-pull-up;
 	};
 
 	hspi0_pins: hspi0 {
-		renesas,groups = "hspi0_a";
-		renesas,function = "hspi0";
+		groups = "hspi0_a";
+		function = "hspi0";
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
 
 	vin1_pins: vin1 {
-		renesas,groups = "vin1_data8", "vin1_clk";
-		renesas,function = "vin1";
+		groups = "vin1_data8", "vin1_clk";
+		function = "vin1";
 	};
 };
 
-- 
2.1.4
