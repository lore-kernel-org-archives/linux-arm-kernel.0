From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Tue, 27 Aug 2013 15:26:05 +0200
Subject: [PATCH] ARM: at91/at91-pinctrl documentation: add missing sam9x5
 compatible string
Message-ID: <1377609965-22154-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing "atmel,at91sam9x5-pinctrl" compatible string to the
documentation.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 .../bindings/pinctrl/atmel,at91-pinctrl.txt        |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
index 648d60e..cf7c7bc 100644
--- a/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/atmel,at91-pinctrl.txt
@@ -18,7 +18,7 @@ mode) this pin can work on and the 'config' configures various pad settings
 such as pull-up, multi drive, etc.
 
 Required properties for iomux controller:
-- compatible: "atmel,at91rm9200-pinctrl"
+- compatible: "atmel,at91rm9200-pinctrl" or "atmel,at91sam9x5-pinctrl"
 - atmel,mux-mask: array of mask (periph per bank) to describe if a pin can be
   configured in this periph mode. All the periph and bank need to be describe.
 
-- 
1.7.9.5
