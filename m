From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Thu, 27 Aug 2015 16:49:22 +0800
Subject: [PATCH 5/5] Documentation: arm-pl330: add description of
 broken-no-flushp
In-Reply-To: <1440665280-31557-1-git-send-email-shawn.lin@rock-chips.com>
References: <1440665280-31557-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1440665362-31771-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 Documentation/devicetree/bindings/dma/arm-pl330.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/arm-pl330.txt b/Documentation/devicetree/bindings/dma/arm-pl330.txt
index 2675658..0f19268 100644
--- a/Documentation/devicetree/bindings/dma/arm-pl330.txt
+++ b/Documentation/devicetree/bindings/dma/arm-pl330.txt
@@ -15,6 +15,7 @@ Optional properties:
     cells in the dmas property of client device.
   - dma-channels: contains the total number of DMA channels supported by the DMAC
   - dma-requests: contains the total number of DMA requests supported by the DMAC
+  - broken-no-flushp: quirk for avoiding to execute DMAFLUSHP
 
 Example:
 
-- 
2.3.7
