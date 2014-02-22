From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 22 Feb 2014 22:35:58 +0100
Subject: [PATCH 6/7] ARM: dt: sun7i: Add SPI muxing options
In-Reply-To: <1393104959-12831-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1393104959-12831-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1393104959-12831-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 0f0ee58..6161fd8 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -571,6 +571,20 @@
 				allwinner,drive = <3>;
 				allwinner,pull = <0>;
 			};
+
+			spi1_pins_a: spi1 at 0 {
+				allwinner,pins = "PI16", "PI17", "PI18", "PI19";
+				allwinner,function = "spi1";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
+
+			spi2_pins_a: spi2 at 0 {
+				allwinner,pins = "PC19", "PC20", "PC21", "PC22";
+				allwinner,function = "spi2";
+				allwinner,drive = <0>;
+				allwinner,pull = <0>;
+			};
 		};
 
 		timer at 01c20c00 {
-- 
1.9.0
