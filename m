From: giulio.benetti@micronovasrl.com (Giulio Benetti)
Date: Wed, 21 Mar 2018 21:03:10 +0100
Subject: [PATCH 4/7] ARM: dts: sun7i: Add pinmux settings for LCD0 RGB888
 output.
In-Reply-To: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
Message-ID: <1521662593-25468-4-git-send-email-giulio.benetti@micronovasrl.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A20 supports RGB888 with H/V sync from LCD0. Add a pinmux setting
for the needed pins.

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index efb5607..bfe6728 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -922,6 +922,14 @@
 				pins = "PI20", "PI21";
 				function = "uart7";
 			};
+
+			lcd0_rgb888_pins: lcd0-rgb888-pins {
+				pins = "PD0", "PD1", "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
+				       "PD8", "PD9", "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
+				       "PD16", "PD17", "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
+				       "PD24", "PD25", "PD26", "PD27";
+				function = "lcd0";
+			};
 		};
 
 		timer at 1c20c00 {
-- 
2.7.4
