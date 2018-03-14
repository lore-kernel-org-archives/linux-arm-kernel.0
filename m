From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Wed, 14 Mar 2018 14:17:32 +0900
Subject: [PATCH] ARM: dts: uniphier: add audio in/out pin-mux node
Message-ID: <20180314051732.6177-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UniPhier AIO audio system needs I2S data in/out lines
and clock signal pins to connect external codec chip.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 arch/arm/boot/dts/uniphier-pinctrl.dtsi | 40 +++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-pinctrl.dtsi b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
index de481c372467..c213f17a12ca 100644
--- a/arch/arm/boot/dts/uniphier-pinctrl.dtsi
+++ b/arch/arm/boot/dts/uniphier-pinctrl.dtsi
@@ -13,6 +13,46 @@
 		function = "aout";
 	};
 
+	pinctrl_ain1: ain1 {
+		groups = "ain1";
+		function = "ain1";
+	};
+
+	pinctrl_ain2: ain2 {
+		groups = "ain2";
+		function = "ain2";
+	};
+
+	pinctrl_ainiec1: ainiec1 {
+		groups = "ainiec1";
+		function = "ainiec1";
+	};
+
+	pinctrl_aout1: aout1 {
+		groups = "aout1";
+		function = "aout1";
+	};
+
+	pinctrl_aout2: aout2 {
+		groups = "aout2";
+		function = "aout2";
+	};
+
+	pinctrl_aout3: aout3 {
+		groups = "aout3";
+		function = "aout3";
+	};
+
+	pinctrl_aoutiec1: aoutiec1 {
+		groups = "aoutiec1";
+		function = "aoutiec1";
+	};
+
+	pinctrl_aoutiec2: aoutiec2 {
+		groups = "aoutiec2";
+		function = "aoutiec2";
+	};
+
 	pinctrl_emmc: emmc {
 		groups = "emmc", "emmc_dat8";
 		function = "emmc";
-- 
2.16.1
