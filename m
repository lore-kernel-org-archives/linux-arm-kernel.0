From: josh.wu@atmel.com (Josh Wu)
Date: Wed, 4 Mar 2015 11:50:29 +0800
Subject: [PATCH] ARM: pxa: documentation: trivial: fix typo
Message-ID: <1425441029-32579-1-git-send-email-josh.wu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

fix typo in the document.

Signed-off-by: Josh Wu <josh.wu@atmel.com>
---

 Documentation/devicetree/bindings/gpio/mrvl-gpio.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
index b2afdb2..77d0dd0 100644
--- a/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
+++ b/Documentation/devicetree/bindings/gpio/mrvl-gpio.txt
@@ -12,7 +12,7 @@ Required properties:
   gpio_mux.
 - interrupt-names : Should be the names of irq resources. Each interrupt
   uses its own interrupt name, so there should be as many interrupt names
-  as referenced interrups.
+  as referenced interrupts.
 - interrupt-controller : Identifies the node as an interrupt controller.
 - #interrupt-cells: Specifies the number of cells needed to encode an
   interrupt source.
-- 
1.9.1
