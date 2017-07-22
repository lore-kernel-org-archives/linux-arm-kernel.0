From: codekipper@gmail.com (codekipper at gmail.com)
Date: Sat, 22 Jul 2017 08:43:13 +0200
Subject: [linux-sunxi][PATCH] ARM: dts: sun7i: Add I2S0 pinctrl settings
Message-ID: <20170722064313.7535-1-codekipper@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcus Cooper <codekipper@gmail.com>

The A20 SoC has a couple of i2s blocks. This patch adds
the pinctrl settings for block i2s0.

Signed-off-by: Marcus Cooper <codekipper@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 96bee776e145..01f9ee329913 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -1163,6 +1163,31 @@
 				function = "i2c3";
 			};
 
+			i2s0_mclk: i2s0 at 0 {
+				pins = "PB5";
+				function = "i2s0";
+			};
+
+			i2s0_bclk: i2s0 at 1 {
+				pins = "PB6";
+				function = "i2s0";
+			};
+
+			i2s0_lrclk: i2s0 at 2 {
+				pins = "PB7";
+				function = "i2s0";
+			};
+
+			i2s0_sdo0: i2s0 at 3 {
+				pins = "PB8";
+				function = "i2s0";
+			};
+
+			i2s0_sdi: i2s0 at 4 {
+				pins = "PB12";
+				function = "i2s0";
+			};
+
 			ir0_rx_pins_a: ir0 at 0 {
 				pins = "PB4";
 				function = "ir0";
-- 
2.13.3
