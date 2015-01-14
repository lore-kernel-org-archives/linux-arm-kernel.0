From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 14 Jan 2015 17:22:03 +0100
Subject: [PATCH 11/12] usb: gadget: at91_udc: Update DT binding documentation
In-Reply-To: <1421252524-24452-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421252524-24452-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421252524-24452-12-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Boris Brezillon <boris.brezillon@free-electrons.com>

Three compatible strings have been added to the at91_udc driver.
Update the documentation accordingly.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
 Documentation/devicetree/bindings/usb/atmel-usb.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/atmel-usb.txt b/Documentation/devicetree/bindings/usb/atmel-usb.txt
index 6007231e0adc..54a81219caae 100644
--- a/Documentation/devicetree/bindings/usb/atmel-usb.txt
+++ b/Documentation/devicetree/bindings/usb/atmel-usb.txt
@@ -33,7 +33,11 @@ usb1: ehci at 00800000 {
 AT91 USB device controller
 
 Required properties:
- - compatible: Should be "atmel,at91rm9200-udc"
+ - compatible: Should be one of the following
+	       "atmel,at91rm9200-udc"
+	       "atmel,at91sam9260-udc"
+	       "atmel,at91sam9261-udc"
+	       "atmel,at91sam9263-udc"
  - reg: Address and length of the register set for the device
  - interrupts: Should contain macb interrupt
  - clocks: Should reference the peripheral and the AHB clocks
-- 
2.1.0
