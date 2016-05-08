From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  8 May 2016 21:05:54 +0200
Subject: [PATCH v2 09/22] ARM: dts: exynos: Re-order alphabetically Exynos5420
 SD0/SD1 pinctrl nodes
In-Reply-To: <1462734367-5619-1-git-send-email-krzk@kernel.org>
References: <1462734367-5619-1-git-send-email-krzk@kernel.org>
Message-ID: <1462734367-5619-10-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'sd0_rclk' was put in the middle of SD1 nodes. Remove the confusion.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
index 130563b2ca95..14beb7e07323 100644
--- a/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos5420-pinctrl.dtsi
@@ -193,17 +193,17 @@
 		samsung,pin-drv = <3>;
 	};
 
-	sd1_clk: sd1-clk {
-		samsung,pins = "gpc1-0";
+	sd0_rclk: sd0-rclk {
+		samsung,pins = "gpc0-7";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <0>;
+		samsung,pin-pud = <1>;
 		samsung,pin-drv = <3>;
 	};
 
-	sd0_rclk: sd0-rclk {
-		samsung,pins = "gpc0-7";
+	sd1_clk: sd1-clk {
+		samsung,pins = "gpc1-0";
 		samsung,pin-function = <2>;
-		samsung,pin-pud = <1>;
+		samsung,pin-pud = <0>;
 		samsung,pin-drv = <3>;
 	};
 
-- 
2.5.0
