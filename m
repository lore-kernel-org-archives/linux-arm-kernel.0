From: gary.bisson@boundarydevices.com (Gary Bisson)
Date: Tue, 25 Oct 2016 23:19:54 +0200
Subject: [PATCH 4/5] ARM: dts: imx6qdl-nitrogen6x: rename panel nodes
In-Reply-To: <20161025211955.5345-1-gary.bisson@boundarydevices.com>
References: <20161025211955.5345-1-gary.bisson@boundarydevices.com>
Message-ID: <20161025211955.5345-5-gary.bisson@boundarydevices.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So it is in line with other Boundary Device device tree (nit6xlite
and nitrogen6_max).

Signed-off-by: Gary Bisson <gary.bisson@boundarydevices.com>
---
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index db868bc..c7016b2 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -211,7 +211,7 @@
 		};
 	};
 
-	lcd_panel {
+	panel_lcd {
 		compatible = "okaya,rs800480t-7x0gp";
 		backlight = <&backlight_lcd>;
 
@@ -222,7 +222,7 @@
 		};
 	};
 
-	panel {
+	panel_lvds0 {
 		compatible = "hannstar,hsd100pxn1";
 		backlight = <&backlight_lvds>;
 
-- 
2.9.3
