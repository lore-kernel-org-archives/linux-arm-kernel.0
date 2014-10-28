From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 28 Oct 2014 17:50:42 +0800
Subject: [PATCH 5/6] ARM: dts: sun9i: Add uart4 pinmux setting for A80 SoC
In-Reply-To: <1414489843-2680-1-git-send-email-wens@csie.org>
References: <1414489843-2680-1-git-send-email-wens@csie.org>
Message-ID: <1414489843-2680-6-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

uart4 only has one possible pinmux setting on the A80 SoC.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 653bb4d..2d744d2 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -374,6 +374,13 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			uart4_pins_a: uart4 at 0 {
+				allwinner,pins = "PG12", "PG13", "PG14", "PG15";
+				allwinner,function = "uart4";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		uart0: serial at 07000000 {
-- 
2.1.1
