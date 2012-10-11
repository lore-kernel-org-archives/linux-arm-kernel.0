From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 11 Oct 2012 10:11:12 +0200
Subject: [PATCH 06/15] ARM: dts: exynos4210-pinctrl: Add nodes for pin banks
In-Reply-To: <1349943081-27939-1-git-send-email-t.figa@samsung.com>
References: <1349943081-27939-1-git-send-email-t.figa@samsung.com>
Message-ID: <1349943081-27939-7-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch is a preparation for converting the pinctrl-samsung driver to
one GPIO chip and IRQ domain per bank. It allows particular banks to be
specified using their phandles.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi | 272 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi         | 229 -------------------------
 2 files changed, 272 insertions(+), 229 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
index b12cf27..f207d8d 100644
--- a/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos4210-pinctrl.dtsi
@@ -16,6 +16,134 @@
 
 / {
 	pinctrl at 11400000 {
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
+		gpb: gpb {
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
+		gpc1: gpc1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpd0: gpd0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
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
+		gpe2: gpe2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpe3: gpe3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpe4: gpe4 {
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
+		gpf2: gpf2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpf3: gpf3 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
 		uart0_data: uart0-data {
 			samsung,pins = "gpa0-0", "gpa0-1";
 			samsung,pin-function = <0x2>;
@@ -205,6 +333,145 @@
 	};
 
 	pinctrl at 11000000 {
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
+
+		gpl0: gpl0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpl1: gpl1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpl2: gpl2 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
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
+		gpx0: gpx0 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		gpx1: gpx1 {
+			gpio-controller;
+			#gpio-cells = <2>;
+
+			interrupt-controller;
+			#interrupt-cells = <2>;
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
+
 		sd0_clk: sd0-clk {
 			samsung,pins = "gpk0-0";
 			samsung,pin-function = <2>;
@@ -438,6 +705,11 @@
 	};
 
 	pinctrl at 03860000 {
+		gpz: gpz {
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
 		i2s0_bus: i2s0-bus {
 			samsung,pins = "gpz-0", "gpz-1", "gpz-2", "gpz-3",
 					"gpz-4", "gpz-5", "gpz-6";
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 214c557..b768e9f 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -74,233 +74,4 @@
 		compatible = "samsung,pinctrl-exynos4210";
 		reg = <0x03860000 0x1000>;
 	};
-
-	gpio-controllers {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		gpio-controller;
-		ranges;
-
-		gpa0: gpio-controller at 11400000 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400000 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpa1: gpio-controller at 11400020 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400020 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpb: gpio-controller at 11400040 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400040 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpc0: gpio-controller at 11400060 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400060 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpc1: gpio-controller at 11400080 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400080 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpd0: gpio-controller at 114000A0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114000A0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpd1: gpio-controller at 114000C0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114000C0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpe0: gpio-controller at 114000E0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114000E0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpe1: gpio-controller at 11400100 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400100 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpe2: gpio-controller at 11400120 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400120 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpe3: gpio-controller at 11400140 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400140 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpe4: gpio-controller at 11400160 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400160 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpf0: gpio-controller at 11400180 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11400180 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpf1: gpio-controller at 114001A0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114001A0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpf2: gpio-controller at 114001C0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114001C0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpf3: gpio-controller at 114001E0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x114001E0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpj0: gpio-controller at 11000000 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11000000 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpj1: gpio-controller at 11000020 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11000020 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpk0: gpio-controller at 11000040 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11000040 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpk1: gpio-controller at 11000060 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11000060 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpk2: gpio-controller at 11000080 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11000080 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpk3: gpio-controller at 110000A0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x110000A0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpl0: gpio-controller at 110000C0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x110000C0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpl1: gpio-controller at 110000E0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x110000E0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpl2: gpio-controller at 11000100 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11000100 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy0: gpio-controller at 11000120 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11000120 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy1: gpio-controller at 11000140 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11000140 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy2: gpio-controller at 11000160 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11000160 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy3: gpio-controller at 11000180 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11000180 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy4: gpio-controller at 110001A0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x110001A0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy5: gpio-controller at 110001C0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x110001C0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpy6: gpio-controller at 110001E0 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x110001E0 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpx0: gpio-controller at 11000C00 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11000C00 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpx1: gpio-controller at 11000C20 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11000C20 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpx2: gpio-controller at 11000C40 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11000C40 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpx3: gpio-controller at 11000C60 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x11000C60 0x20>;
-			#gpio-cells = <4>;
-		};
-
-		gpz: gpio-controller at 03860000 {
-			compatible = "samsung,exynos4-gpio";
-			reg = <0x03860000 0x20>;
-			#gpio-cells = <4>;
-		};
-	};
 };
-- 
1.7.12
