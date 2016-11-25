From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri, 25 Nov 2016 10:09:14 +0100
Subject: [PATCH 03/10] Documentation: DT: binding: axp20x_usb_power: add
 axp223 compatible
In-Reply-To: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
References: <20161125090921.23138-1-quentin.schulz@free-electrons.com>
Message-ID: <20161125090921.23138-4-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the "x-powers,axp223-usb-power-supply" to the list of
compatibles for AXP20X VBUS power supply driver.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
index f1d7bee..bf3953c 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
@@ -3,6 +3,7 @@ AXP20x USB power supply
 Required Properties:
 -compatible: One of: "x-powers,axp202-usb-power-supply"
                      "x-powers,axp221-usb-power-supply"
+                     "x-powers,axp223-usb-power-supply"
 
 This node is a subnode of the axp20x PMIC.
 
-- 
2.9.3
