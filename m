From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Wed,  7 Oct 2015 11:08:59 +0200
Subject: [PATCH v4 4/4] ARM: STi: DT: Add support for stih418 A9 pll
In-Reply-To: <1444208939-10233-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1444208939-10233-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1444208939-10233-5-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for new PLL-type for stih418 A9-PLL.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 arch/arm/boot/dts/stih418-clock.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
index 148e177..ae6d997 100644
--- a/arch/arm/boot/dts/stih418-clock.dtsi
+++ b/arch/arm/boot/dts/stih418-clock.dtsi
@@ -44,7 +44,7 @@
 
 			clockgen_a9_pll: clockgen-a9-pll {
 				#clock-cells = <1>;
-				compatible = "st,stih407-plls-c32-a9", "st,clkgen-plls-c32";
+				compatible = "st,stih418-plls-c28-a9", "st,clkgen-plls-c32";
 
 				clocks = <&clk_sysin>;
 
-- 
1.9.1
