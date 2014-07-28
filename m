From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon, 28 Jul 2014 14:18:11 +0200
Subject: [RFC 4/5] ARM: dts: add pinctrl support to Exynos5410
In-Reply-To: <1406549892-5558-1-git-send-email-afaerber@suse.de>
References: <1406549892-5558-1-git-send-email-afaerber@suse.de>
Message-ID: <1406549892-5558-5-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hakjoo Kim <ruppi.kim@hardkernel.com>

Add the required pin configuration support to Exynos5410 using pinctrl
interface.

Cc: Hakjoo Kim <ruppi.kim@hardkernel.com>
[AF: Rebased]
---
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi | 408 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos5410.dtsi         |  32 +++
 2 files changed, 440 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5410-pinctrl.dtsi

diff --git a/arch/arm/boot/dts/exynos5410-pinctrl.dtsi b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
new file mode 100644
index 000000000000..8b5288367a00
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5410-pinctrl.dtsi
@@ -0,0 +1,408 @@
+/*
+ * Exynos5410 SoC pin-mux and pin-config device tree source
+ *
+ * Copyright (c) 2013 Hardkernel Co., Ltd.
+ *              http://www.hardkernel.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	pinctrl at 13400000 {
+		gpa0: gpa0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpa1: gpa1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpa2: gpa2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpb0: gpb0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpb1: gpb1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpb2: gpb2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpb3: gpb3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpc0: gpc0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpc3: gpc3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpc1: gpc1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpc2: gpc2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpm5: gpm5 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpd1: gpd1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpe0: gpe0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpe1: gpe1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpf0: gpf0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpf1: gpf1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpg0: gpg0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpg1: gpg1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpg2: gpg2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gph0: gph0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gph1: gph1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpm7: gpm7 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy0: gpy0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy1: gpy1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy2: gpy2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy3: gpy3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy4: gpy4 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy5: gpy5 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy6: gpy6 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpy7: gpy7 {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		gpx0: gpx0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			interrupt-parent = <&combiner>;
+			#interrupt-cells = <2>;
+			interrupts = <23 0>,
+			             <24 0>,
+			             <25 0>,
+			             <25 1>,
+			             <26 0>,
+			             <26 1>,
+			             <27 0>,
+			             <27 1>;
+		};
+
+		gpx1: gpx1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			interrupt-parent = <&combiner>;
+			#interrupt-cells = <2>;
+			interrupts = <28 0>,
+			             <28 1>,
+			             <29 0>,
+			             <29 1>,
+			             <30 0>,
+			             <30 1>,
+			             <31 0>,
+			             <31 1>;
+		};
+
+		gpx2: gpx2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpx3: gpx3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pinctrl at 14000000 {
+		gpj0: gpj0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpj1: gpj1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpj2: gpj2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpj3: gpj3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpj4: gpj4 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpk0: gpk0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpk1: gpk1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpk2: gpk2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpk3: gpk3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pinctrl at 10d10000 {
+		gpv0: gpv0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpv1: gpv1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpv2: gpv2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpv3: gpv3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpv4: gpv4 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	pinctrl at 03860000 {
+		gpz: gpz {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/exynos5410.dtsi b/arch/arm/boot/dts/exynos5410.dtsi
index 790d4886d7b5..6e3ec9399362 100644
--- a/arch/arm/boot/dts/exynos5410.dtsi
+++ b/arch/arm/boot/dts/exynos5410.dtsi
@@ -14,12 +14,20 @@
  */
 
 #include "skeleton.dtsi"
+#include "exynos5410-pinctrl.dtsi"
 #include <dt-bindings/clock/exynos5410.h>
 
 / {
 	compatible = "samsung,exynos5410", "samsung,exynos5";
 	interrupt-parent = <&gic>;
 
+	aliases {
+		pinctrl0 = &pinctrl_0;
+		pinctrl1 = &pinctrl_1;
+		pinctrl2 = &pinctrl_2;
+		pinctrl3 = &pinctrl_3;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -212,4 +220,28 @@
 			status = "disabled";
 		};
 	};
+
+	pinctrl_0: pinctrl at 13400000 {
+		compatible = "samsung,exynos5410-pinctrl";
+		reg = <0x13400000 0x1000>;
+		interrupts = <0 45 0>;
+	};
+
+	pinctrl_1: pinctrl at 14000000 {
+		compatible = "samsung,exynos5410-pinctrl";
+		reg = <0x14000000 0x1000>;
+		interrupts = <0 46 0>;
+	};
+
+	pinctrl_2: pinctrl at 10d10000 {
+		compatible = "samsung,exynos5410-pinctrl";
+		reg = <0x10d10000 0x1000>;
+		interrupts = <0 50 0>;
+	};
+
+	pinctrl_3: pinctrl at 03860000 {
+		compatible = "samsung,exynos5410-pinctrl";
+		reg = <0x03860000 0x1000>;
+		interrupts = <0 47 0>;
+	};
 };
-- 
1.9.3
