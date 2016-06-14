From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Tue, 14 Jun 2016 14:17:37 +0300
Subject: [PATCH v2 3/4] ARM: dts: sun7i: Add A20 NAND controller pin
 definitions
In-Reply-To: <1465903058-9211-1-git-send-email-mamlinav@gmail.com>
References: <1465208664-9366-1-git-send-email-mamlinav@gmail.com>
 <1465903058-9211-1-git-send-email-mamlinav@gmail.com>
Message-ID: <1465903058-9211-4-git-send-email-mamlinav@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

Define the NAND controller pin configs.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 52 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index de4231e..ad984f8 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1168,6 +1168,58 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			nand_pins_a: nand_base0 at 0 {
+				allwinner,pins = "PC0", "PC1", "PC2",
+						"PC5", "PC8", "PC9", "PC10",
+						"PC11", "PC12", "PC13", "PC14",
+						"PC15", "PC16";
+				allwinner,function = "nand0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			nand_cs0_pins_a: nand_cs at 0 {
+				allwinner,pins = "PC4";
+				allwinner,function = "nand0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			nand_cs1_pins_a: nand_cs at 1 {
+				allwinner,pins = "PC3";
+				allwinner,function = "nand0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			nand_cs2_pins_a: nand_cs at 2 {
+				allwinner,pins = "PC17";
+				allwinner,function = "nand0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			nand_cs3_pins_a: nand_cs at 3 {
+				allwinner,pins = "PC18";
+				allwinner,function = "nand0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			nand_rb0_pins_a: nand_rb at 0 {
+				allwinner,pins = "PC6";
+				allwinner,function = "nand0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
+			nand_rb1_pins_a: nand_rb at 1 {
+				allwinner,pins = "PC7";
+				allwinner,function = "nand0";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			ps20_pins_a: ps20 at 0 {
 				allwinner,pins = "PI20", "PI21";
 				allwinner,function = "ps2";
-- 
2.7.3
