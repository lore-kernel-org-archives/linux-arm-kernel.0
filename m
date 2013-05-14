From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 14 May 2013 17:50:54 +0200
Subject: [PATCH] ARM: at91/trivial: typo in GEM compatible string
Message-ID: <1368546654-20120-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 Documentation/devicetree/bindings/net/macb.txt | 2 +-
 arch/arm/boot/dts/sama5d3.dtsi                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/macb.txt b/Documentation/devicetree/bindings/net/macb.txt
index 44afa0e..4ff6504 100644
--- a/Documentation/devicetree/bindings/net/macb.txt
+++ b/Documentation/devicetree/bindings/net/macb.txt
@@ -4,7 +4,7 @@ Required properties:
 - compatible: Should be "cdns,[<chip>-]{macb|gem}"
   Use "cdns,at91sam9260-macb" Atmel at91sam9260 and at91sam9263 SoCs.
   Use "cdns,at32ap7000-macb" for other 10/100 usage or use the generic form: "cdns,macb".
-  Use "cnds,pc302-gem" for Picochip picoXcell pc302 and later devices based on
+  Use "cdns,pc302-gem" for Picochip picoXcell pc302 and later devices based on
   the Cadence GEM, or the generic form: "cdns,gem".
 - reg: Address and length of the register set for the device
 - interrupts: Should contain macb interrupt
diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
index 2e643ea..5fce96b 100644
--- a/arch/arm/boot/dts/sama5d3.dtsi
+++ b/arch/arm/boot/dts/sama5d3.dtsi
@@ -156,7 +156,7 @@
 			};
 
 			macb0: ethernet at f0028000 {
-				compatible = "cnds,pc302-gem", "cdns,gem";
+				compatible = "cdns,pc302-gem", "cdns,gem";
 				reg = <0xf0028000 0x100>;
 				interrupts = <34 4 3>;
 				pinctrl-names = "default";
-- 
1.8.0
