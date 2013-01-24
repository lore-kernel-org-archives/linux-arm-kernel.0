From: tobetter@gmail.com (Dongjin Kim)
Date: Fri, 25 Jan 2013 03:46:08 +0900
Subject: [PATCH RESEND] ARM: dts: max77686: Add DTS file for max77686 PMIC
Message-ID: <1359053177-17725-1-git-send-email-tobetter@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a dedicated DTS file for max77686 PMIC, supposed to be included
in a board DTS to control the power for certain consumer devices or AP with 9 BUCKs
and 26 LDOs

Signed-off-by: Dongjin Kim <tobetter@gmail.com>
---
 arch/arm/boot/dts/max77686.dtsi |  156 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100644 arch/arm/boot/dts/max77686.dtsi

diff --git a/arch/arm/boot/dts/max77686.dtsi b/arch/arm/boot/dts/max77686.dtsi
new file mode 100644
index 0000000..b80baef
--- /dev/null
+++ b/arch/arm/boot/dts/max77686.dtsi
@@ -0,0 +1,156 @@
+/*
+ * Copyright (C) 2013 Dongjin Kim <tobetter@gmail.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ */
+
+&max77686 {
+	compatible = "maxim,max77686";
+
+	interrupt-controller;
+	#interrupt-cells = <1>;
+
+	voltage-regulators {
+		buck1: buck at 10 {
+			regulator-compatible = "BUCK1";
+		};
+
+		buck2: buck at 12 {
+			regulator-compatible = "BUCK2";
+		};
+
+		buck3: buck at 1c {
+			regulator-compatible = "BUCK3";
+		};
+
+		buck4: buck at 26 {
+			regulator-compatible = "BUCK4";
+		};
+
+		buck5: buck at 30 {
+			regulator-compatible = "BUCK5";
+		};
+
+		buck6: buck at 32 {
+			regulator-compatible = "BUCK6";
+		};
+
+		buck7: buck at 34 {
+			regulator-compatible = "BUCK7";
+		};
+
+		buck8: buck at 36 {
+			regulator-compatible = "BUCK8";
+		};
+
+		buck9: buck at 38 {
+			regulator-compatible = "BUCK9";
+		};
+
+		ldo1: ldo at 40 {
+			regulator-compatible = "LDO1";
+		};
+
+		ldo2: ldo at 41 {
+			regulator-compatible = "LDO2";
+		};
+
+		ldo3: ldo at 42 {
+			regulator-compatible = "LDO3";
+		};
+
+		ldo4: ldo at 43 {
+			regulator-compatible = "LDO4";
+		};
+
+		ldo5: ldo at 44 {
+			regulator-compatible = "LDO5";
+		};
+
+		ldo6: ldo at 45 {
+			regulator-compatible = "LDO6";
+		};
+
+		ldo7: ldo at 46 {
+			regulator-compatible = "LDO7";
+		};
+
+		ldo8: ldo at 47 {
+			regulator-compatible = "LDO8";
+		};
+
+		ldo9: ldo at 48 {
+			regulator-compatible = "LDO9";
+		};
+
+		ldo10: ldo at 49 {
+			regulator-compatible = "LDO10";
+		};
+
+		ldo11: ldo at 4a {
+			regulator-compatible = "LDO11";
+		};
+
+		ldo12: ldo at 4b {
+			regulator-compatible = "LDO12";
+		};
+
+		ldo13: ldo at 4c {
+			regulator-compatible = "LDO13";
+		};
+
+		ldo14: ldo at 4d {
+			regulator-compatible = "LDO14";
+		};
+
+		ldo15: ldo at 4e {
+			regulator-compatible = "LDO15";
+		};
+
+		ldo16: ldo at 4f {
+			regulator-compatible = "LDO16";
+		};
+
+		ldo17: ldo at 50 {
+			regulator-compatible = "LDO17";
+		};
+
+		ldo18: ldo at 51 {
+			regulator-compatible = "LDO18";
+		};
+
+		ldo19: ldo at 52 {
+			regulator-compatible = "LDO19";
+		};
+
+		ldo20: ldo at 53 {
+			regulator-compatible = "LDO20";
+		};
+
+		ldo21: ldo at 54 {
+			regulator-compatible = "LDO21";
+		};
+
+		ldo22: ldo at 55 {
+			regulator-compatible = "LDO22";
+		};
+
+		ldo23: ldo at 56 {
+			regulator-compatible = "LDO23";
+		};
+
+		ldo24: ldo at 57 {
+			regulator-compatible = "LDO24";
+		};
+
+		ldo25: ldo at 58 {
+			regulator-compatible = "LDO25";
+		};
+
+		ldo26: ldo at 59 {
+			regulator-compatible = "LDO26";
+		};
+	};
+};
-- 
1.7.10.4
