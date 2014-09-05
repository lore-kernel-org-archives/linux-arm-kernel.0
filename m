From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Fri, 5 Sep 2014 10:35:14 +0800
Subject: [PATCH] doc: dt-binding: of-serial: add Freescale 64-byte FIFO mode
 uart binding
Message-ID: <1409884514-24705-1-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This add the 64-byte FIFO mode device tree binding for Freescale DUART.

Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
---
 Documentation/devicetree/bindings/serial/of-serial.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/of-serial.txt b/Documentation/devicetree/bindings/serial/of-serial.txt
index 7705477..7b132eb 100644
--- a/Documentation/devicetree/bindings/serial/of-serial.txt
+++ b/Documentation/devicetree/bindings/serial/of-serial.txt
@@ -14,6 +14,7 @@ Required properties:
 	- "altr,16550-FIFO32"
 	- "altr,16550-FIFO64"
 	- "altr,16550-FIFO128"
+	- "fsl,16550-FIFO64"
 	- "serial" if the port type is unknown.
 - reg : offset and length of the register set for the device.
 - interrupts : should contain uart interrupt.
-- 
1.8.0
