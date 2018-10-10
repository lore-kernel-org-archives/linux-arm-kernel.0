From: contact@paulk.fr (Paul Kocialkowski)
Date: Wed, 10 Oct 2018 13:41:33 +0200
Subject: [PATCH 3/4] ARM: dts: sun7i: Add pinmux configuration for LCD0 RGB888
 pins
In-Reply-To: <20181010114134.8211-1-contact@paulk.fr>
References: <20181010114134.8211-1-contact@paulk.fr>
Message-ID: <20181010114134.8211-3-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the pin muxing definition for configuring the PD pins in LCD0
mode for a RGB888 format to the sun7i device-tree.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 02e40da9f028..684dd008039d 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -837,6 +837,17 @@
 				function = "ir1";
 			};
 
+			lcd0_rgb888_pins: lcd0-rgb888 {
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
 			mmc0_pins_a: mmc0 at 0 {
 				pins = "PF0", "PF1", "PF2",
 				       "PF3", "PF4", "PF5";
-- 
2.19.0
