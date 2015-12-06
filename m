From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Sun, 06 Dec 2015 23:28:37 +0000
Subject: [PATCH v2 3/3] ARM: dts: dove: add Dove divider clocks
Message-ID: <E1a5ijN-0007pq-3t@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the Dove divider clocks to the Dove dtsi file.

Acked-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/dove.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/dove.dtsi b/arch/arm/boot/dts/dove.dtsi
index 179121630ad7..ea36a262d056 100644
--- a/arch/arm/boot/dts/dove.dtsi
+++ b/arch/arm/boot/dts/dove.dtsi
@@ -459,6 +459,12 @@
 					#clock-cells = <1>;
 				};
 
+				divider_clk: core-clock at 0064 {
+					compatible = "marvell,dove-divider-clock";
+					reg = <0x0064 0x8>;
+					#clock-cells = <1>;
+				};
+
 				pinctrl: pin-ctrl at 0200 {
 					compatible = "marvell,dove-pinctrl";
 					reg = <0x0200 0x14>,
-- 
2.1.0
