From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 19 Jul 2013 14:58:40 +0100
Subject: [PATCH 09/22] ARM: ux500: Remove '0x's from Exynos5250 DTS file
In-Reply-To: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
References: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1374242333-6852-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: linux-samsung-soc at vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/exynos5250.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index ef57277..24c0888 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -68,17 +68,17 @@
 		};
 	};
 
-	pd_gsc: gsc-power-domain at 0x10044000 {
+	pd_gsc: gsc-power-domain at 10044000 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044000 0x20>;
 	};
 
-	pd_mfc: mfc-power-domain at 0x10044040 {
+	pd_mfc: mfc-power-domain at 10044040 {
 		compatible = "samsung,exynos4210-pd";
 		reg = <0x10044040 0x20>;
 	};
 
-	clock: clock-controller at 0x10010000 {
+	clock: clock-controller at 10010000 {
 		compatible = "samsung,exynos5250-clock";
 		reg = <0x10010000 0x30000>;
 		#clock-cells = <1>;
@@ -562,7 +562,7 @@
 		};
 	};
 
-	gsc_0:  gsc at 0x13e00000 {
+	gsc_0:  gsc at 13e00000 {
 		compatible = "samsung,exynos5-gsc";
 		reg = <0x13e00000 0x1000>;
 		interrupts = <0 85 0>;
@@ -571,7 +571,7 @@
 		clock-names = "gscl";
 	};
 
-	gsc_1:  gsc at 0x13e10000 {
+	gsc_1:  gsc at 13e10000 {
 		compatible = "samsung,exynos5-gsc";
 		reg = <0x13e10000 0x1000>;
 		interrupts = <0 86 0>;
@@ -580,7 +580,7 @@
 		clock-names = "gscl";
 	};
 
-	gsc_2:  gsc at 0x13e20000 {
+	gsc_2:  gsc at 13e20000 {
 		compatible = "samsung,exynos5-gsc";
 		reg = <0x13e20000 0x1000>;
 		interrupts = <0 87 0>;
@@ -589,7 +589,7 @@
 		clock-names = "gscl";
 	};
 
-	gsc_3:  gsc at 0x13e30000 {
+	gsc_3:  gsc at 13e30000 {
 		compatible = "samsung,exynos5-gsc";
 		reg = <0x13e30000 0x1000>;
 		interrupts = <0 88 0>;
-- 
1.8.1.2
