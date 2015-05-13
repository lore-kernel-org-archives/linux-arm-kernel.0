From: sjg@chromium.org (Simon Glass)
Date: Wed, 13 May 2015 08:13:47 -0600
Subject: [PATCH] ARM: tegra: Enable TPM on tegra124 nyan boards
Message-ID: <1431526427-13340-1-git-send-email-sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regenerate the pinmux from the latest tegra-pinmux-scripts.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/boot/dts/tegra124-nyan-big.dts   | 22 +++++++++++-----------
 arch/arm/boot/dts/tegra124-nyan-blaze.dts | 30 +++++++++++++++---------------
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts b/arch/arm/boot/dts/tegra124-nyan-big.dts
index 2d21253..0eb2b0f 100644
--- a/arch/arm/boot/dts/tegra124-nyan-big.dts
+++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
@@ -30,7 +30,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinmux_default>;
 
-		pinmux_default: common {
+		state_default: pinmux {
 			clk_32k_out_pa0 {
 				nvidia,pins = "clk_32k_out_pa0";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -1098,19 +1098,19 @@
 			};
 			cam_i2c_scl_pbb1 {
 				nvidia,pins = "cam_i2c_scl_pbb1";
-				nvidia,function = "rsvd3";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
-				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
 			cam_i2c_sda_pbb2 {
 				nvidia,pins = "cam_i2c_sda_pbb2";
-				nvidia,function = "rsvd3";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
-				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
 			pbb3 {
 				nvidia,pins = "pbb3";
diff --git a/arch/arm/boot/dts/tegra124-nyan-blaze.dts b/arch/arm/boot/dts/tegra124-nyan-blaze.dts
index 0d30c51..1fc0da9 100644
--- a/arch/arm/boot/dts/tegra124-nyan-blaze.dts
+++ b/arch/arm/boot/dts/tegra124-nyan-blaze.dts
@@ -26,7 +26,7 @@
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinmux_default>;
 
-		pinmux_default: common {
+		state_default: pinmux {
 			clk_32k_out_pa0 {
 				nvidia,pins = "clk_32k_out_pa0";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
@@ -437,18 +437,18 @@
 			usb_vbus_en0_pn4 {
 				nvidia,pins = "usb_vbus_en0_pn4";
 				nvidia,function = "usb";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
 			usb_vbus_en1_pn5 {
 				nvidia,pins = "usb_vbus_en1_pn5";
 				nvidia,function = "usb";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
 			hdmi_int_pn7 {
 				nvidia,pins = "hdmi_int_pn7";
@@ -1094,19 +1094,19 @@
 			};
 			cam_i2c_scl_pbb1 {
 				nvidia,pins = "cam_i2c_scl_pbb1";
-				nvidia,function = "rsvd3";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
-				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
 			cam_i2c_sda_pbb2 {
 				nvidia,pins = "cam_i2c_sda_pbb2";
-				nvidia,function = "rsvd3";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
-				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
+				nvidia,function = "i2c3";
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
 			};
 			pbb3 {
 				nvidia,pins = "pbb3";
-- 
2.2.0.rc0.207.ga3a616c
