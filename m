From: sjg@chromium.org (Simon Glass)
Date: Fri,  3 Jul 2015 17:07:01 -0600
Subject: [PATCH v2] tegra: Enable TPM on tegra124 nyan boards
Message-ID: <1435964821-15251-1-git-send-email-sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Regenerate the pinmux from the latest tegra-pinmux-scripts. This adds the
pinmux settings for the TPM.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Correct USB changes in nyan-blaze

 arch/arm/boot/dts/tegra124-nyan-big.dts   | 20 ++++++++++----------
 arch/arm/boot/dts/tegra124-nyan-blaze.dts | 20 ++++++++++----------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts b/arch/arm/boot/dts/tegra124-nyan-big.dts
index 2d21253..c2955c9 100644
--- a/arch/arm/boot/dts/tegra124-nyan-big.dts
+++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
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
index 0d30c51..bef31a8 100644
--- a/arch/arm/boot/dts/tegra124-nyan-blaze.dts
+++ b/arch/arm/boot/dts/tegra124-nyan-blaze.dts
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
2.4.3.573.g4eafbef
