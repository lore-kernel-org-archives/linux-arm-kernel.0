From: marcel.ziswiler@toradex.com (Marcel Ziswiler)
Date: Thu, 27 Aug 2015 11:44:48 +0200
Subject: [PATCH] arm: tegra: dtsi whitespace clean-up for tegra20,
 tegra30 and tegra124
Message-ID: <1440668688-17288-1-git-send-email-marcel.ziswiler@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There were a few cases of eight spaces being used instead of a tab
character plus one case of using two spaces after an equal sign instead
of just one which this patch fixes.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm/boot/dts/tegra124.dtsi |  2 +-
 arch/arm/boot/dts/tegra20.dtsi  |  4 ++--
 arch/arm/boot/dts/tegra30.dtsi  | 10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124.dtsi b/arch/arm/boot/dts/tegra124.dtsi
index 1e204a6..a5c878e 100644
--- a/arch/arm/boot/dts/tegra124.dtsi
+++ b/arch/arm/boot/dts/tegra124.dtsi
@@ -636,7 +636,7 @@
 		reg = <0x0 0x70030000 0x0 0x10000>;
 		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA124_CLK_HDA>,
-		         <&tegra_car TEGRA124_CLK_HDA2HDMI>,
+			 <&tegra_car TEGRA124_CLK_HDA2HDMI>,
 			 <&tegra_car TEGRA124_CLK_HDA2CODEC_2X>;
 		clock-names = "hda", "hda2hdmi", "hda2codec_2x";
 		resets = <&tegra_car 125>, /* hda */
diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
index e058709..0a8d1a6 100644
--- a/arch/arm/boot/dts/tegra20.dtsi
+++ b/arch/arm/boot/dts/tegra20.dtsi
@@ -601,8 +601,8 @@
 			 <&tegra_car TEGRA20_CLK_PLL_E>;
 		clock-names = "pex", "afi", "pll_e";
 		resets = <&tegra_car 70>,
-		         <&tegra_car 72>,
-		         <&tegra_car 74>;
+			 <&tegra_car 72>,
+			 <&tegra_car 74>;
 		reset-names = "pex", "afi", "pcie_x";
 		status = "disabled";
 
diff --git a/arch/arm/boot/dts/tegra30.dtsi b/arch/arm/boot/dts/tegra30.dtsi
index fe04fb5..38e1e27 100644
--- a/arch/arm/boot/dts/tegra30.dtsi
+++ b/arch/arm/boot/dts/tegra30.dtsi
@@ -42,8 +42,8 @@
 			 <&tegra_car TEGRA30_CLK_CML0>;
 		clock-names = "pex", "afi", "pll_e", "cml";
 		resets = <&tegra_car 70>,
-		         <&tegra_car 72>,
-		         <&tegra_car 74>;
+			 <&tegra_car 72>,
+			 <&tegra_car 74>;
 		reset-names = "pex", "afi", "pcie_x";
 		status = "disabled";
 
@@ -153,7 +153,7 @@
 				  &tegra_car TEGRA30_CLK_GR3D2>;
 			clock-names = "3d", "3d2";
 			resets = <&tegra_car 24>,
-			         <&tegra_car 98>;
+				 <&tegra_car 98>;
 			reset-names = "3d", "3d2";
 		};
 
@@ -455,7 +455,7 @@
 	};
 
 	i2c at 7000c000 {
-		compatible =  "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
+		compatible = "nvidia,tegra30-i2c", "nvidia,tegra20-i2c";
 		reg = <0x7000c000 0x100>;
 		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
 		#address-cells = <1>;
@@ -660,7 +660,7 @@
 		reg = <0x70030000 0x10000>;
 		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&tegra_car TEGRA30_CLK_HDA>,
-		         <&tegra_car TEGRA30_CLK_HDA2HDMI>,
+			 <&tegra_car TEGRA30_CLK_HDA2HDMI>,
 			 <&tegra_car TEGRA30_CLK_HDA2CODEC_2X>;
 		clock-names = "hda", "hda2hdmi", "hda2codec_2x";
 		resets = <&tegra_car 125>, /* hda */
-- 
2.4.3
