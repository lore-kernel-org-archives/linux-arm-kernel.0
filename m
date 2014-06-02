From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon,  2 Jun 2014 15:42:06 +0200
Subject: [PATCH v2 2/7] DMA: shdma: Spelling s/controll/control/
In-Reply-To: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1401716531-29794-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New

 Documentation/devicetree/bindings/dma/shdma.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/shdma.txt b/Documentation/devicetree/bindings/dma/shdma.txt
index d26b7065ae94..2b61cab0525c 100644
--- a/Documentation/devicetree/bindings/dma/shdma.txt
+++ b/Documentation/devicetree/bindings/dma/shdma.txt
@@ -73,7 +73,7 @@ Example:
 	};
 
 For r8a7790 and newer implementations, the information for the channel
-controll register is found in the dma phandle and #dma-cells is set to 2.
+control register is found in the dma phandle and #dma-cells is set to 2.
 
 	dma0: dma-mux at 0 {
 		compatible = "renesas,shdma-mux";
-- 
1.9.1
