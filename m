From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 23 Dec 2013 16:37:06 +0800
Subject: [PATCH 4/4] ARM: dts: sun7i: Add pin muxing options for clock outputs
In-Reply-To: <1387787827-11341-1-git-send-email-wens@csie.org>
References: <1387787827-11341-1-git-send-email-wens@csie.org>
Message-ID: <1387787827-11341-5-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 6ad5507..d6e7251 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -414,6 +414,20 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			clk_out_a_pins: clk_out_a {
+				allwinner,pins = "PI12";
+				allwinner,function = "clk_out_a";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			clk_out_b_pins: clk_out_b {
+				allwinner,pins = "PI13";
+				allwinner,function = "clk_out_b";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
1.8.5.2
