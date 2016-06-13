From: manu@freebsd.org (Emmanuel Vadot)
Date: Mon, 13 Jun 2016 22:37:04 +0200
Subject: [PATCH 1/3] dt-bindings: Change compatible string to "allwinner,
 sun6i-a31-mmc" for A31, A23-A33 and H3.
In-Reply-To: <1465850226-37420-1-git-send-email-manu@freebsd.org>
References: <1465850226-37420-1-git-send-email-manu@freebsd.org>
Message-ID: <1465850226-37420-2-git-send-email-manu@freebsd.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm/boot/dts/sun6i-a31.dtsi     | 8 ++++----
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 6 +++---
 arch/arm/boot/dts/sun8i-h3.dtsi      | 6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 1867af2..6163256 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -469,7 +469,7 @@
 		};
 
 		mmc0: mmc at 01c0f000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun6i-a31-mmc";
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&ahb1_gates 8>,
 				 <&mmc0_clk 0>,
@@ -488,7 +488,7 @@
 		};
 
 		mmc1: mmc at 01c10000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun6i-a31-mmc";
 			reg = <0x01c10000 0x1000>;
 			clocks = <&ahb1_gates 9>,
 				 <&mmc1_clk 0>,
@@ -507,7 +507,7 @@
 		};
 
 		mmc2: mmc at 01c11000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun6i-a31-mmc";
 			reg = <0x01c11000 0x1000>;
 			clocks = <&ahb1_gates 10>,
 				 <&mmc2_clk 0>,
@@ -526,7 +526,7 @@
 		};
 
 		mmc3: mmc at 01c12000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun6i-a31-mmc";
 			reg = <0x01c12000 0x1000>;
 			clocks = <&ahb1_gates 11>,
 				 <&mmc3_clk 0>,
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 7e05e09..9275d11 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -266,7 +266,7 @@
 		};
 
 		mmc0: mmc at 01c0f000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun6i-a31-mmc";
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&ahb1_gates 8>,
 				 <&mmc0_clk 0>,
@@ -285,7 +285,7 @@
 		};
 
 		mmc1: mmc at 01c10000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun6i-a31-mmc";
 			reg = <0x01c10000 0x1000>;
 			clocks = <&ahb1_gates 9>,
 				 <&mmc1_clk 0>,
@@ -304,7 +304,7 @@
 		};
 
 		mmc2: mmc at 01c11000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun6i-a31-mmc";
 			reg = <0x01c11000 0x1000>;
 			clocks = <&ahb1_gates 10>,
 				 <&mmc2_clk 0>,
diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index 4a4926b..b1edf73 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -333,7 +333,7 @@
 		};
 
 		mmc0: mmc at 01c0f000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun6i-a31-mmc";
 			reg = <0x01c0f000 0x1000>;
 			clocks = <&bus_gates 8>,
 				 <&mmc0_clk 0>,
@@ -352,7 +352,7 @@
 		};
 
 		mmc1: mmc at 01c10000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun6i-a31-mmc";
 			reg = <0x01c10000 0x1000>;
 			clocks = <&bus_gates 9>,
 				 <&mmc1_clk 0>,
@@ -371,7 +371,7 @@
 		};
 
 		mmc2: mmc at 01c11000 {
-			compatible = "allwinner,sun5i-a13-mmc";
+			compatible = "allwinner,sun6i-a31-mmc";
 			reg = <0x01c11000 0x1000>;
 			clocks = <&bus_gates 10>,
 				 <&mmc2_clk 0>,
-- 
2.8.1
