From: lee.jones@linaro.org (Lee Jones)
Date: Mon,  3 Jun 2013 14:42:32 +0100
Subject: [PATCH 08/21] ARM: ux500: Supply the I2C clocks lookup to the DBX500
 DT
In-Reply-To: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
References: <1370266965-7901-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1370266965-7901-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/dbx5x0.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/dbx5x0.dtsi b/arch/arm/boot/dts/dbx5x0.dtsi
index 3acc528..659865d 100644
--- a/arch/arm/boot/dts/dbx5x0.dtsi
+++ b/arch/arm/boot/dts/dbx5x0.dtsi
@@ -559,6 +559,8 @@
 			v-i2c-supply = <&db8500_vape_reg>;
 
 			clock-frequency = <400000>;
+			clocks = <&clk 100>, <&clk 67>;
+			clock-names = "nmk-i2c.0", "apb_pclk";
 		};
 
 		i2c at 80122000 {
@@ -572,6 +574,9 @@
 			v-i2c-supply = <&db8500_vape_reg>;
 
 			clock-frequency = <400000>;
+
+			clocks = <&clk 85>, <&clk 42>;
+			clock-names = "nmk-i2c.1", "apb_pclk";
 		};
 
 		i2c at 80128000 {
@@ -585,6 +590,9 @@
 			v-i2c-supply = <&db8500_vape_reg>;
 
 			clock-frequency = <400000>;
+
+			clocks = <&clk 89>, <&clk 46>;
+			clock-names = "nmk-i2c.2", "apb_pclk";
 		};
 
 		i2c at 80110000 {
@@ -598,6 +606,9 @@
 			v-i2c-supply = <&db8500_vape_reg>;
 
 			clock-frequency = <400000>;
+
+			clocks = <&clk 93>, <&clk 52>;
+			clock-names = "nmk-i2c.3", "apb_pclk";
 		};
 
 		i2c at 8012a000 {
@@ -611,6 +622,9 @@
 			v-i2c-supply = <&db8500_vape_reg>;
 
 			clock-frequency = <400000>;
+
+			clocks = <&clk 91>, <&clk 50>;
+			clock-names = "nmk-i2c.4", "apb_pclk";
 		};
 
 		ssp at 80002000 {
-- 
1.7.10.4
