From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat,  8 Apr 2017 02:34:33 +0800
Subject: [PATCH v2 03/11] dt-bindings: add device tree binding for X-Powers
 AXP803 PMIC
In-Reply-To: <20170407183441.58750-1-icenowy@aosc.io>
References: <20170407183441.58750-1-icenowy@aosc.io>
Message-ID: <20170407183441.58750-4-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AXP803 is a PMIC produced by Shenzhen X-Powers, with either I2C or RSB
bus.

Add a compatible for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v2:
- Place AXP803 before AXP806/809.
- Added Chen-Yu's ACK.

 Documentation/devicetree/bindings/mfd/axp20x.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/axp20x.txt b/Documentation/devicetree/bindings/mfd/axp20x.txt
index b41d2601c6ba..334fb19ce605 100644
--- a/Documentation/devicetree/bindings/mfd/axp20x.txt
+++ b/Documentation/devicetree/bindings/mfd/axp20x.txt
@@ -6,12 +6,13 @@ axp202 (X-Powers)
 axp209 (X-Powers)
 axp221 (X-Powers)
 axp223 (X-Powers)
+axp803 (X-Powers)
 axp809 (X-Powers)
 
 Required properties:
 - compatible: "x-powers,axp152", "x-powers,axp202", "x-powers,axp209",
-	      "x-powers,axp221", "x-powers,axp223", "x-powers,axp806",
-	      "x-powers,axp809"
+	      "x-powers,axp221", "x-powers,axp223", "x-powers,axp803",
+	      "x-powers,axp806", "x-powers,axp809"
 - reg: The I2C slave address or RSB hardware address for the AXP chip
 - interrupt-parent: The parent interrupt controller
 - interrupts: SoC NMI / GPIO interrupt connected to the PMIC's IRQ pin
-- 
2.12.2
