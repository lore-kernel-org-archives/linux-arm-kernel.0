From: oskari@lemmela.net (Oskari Lemmela)
Date: Tue, 23 Oct 2018 21:53:22 +0300
Subject: [PATCH v5 03/11] dt-bindings: gpio: gpio-axp209: add AXP803 GPIO
 bindings
In-Reply-To: <20181023185330.10472-1-oskari@lemmela.net>
References: <20181023185330.10472-1-oskari@lemmela.net>
Message-ID: <20181023185330.10472-4-oskari@lemmela.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The AXP803 GPIO is compatible with AXP813 GPIO, but add
specific compatible for it.

Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
---
 Documentation/devicetree/bindings/gpio/gpio-axp209.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
index fc42b2caa06d..5337a21d7bcf 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
+++ b/Documentation/devicetree/bindings/gpio/gpio-axp209.txt
@@ -11,6 +11,7 @@ This driver employs the per-pin muxing pattern.
 Required properties:
 - compatible: Should be one of:
 	- "x-powers,axp209-gpio"
+	- "x-powers,axp803-gpio"
 	- "x-powers,axp813-gpio"
 - #gpio-cells: Should be two. The first cell is the pin number and the
   second is the GPIO flags.
@@ -67,6 +68,7 @@ GPIO0	|	gpio_in, gpio_out, ldo, adc
 GPIO1	|	gpio_in, gpio_out, ldo, adc
 GPIO2	|	gpio_in, gpio_out
 
+axp803
 axp813
 ------
 GPIO	|	Functions
-- 
2.17.1
