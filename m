From: contact@paulk.fr (Paul Kocialkowski)
Date: Sun,  6 May 2018 22:56:18 +0200
Subject: [PATCH 2/3] ARM: dts: sun7i: Add RGB666 pins definition
In-Reply-To: <20180506205619.5591-1-contact@paulk.fr>
References: <20180506205619.5591-1-contact@paulk.fr>
Message-ID: <20180506205619.5591-2-contact@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the pins definition for RGB666 LCD panels on the A20. It was
inspired by the A33 definition, that concernes the same set of pins.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e529e4ff2174..b3ee36cd7fa7 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -781,6 +781,14 @@
 				function = "ir1";
 			};
 
+			lcd0_rgb666_pins: lcd0-rgb666 {
+				pins = "PD2", "PD3", "PD4", "PD5", "PD6", "PD7",
+				       "PD10", "PD11", "PD12", "PD13", "PD14", "PD15",
+				       "PD18", "PD19", "PD20", "PD21", "PD22", "PD23",
+				       "PD24", "PD25", "PD26", "PD27";
+				function = "lcd0";
+			};
+
 			mmc0_pins_a: mmc0 at 0 {
 				pins = "PF0", "PF1", "PF2",
 				       "PF3", "PF4", "PF5";
-- 
2.17.0
