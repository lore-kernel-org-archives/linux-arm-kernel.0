From: david@lechnology.com (David Lechner)
Date: Tue, 20 Dec 2016 14:23:02 -0600
Subject: [PATCH 1/3] doc: DT: Add ti,da830-uart to serial/8250 bindings
In-Reply-To: <1482265384-715-1-git-send-email-david@lechnology.com>
References: <1482265384-715-1-git-send-email-david@lechnology.com>
Message-ID: <1482265384-715-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the ti,da830-uart compatible string to serial 8250 UART bindings.

Signed-off-by: David Lechner <david@lechnology.com>
---
 Documentation/devicetree/bindings/serial/8250.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index f86bb06..10276a4 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -19,6 +19,7 @@ Required properties:
 	- "altr,16550-FIFO128"
 	- "fsl,16550-FIFO64"
 	- "fsl,ns16550"
+	- "ti,da830-uart"
 	- "serial" if the port type is unknown.
 - reg : offset and length of the register set for the device.
 - interrupts : should contain uart interrupt.
-- 
2.7.4
