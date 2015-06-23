From: gabriel.fernandez@linaro.org (Gabriel Fernandez)
Date: Tue, 23 Jun 2015 16:09:27 +0200
Subject: [PATCH 9/9] ARM: STi: DT: Rename st_pll3200c32_407_c0_x into
 st_pll3200c32_cx_x
In-Reply-To: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
References: <1435068567-30995-1-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <1435068567-30995-10-git-send-email-gabriel.fernandez@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use a generic name for this kind of PLL

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
---
 Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt | 4 ++--
 arch/arm/boot/dts/stih407-clock.dtsi                         | 4 ++--
 arch/arm/boot/dts/stih410-clock.dtsi                         | 4 ++--
 arch/arm/boot/dts/stih418-clock.dtsi                         | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt b/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
index efb51cf..d8b168e 100644
--- a/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
+++ b/Documentation/devicetree/bindings/clock/st/st,clkgen-pll.txt
@@ -21,8 +21,8 @@ Required properties:
 	"st,stih416-plls-c32-ddr",	"st,clkgen-plls-c32"
 	"st,stih407-plls-c32-a0",	"st,clkgen-plls-c32"
 	"st,stih407-plls-c32-a9",	"st,clkgen-plls-c32"
-	"st,stih407-plls-c32-c0_0",	"st,clkgen-plls-c32"
-	"st,stih407-plls-c32-c0_1",	"st,clkgen-plls-c32"
+	"sst,plls-c32-cx_0",		"st,clkgen-plls-c32"
+	"sst,plls-c32-cx_1",		"st,clkgen-plls-c32"
 
 	"st,stih415-gpu-pll-c32",	"st,clkgengpu-pll-c32"
 	"st,stih416-gpu-pll-c32",	"st,clkgengpu-pll-c32"
diff --git a/arch/arm/boot/dts/stih407-clock.dtsi b/arch/arm/boot/dts/stih407-clock.dtsi
index e65744f..ad45f5e 100644
--- a/arch/arm/boot/dts/stih407-clock.dtsi
+++ b/arch/arm/boot/dts/stih407-clock.dtsi
@@ -134,7 +134,7 @@
 
 			clk_s_c0_pll0: clk-s-c0-pll0 {
 				#clock-cells = <1>;
-				compatible = "st,stih407-plls-c32-c0_0", "st,clkgen-plls-c32";
+				compatible = "st,plls-c32-cx_0", "st,clkgen-plls-c32";
 
 				clocks = <&clk_sysin>;
 
@@ -143,7 +143,7 @@
 
 			clk_s_c0_pll1: clk-s-c0-pll1 {
 				#clock-cells = <1>;
-				compatible = "st,stih407-plls-c32-c0_1", "st,clkgen-plls-c32";
+				compatible = "st,plls-c32-cx_1", "st,clkgen-plls-c32";
 
 				clocks = <&clk_sysin>;
 
diff --git a/arch/arm/boot/dts/stih410-clock.dtsi b/arch/arm/boot/dts/stih410-clock.dtsi
index 6b5803a..d1f2aca 100644
--- a/arch/arm/boot/dts/stih410-clock.dtsi
+++ b/arch/arm/boot/dts/stih410-clock.dtsi
@@ -137,7 +137,7 @@
 
 			clk_s_c0_pll0: clk-s-c0-pll0 {
 				#clock-cells = <1>;
-				compatible = "st,stih407-plls-c32-c0_0", "st,clkgen-plls-c32";
+				compatible = "st,plls-c32-cx_0", "st,clkgen-plls-c32";
 
 				clocks = <&clk_sysin>;
 
@@ -146,7 +146,7 @@
 
 			clk_s_c0_pll1: clk-s-c0-pll1 {
 				#clock-cells = <1>;
-				compatible = "st,stih407-plls-c32-c0_1", "st,clkgen-plls-c32";
+				compatible = "st,plls-c32-cx_1", "st,clkgen-plls-c32";
 
 				clocks = <&clk_sysin>;
 
diff --git a/arch/arm/boot/dts/stih418-clock.dtsi b/arch/arm/boot/dts/stih418-clock.dtsi
index 0ab23da..148e177 100644
--- a/arch/arm/boot/dts/stih418-clock.dtsi
+++ b/arch/arm/boot/dts/stih418-clock.dtsi
@@ -137,7 +137,7 @@
 
 			clk_s_c0_pll0: clk-s-c0-pll0 {
 				#clock-cells = <1>;
-				compatible = "st,stih407-plls-c32-c0_0", "st,clkgen-plls-c32";
+				compatible = "st,plls-c32-cx_0", "st,clkgen-plls-c32";
 
 				clocks = <&clk_sysin>;
 
@@ -146,7 +146,7 @@
 
 			clk_s_c0_pll1: clk-s-c0-pll1 {
 				#clock-cells = <1>;
-				compatible = "st,stih407-plls-c32-c0_1", "st,clkgen-plls-c32";
+				compatible = "st,plls-c32-cx_1", "st,clkgen-plls-c32";
 
 				clocks = <&clk_sysin>;
 
-- 
1.9.1
