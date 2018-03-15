From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Mar 2018 19:41:35 +0800
Subject: [PATCH 7/8] ARM: dts: sun9i: Add pinmux settings for LCD0 RGB888
 output.
In-Reply-To: <20180315114136.24747-1-wens@csie.org>
References: <20180315114136.24747-1-wens@csie.org>
Message-ID: <20180315114136.24747-8-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 supports RGB888 with H/V sync from LCD0. Add a pinmux setting
for the needed pins.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 6fdb4eaa2e04..25591d6883ef 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -953,6 +953,17 @@
 				function = "i2c3";
 			};
 
+			lcd0_rgb888_pins: lcd0-rgb888-pins {
+				pins = "PD0", "PD1", "PD2", "PD3",
+				       "PD4", "PD5", "PD6", "PD7",
+				       "PD8", "PD9", "PD10", "PD11",
+				       "PD12", "PD13", "PD14", "PD15",
+				       "PD16", "PD17", "PD18", "PD19",
+				       "PD20", "PD21", "PD22", "PD23",
+				       "PD24", "PD25", "PD26", "PD27";
+				function = "lcd0";
+			};
+
 			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1" ,"PF2", "PF3",
 				       "PF4", "PF5";
-- 
2.16.2
