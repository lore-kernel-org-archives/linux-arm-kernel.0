From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 17 Jun 2015 10:59:04 +0200
Subject: [RESEND PATCH 1/2] ARM: at91/dt: trivial: fix USB udc compatible
 string
Message-ID: <99dc2e0ec98342632b6e3adad3861f4dd0fcde41.1434530650.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To please checkpatch and the tiresome reader, add the "atmel," prefix to the
USB udc compatible string.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: <stable@vger.kernel.org>  #4.0+
---
 Documentation/devicetree/bindings/usb/atmel-usb.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
index 1be8d7a26c15..5883b73ea1b5 100644
--- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
+++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
@@ -79,9 +79,9 @@ Atmel High-Speed USB device controller
 
 Required properties:
  - compatible: Should be one of the following
-	       "at91sam9rl-udc"
-	       "at91sam9g45-udc"
-	       "sama5d3-udc"
+	       "atmel,at91sam9rl-udc"
+	       "atmel,at91sam9g45-udc"
+	       "atmel,sama5d3-udc"
  - reg: Address and length of the register set for the device
  - interrupts: Should contain usba interrupt
  - clocks: Should reference the peripheral and host clocks
-- 
2.1.3
