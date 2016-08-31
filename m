From: jsarha@ti.com (Jyri Sarha)
Date: Wed, 31 Aug 2016 16:14:12 +0300
Subject: [PATCH v3 7/8] ARM: dts: am335x-evmsk: Whitespace cleanup of lcdc
 related nodes
In-Reply-To: <cover.1472634657.git.jsarha@ti.com>
References: <cover.1472634657.git.jsarha@ti.com>
Message-ID: <becff9a54834d26720970ae8f81395fb820f6e3e.1472634657.git.jsarha@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Whitespace cleanup of lcdc related nodes. Do all indentation and
alignment with tabs instead of spaces.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 40 +++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 09308d6..23b94e7 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -170,29 +170,29 @@
 		pinctrl-1 = <&lcd_pins_sleep>;
 		status = "okay";
 		panel-info {
-			ac-bias           = <255>;
-			ac-bias-intrpt    = <0>;
-			dma-burst-sz      = <16>;
-			bpp               = <32>;
-			fdd               = <0x80>;
-			sync-edge         = <0>;
-			sync-ctrl         = <1>;
-			raster-order      = <0>;
-			fifo-th           = <0>;
+			ac-bias		= <255>;
+			ac-bias-intrpt	= <0>;
+			dma-burst-sz	= <16>;
+			bpp		= <32>;
+			fdd		= <0x80>;
+			sync-edge	= <0>;
+			sync-ctrl	= <1>;
+			raster-order	= <0>;
+			fifo-th		= <0>;
 		};
 		display-timings {
 			480x272 {
-				hactive         = <480>;
-				vactive         = <272>;
-				hback-porch     = <43>;
-				hfront-porch    = <8>;
-				hsync-len       = <4>;
-				vback-porch     = <12>;
-				vfront-porch    = <4>;
-				vsync-len       = <10>;
+				hactive		= <480>;
+				vactive		= <272>;
+				hback-porch	= <43>;
+				hfront-porch	= <8>;
+				hsync-len	= <4>;
+				vback-porch	= <12>;
+				vfront-porch	= <4>;
+				vsync-len	= <10>;
 				clock-frequency = <9000000>;
-				hsync-active    = <0>;
-				vsync-active    = <0>;
+				hsync-active	= <0>;
+				vsync-active	= <0>;
 			};
 		};
 	};
@@ -711,5 +711,5 @@
 };
 
 &lcdc {
-      status = "okay";
+	status = "okay";
 };
-- 
1.9.1
