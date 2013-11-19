From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 19 Nov 2013 11:07:40 +0000
Subject: [PATCH 01/10] dma: ste_dma40: Expand DT binding to accept
 'high-priority channel' flag
In-Reply-To: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
References: <1384859269-19801-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1384859269-19801-2-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is used for MSP (audio) devices which is about to be fully DT:ed.

Cc: devicetree at vger.kernel.org
Acked-by: Vinod Koul <vinod.koul@intel.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 Documentation/devicetree/bindings/dma/ste-dma40.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/ste-dma40.txt b/Documentation/devicetree/bindings/dma/ste-dma40.txt
index a8c21c2..1f5729f 100644
--- a/Documentation/devicetree/bindings/dma/ste-dma40.txt
+++ b/Documentation/devicetree/bindings/dma/ste-dma40.txt
@@ -50,6 +50,9 @@ Each dmas request consists of 4 cells:
         0x00000008: Use fixed channel:
                 Use automatic channel selection when unset
                 Use DMA request line number when set
+        0x00000010: Set channel as high priority:
+                Normal priority when unset
+                High priority when set
 
 Example:
 
-- 
1.8.1.2
