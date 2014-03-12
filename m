From: b.brezillon.dev@gmail.com (Boris BREZILLON)
Date: Wed, 12 Mar 2014 19:07:43 +0100
Subject: [PATCH v3 8/9] ARM: dt/sunxi: add A20 NAND controller pin definitions
In-Reply-To: <1394647664-8258-1-git-send-email-b.brezillon.dev@gmail.com>
References: <1394647664-8258-1-git-send-email-b.brezillon.dev@gmail.com>
Message-ID: <1394647664-8258-9-git-send-email-b.brezillon.dev@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the NAND controller pin configs.

Signed-off-by: Boris BREZILLON <b.brezillon.dev@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi |   80 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 4c14ed8..c8095c5 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -443,6 +443,86 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			nand_pins_a: nand_base0 at 0 {
+				allwinner,pins = "PC0", "PC1", "PC2",
+						"PC5", "PC8", "PC9", "PC10",
+						"PC11", "PC12", "PC13", "PC14",
+						"PC15", "PC16";
+				allwinner,function = "nand0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			nand_cs0_pins_a: nand_cs at 0 {
+				allwinner,pins = "PC4";
+				allwinner,function = "nand0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			nand_cs1_pins_a: nand_cs at 1 {
+				allwinner,pins = "PC3";
+				allwinner,function = "nand0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			nand_cs2_pins_a: nand_cs at 2 {
+				allwinner,pins = "PC17";
+				allwinner,function = "nand0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			nand_cs3_pins_a: nand_cs at 3 {
+				allwinner,pins = "PC18";
+				allwinner,function = "nand0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			nand_cs4_pins_a: nand_cs at 4 {
+				allwinner,pins = "PC19";
+				allwinner,function = "nand0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			nand_cs5_pins_a: nand_cs at 5 {
+				allwinner,pins = "PC20";
+				allwinner,function = "nand0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			nand_cs6_pins_a: nand_cs at 6 {
+				allwinner,pins = "PC21";
+				allwinner,function = "nand0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			nand_cs7_pins_a: nand_cs at 7 {
+				allwinner,pins = "PC22";
+				allwinner,function = "nand0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			nand_rb0_pins_a: nand_rb at 0 {
+				allwinner,pins = "PC6";
+				allwinner,function = "nand0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			nand_rb1_pins_a: nand_rb at 1 {
+				allwinner,pins = "PC7";
+				allwinner,function = "nand0";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
1.7.9.5
