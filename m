From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue,  4 Oct 2016 15:41:48 +0200
Subject: [PATCH 3/3] dt-bindings: oxnas: Update Pinctrl and GPIO for OX820
 Support
In-Reply-To: <20161004134148.23028-1-narmstrong@baylibre.com>
References: <20161004134148.23028-1-narmstrong@baylibre.com>
Message-ID: <20161004134148.23028-4-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/gpio/gpio_oxnas.txt       | 2 +-
 Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt b/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
index 928ed4f..9665147 100644
--- a/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio_oxnas.txt
@@ -3,7 +3,7 @@
 Please refer to gpio.txt for generic information regarding GPIO bindings.
 
 Required properties:
- - compatible: "oxsemi,ox810se-gpio"
+ - compatible: "oxsemi,ox810se-gpio" or "oxsemi,ox820-gpio"
  - reg: Base address and length for the device.
  - interrupts: The port interrupt shared by all pins.
  - gpio-controller: Marks the port as GPIO controller.
diff --git a/Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt
index d607432..09e81a9 100644
--- a/Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/oxnas,pinctrl.txt
@@ -9,7 +9,7 @@ used for a specific device or function. This node represents configurations of
 pins, optional function, and optional mux related configuration.
 
 Required properties for pin controller node:
- - compatible: "oxsemi,ox810se-pinctrl"
+ - compatible: "oxsemi,ox810se-pinctrl" or "oxsemi,ox820-pinctrl"
  - oxsemi,sys-ctrl: a phandle to the system controller syscon node
 
 Required properties for pin configuration sub-nodes:
-- 
2.7.0
