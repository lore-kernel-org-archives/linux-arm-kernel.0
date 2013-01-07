From: afzal@ti.com (Afzal Mohammed)
Date: Mon, 7 Jan 2013 10:48:03 +0530
Subject: [PATCH 1/5] ARM: dts: AM33XX: Add lcdc node
In-Reply-To: <cover.1357304150.git.afzal@ti.com>
References: <cover.1357304150.git.afzal@ti.com>
Message-ID: <f4d5d2174efb07e4b69eb1ba0990a8db3b077ade.1357304150.git.afzal@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add lcdc node.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index c2f14e8..432d4bb8 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -385,5 +385,13 @@
 				mac-address = [ 00 00 00 00 00 00 ];
 			};
 		};
+
+		lcdc: lcdc at 4830e000 {
+			compatible = "ti,am3352-lcdc", "ti,da830-lcdc";
+			reg = <0x4830e000 0x1000>;
+			interrupts = <36>;
+			status = "disabled";
+			ti,hwmods = "lcdc";
+		};
 	};
 };
-- 
1.7.9.5
