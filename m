From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Fri,  5 Aug 2016 10:53:20 +0800
Subject: [PATCH 1/3] dt/bindings: arm-pl330: add description of arm,
 pl330-periph-burst
In-Reply-To: <1470365602-32586-1-git-send-email-shawn.lin@rock-chips.com>
References: <1470365602-32586-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1470365602-32586-2-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the "arm,pl330-periph-burst" for arm-pl330 to
support busrt mode.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 Documentation/devicetree/bindings/dma/arm-pl330.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/arm-pl330.txt b/Documentation/devicetree/bindings/dma/arm-pl330.txt
index db7e226..262e97a 100644
--- a/Documentation/devicetree/bindings/dma/arm-pl330.txt
+++ b/Documentation/devicetree/bindings/dma/arm-pl330.txt
@@ -16,6 +16,7 @@ Optional properties:
   - dma-channels: contains the total number of DMA channels supported by the DMAC
   - dma-requests: contains the total number of DMA requests supported by the DMAC
   - arm,pl330-broken-no-flushp: quirk for avoiding to execute DMAFLUSHP
+  - arm,pl330-periph-burst: set peripheral dma request type as burst mode
 
 Example:
 
-- 
2.3.7
