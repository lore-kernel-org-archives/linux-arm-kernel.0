From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri,  9 Dec 2016 12:04:12 +0100
Subject: [PATCH v2 04/11] Documentation: DT: binding: axp20x_usb_power: add
 axp223 compatible
In-Reply-To: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Message-ID: <20161209110419.28981-5-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the "x-powers,axp223-usb-power-supply" to the list of
compatibles for AXP20X VBUS power supply driver.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v2:
 - adding small explanation on AXP223 variation compared to the AXP221,

 Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
index f1d7bee..ba8d35f 100644
--- a/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
+++ b/Documentation/devicetree/bindings/power/supply/axp20x_usb_power.txt
@@ -3,6 +3,11 @@ AXP20x USB power supply
 Required Properties:
 -compatible: One of: "x-powers,axp202-usb-power-supply"
                      "x-powers,axp221-usb-power-supply"
+                     "x-powers,axp223-usb-power-supply"
+
+The AXP223 PMIC shares most of its behaviour with the AXP221 but has slight
+variations such as the former being able to set the VBUS power supply max
+current to 100mA, unlike the latter.
 
 This node is a subnode of the axp20x PMIC.
 
-- 
2.9.3
