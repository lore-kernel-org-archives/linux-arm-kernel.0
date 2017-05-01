From: wens@csie.org (Chen-Yu Tsai)
Date: Mon,  1 May 2017 11:14:08 +0800
Subject: [PATCH v2 2/2] ARM: sun8i: a83t: Replace underscores with hyphens in
 pinmux node names
In-Reply-To: <20170501031408.10469-1-wens@csie.org>
References: <20170501031408.10469-1-wens@csie.org>
Message-ID: <20170501031408.10469-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We should use hyphens and not underscores in device node names.

Replace the ones that were just added.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index aecde8be53bc..c0a1e4f74b89 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -174,7 +174,7 @@
 			#interrupt-cells = <3>;
 			#gpio-cells = <3>;
 
-			mmc0_pins: mmc0_pins {
+			mmc0_pins: mmc0-pins {
 				pins = "PF0", "PF1", "PF2",
 				       "PF3", "PF4", "PF5";
 				function = "mmc0";
@@ -182,12 +182,12 @@
 				bias-pull-up;
 			};
 
-			uart0_pb_pins: uart0_pb_pins {
+			uart0_pb_pins: uart0-pb-pins {
 				pins = "PB9", "PB10";
 				function = "uart0";
 			};
 
-			uart0_pf_pins: uart0_pf_pins {
+			uart0_pf_pins: uart0-pf-pins {
 				pins = "PF2", "PF4";
 				function = "uart0";
 			};
-- 
2.11.0
