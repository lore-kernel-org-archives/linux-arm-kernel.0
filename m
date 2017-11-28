From: sean.nyekjaer@prevas.dk (Sean Nyekjaer)
Date: Tue, 28 Nov 2017 09:49:02 +0100
Subject: [PATCH] ARM: dts: armada-38x: Add NAND RB pinctrl information
Message-ID: <20171128084902.12134-1-sean.nyekjaer@prevas.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pin control information for the NAND flash interface.

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
 arch/arm/boot/dts/armada-38x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 00ff549d4e39..a6cc568f74f7 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -279,6 +279,11 @@
 					marvell,function = "dev";
 				};
 
+				nand_rb: nand-rb {
+					marvell,pins = "mpp41";
+					marvell,function = "nand";
+				};
+
 				uart0_pins: uart-pins-0 {
 					marvell,pins = "mpp0", "mpp1";
 					marvell,function = "ua0";
-- 
2.15.0
