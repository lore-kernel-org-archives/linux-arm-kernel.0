From: t.figa@samsung.com (Tomasz Figa)
Date: Fri, 21 Sep 2012 16:22:57 +0200
Subject: [RFC PATCH 6/6] ARM: dts: exynos4210: Update pin bank nodes to reflect
 per-bank GPIO chips and IRQ domains
In-Reply-To: <1348237377-21299-1-git-send-email-t.figa@samsung.com>
References: <1348237377-21299-1-git-send-email-t.figa@samsung.com>
Message-ID: <1348237377-21299-7-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modifies device tree sources of Exynos4210 to match the
changes done to pinctrl-samsung driver.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
---
 arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi | 72 +++++++++++++++++++++++++
 arch/arm/boot/dts/exynos4210.dtsi               |  4 --
 2 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi b/arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi
index cac7f71..c3795e4 100644
--- a/arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi
+++ b/arch/arm/boot/dts/exynos4210-pinctrl-banks.dtsi
@@ -24,9 +24,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x00>;
+			#interrupt-cells = <2>;
 		};
 
 		gpa1: pin-bank at 1 {
@@ -39,9 +41,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x04>;
+			#interrupt-cells = <2>;
 		};
 
 		gpb: pin-bank at 2 {
@@ -54,9 +58,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x08>;
+			#interrupt-cells = <2>;
 		};
 
 		gpc0: pin-bank at 3 {
@@ -69,9 +75,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x0C>;
+			#interrupt-cells = <2>;
 		};
 
 		gpc1: pin-bank at 4 {
@@ -84,9 +92,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x10>;
+			#interrupt-cells = <2>;
 		};
 
 		gpd0: pin-bank at 5 {
@@ -99,9 +109,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x14>;
+			#interrupt-cells = <2>;
 		};
 
 		gpd1: pin-bank at 6 {
@@ -114,9 +126,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x18>;
+			#interrupt-cells = <2>;
 		};
 
 		gpe0: pin-bank at 7 {
@@ -129,9 +143,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x1C>;
+			#interrupt-cells = <2>;
 		};
 
 		gpe1: pin-bank at 8 {
@@ -144,9 +160,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x20>;
+			#interrupt-cells = <2>;
 		};
 
 		gpe2: pin-bank at 9 {
@@ -159,9 +177,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x24>;
+			#interrupt-cells = <2>;
 		};
 
 		gpe3: pin-bank at 10 {
@@ -174,9 +194,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x28>;
+			#interrupt-cells = <2>;
 		};
 
 		gpe4: pin-bank at 11 {
@@ -189,9 +211,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x2C>;
+			#interrupt-cells = <2>;
 		};
 
 		gpf0: pin-bank at 12 {
@@ -204,9 +228,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x30>;
+			#interrupt-cells = <2>;
 		};
 
 		gpf1: pin-bank at 13 {
@@ -219,9 +245,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x34>;
+			#interrupt-cells = <2>;
 		};
 
 		gpf2: pin-bank at 14 {
@@ -234,9 +262,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x38>;
+			#interrupt-cells = <2>;
 		};
 
 		gpf3: pin-bank at 15 {
@@ -249,9 +279,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x3C>;
+			#interrupt-cells = <2>;
 		};
 	};
 
