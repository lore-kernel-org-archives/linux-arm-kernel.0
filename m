From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Fri, 4 Oct 2013 10:46:51 +0200
Subject: [PATCH] dma: atmel-dma: correct typo in the device tree bindings
 documentation
Message-ID: <1380876411-706-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

The value to set ASAP mode for FIFO configuration is 2 instead of 1.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 Documentation/devicetree/bindings/dma/atmel-dma.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/atmel-dma.txt b/Documentation/devicetree/bindings/dma/atmel-dma.txt
index c280a0e..434f74e 100644
--- a/Documentation/devicetree/bindings/dma/atmel-dma.txt
+++ b/Documentation/devicetree/bindings/dma/atmel-dma.txt
@@ -28,7 +28,7 @@ The three cells in order are:
 dependant:
   - bit 7-0: peripheral identifier for the hardware handshaking interface. The
   identifier can be different for tx and rx.
-  - bit 11-8: FIFO configuration. 0 for half FIFO, 1 for ALAP, 1 for ASAP.
+  - bit 11-8: FIFO configuration. 0 for half FIFO, 1 for ALAP, 2 for ASAP.
 
 Example:
 
-- 
1.7.11.3
