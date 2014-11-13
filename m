From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 13 Nov 2014 11:52:44 +0100
Subject: [PATCH 6/7] ARM: dts: at_xdmac: fix bad value of dma-cells in
 documentation
In-Reply-To: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
References: <1415875965-6905-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <1415875965-6905-7-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dma-cells value in the example was 2 instead of 1.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 Documentation/devicetree/bindings/dma/atmel-xdma.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/atmel-xdma.txt b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
index e75c128..0eb2b32 100644
--- a/Documentation/devicetree/bindings/dma/atmel-xdma.txt
+++ b/Documentation/devicetree/bindings/dma/atmel-xdma.txt
@@ -22,7 +22,7 @@ dma1: dma-controller at f0004000 {
 	compatible = "atmel,sama5d4-dma";
 	reg = <0xf0004000 0x200>;
 	interrupts = <50 4 0>;
-	#dma-cells = <2>;
+	#dma-cells = <1>;
 };
 
 
-- 
2.0.3
