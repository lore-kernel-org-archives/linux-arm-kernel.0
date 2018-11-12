From: rmk+kernel@armlinux.org.uk (Russell King)
Date: Mon, 12 Nov 2018 12:30:57 +0000
Subject: [RFC PATCH 3/6] ARM: dts: add description for Armada 38x common phy
In-Reply-To: <20181112122933.GD30658@n2100.armlinux.org.uk>
References: <20181112122933.GD30658@n2100.armlinux.org.uk>
Message-ID: <E1gMBMn-00089g-BV@rmk-PC.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the DT description for the Armada 38x common phy.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/boot/dts/armada-38x.dtsi | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/armada-38x.dtsi b/arch/arm/boot/dts/armada-38x.dtsi
index 929459c42760..7b2e2bd6479b 100644
--- a/arch/arm/boot/dts/armada-38x.dtsi
+++ b/arch/arm/boot/dts/armada-38x.dtsi
@@ -335,6 +335,43 @@
 				#clock-cells = <1>;
 			};
 
+			comphy: phy at 18300 {
+				compatible = "marvell,armada-380-comphy";
+				reg = <0x18300 0x100>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				comphy0: phy at 0 {
+					reg = <0>;
+					#phy-cells = <1>;
+				};
+
+				comphy1: phy at 1 {
+					reg = <1>;
+					#phy-cells = <1>;
+				};
+
+				comphy2: phy at 2 {
+					reg = <2>;
+					#phy-cells = <1>;
+				};
+
+				comphy3: phy at 3 {
+					reg = <3>;
+					#phy-cells = <1>;
+				};
+
+				comphy4: phy at 4 {
+					reg = <4>;
+					#phy-cells = <1>;
+				};
+
+				comphy5: phy at 5 {
+					reg = <5>;
+					#phy-cells = <1>;
+				};
+			};
+
 			coreclk: mvebu-sar at 18600 {
 				compatible = "marvell,armada-380-core-clock";
 				reg = <0x18600 0x04>;
-- 
2.7.4