@@ -266,9 +298,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x00>;
+			#interrupt-cells = <2>;
 		};
 
 		gpj1: pin-bank at 1 {
@@ -281,9 +315,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x04>;
+			#interrupt-cells = <2>;
 		};
 
 		gpk0: pin-bank at 2 {
@@ -296,9 +332,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x08>;
+			#interrupt-cells = <2>;
 		};
 
 		gpk1: pin-bank at 3 {
@@ -311,9 +349,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x0C>;
+			#interrupt-cells = <2>;
 		};
 
 		gpk2: pin-bank at 4 {
@@ -326,9 +366,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x10>;
+			#interrupt-cells = <2>;
 		};
 
 		gpk3: pin-bank at 5 {
@@ -341,9 +383,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x14>;
+			#interrupt-cells = <2>;
 		};
 
 		gpl0: pin-bank at 6 {
@@ -356,9 +400,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x18>;
+			#interrupt-cells = <2>;
 		};
 
 		gpl1: pin-bank at 7 {
@@ -371,9 +417,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x1C>;
+			#interrupt-cells = <2>;
 		};
 
 		gpl2: pin-bank at 8 {
@@ -386,9 +434,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x20>;
+			#interrupt-cells = <2>;
 		};
 
 		gpm0: pin-bank at 9 {
@@ -401,9 +451,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x24>;
+			#interrupt-cells = <2>;
 		};
 
 		gpm1: pin-bank at 10 {
@@ -416,9 +468,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x28>;
+			#interrupt-cells = <2>;
 		};
 
 		gpm2: pin-bank at 11 {
@@ -431,9 +485,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x2C>;
+			#interrupt-cells = <2>;
 		};
 
 		gpm3: pin-bank at 12 {
@@ -446,9 +502,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x30>;
+			#interrupt-cells = <2>;
 		};
 
 		gpm4: pin-bank at 13 {
@@ -461,9 +519,11 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 
 			interrupt-controller;
 			samsung,eint-offset = <0x34>;
+			#interrupt-cells = <2>;
 		};
 
 		gpy0: pin-bank at 14 {
@@ -476,6 +536,7 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 		};
 
 		gpy1: pin-bank at 15 {
@@ -488,6 +549,7 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 		};
 
 		gpy2: pin-bank at 16 {
@@ -500,6 +562,7 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 		};
 
 		gpy3: pin-bank at 17 {
@@ -512,6 +575,7 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 		};
 
 		gpy4: pin-bank at 18 {
@@ -524,6 +588,7 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 		};
 
 		gpy5: pin-bank at 19{
@@ -536,6 +601,7 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 		};
 
 		gpy6: pin-bank at 20 {
@@ -548,6 +614,7 @@
 			samsung,drv-width = <2>;
 			samsung,conpdn-width = <2>;
 			samsung,pudpdn-width = <2>;
+			#gpio-cells = <2>;
 		};
 
 		gpx0: pin-bank at 21 {
@@ -558,6 +625,7 @@
 			samsung,func-width = <4>;
 			samsung,pud-width = <2>;
 			samsung,drv-width = <2>;
+			#gpio-cells = <2>;
 		};
 
 		gpx1: pin-bank at 22 {
@@ -568,6 +636,7 @@
 			samsung,func-width = <4>;
 			samsung,pud-width = <2>;
 			samsung,drv-width = <2>;
+			#gpio-cells = <2>;
 		};
 
 		gpx2: pin-bank at 23 {
@@ -578,6 +647,7 @@
 			samsung,func-width = <4>;
 			samsung,pud-width = <2>;
 			samsung,drv-width = <2>;
+			#gpio-cells = <2>;
 		};
 
 		gpx3: pin-bank at 24 {
@@ -588,6 +658,7 @@
 			samsung,func-width = <4>;
 			samsung,pud-width = <2>;
 			samsung,drv-width = <2>;
+			#gpio-cells = <2>;
 		};
 	};
 
@@ -600,6 +671,7 @@
 			samsung,func-width = <4>;
 			samsung,pud-width = <2>;
 			samsung,drv-width = <2>;
+			#gpio-cells = <2>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
index 0e93717..de6308b 100644
--- a/arch/arm/boot/dts/exynos4210.dtsi
+++ b/arch/arm/boot/dts/exynos4210.dtsi
@@ -58,24 +58,20 @@
 		compatible = "samsung,pinctrl-exynos4210";
 		reg = <0x11400000 0x1000>;
 		interrupts = <0 47 0>;
-		interrupt-controller;
 		samsung,geint-con = <0x700>;
 		samsung,geint-mask = <0x900>;
 		samsung,geint-pend = <0xA00>;
 		samsung,svc = <0xB08>;
-		#interrupt-cells = <2>;
 	};
 
 	pinctrl_1: pinctrl at 11000000 {
 		compatible = "samsung,pinctrl-exynos4210";
 		reg = <0x11000000 0x1000>;
 		interrupts = <0 46 0>;
-		interrupt-controller;
 		samsung,geint-con = <0x700>;
 		samsung,geint-mask = <0x900>;
 		samsung,geint-pend = <0xA00>;
 		samsung,svc = <0xB08>;
-		#interrupt-cells = <2>;
 
 		wakup_eint: wakeup-interrupt-controller {
 			compatible = "samsung,exynos4210-wakeup-eint";
-- 
1.7.12
