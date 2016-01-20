From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Wed, 20 Jan 2016 14:09:21 +0100
Subject: [PATCH 3/4] ARM: dts: imx53: add display timing for NL12880BC20
In-Reply-To: <1453295362-18798-1-git-send-email-LW@KARO-electronics.de>
References: <1453295362-18798-1-git-send-email-LW@KARO-electronics.de>
Message-ID: <1453295362-18798-4-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Lothar Wa?mann <LW@KARO-electronics.de>
---
 arch/arm/boot/dts/imx53-tx53-x13x.dts | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53-tx53-x13x.dts b/arch/arm/boot/dts/imx53-tx53-x13x.dts
index 6d0b526..97d531c 100644
--- a/arch/arm/boot/dts/imx53-tx53-x13x.dts
+++ b/arch/arm/boot/dts/imx53-tx53-x13x.dts
@@ -203,7 +203,23 @@
 				hsync-active = <0>;
 				vsync-active = <0>;
 				de-active = <1>;
-				pixelclk-active = <0>;
+				pixelclk-active = <1>;
+			};
+
+			lvds0_timing1: nl12880bc20 {
+				clock-frequency = <71000000>;
+				hactive = <1280>;
+				vactive = <800>;
+				hback-porch = <50>;
+				hsync-len = <60>;
+				hfront-porch = <50>;
+				vback-porch = <5>;
+				vsync-len = <13>;
+				vfront-porch = <5>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <1>;
 			};
 		};
 	};
@@ -229,7 +245,7 @@
 				hsync-active = <0>;
 				vsync-active = <0>;
 				de-active = <1>;
-				pixelclk-active = <0>;
+				pixelclk-active = <1>;
 			};
 		};
 	};
-- 
2.1.4
