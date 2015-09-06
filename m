From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Sun,  6 Sep 2015 09:12:01 +0800
Subject: [PATCH v4 02/10] Documentation: arm-pl330: add description of arm,
 pl330-broken-no-flushp
In-Reply-To: <1441501881-13700-1-git-send-email-shawn.lin@rock-chips.com>
References: <1441501881-13700-1-git-send-email-shawn.lin@rock-chips.com>
Message-ID: <1441501921-13788-1-git-send-email-shawn.lin@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

Reviewed-by: Doug Anderson <dianders@chromium.org>
Reviewed-by: Sonny Rao <sonnyrao@chromium.org>
---

Changes in v4: None
Changes in v3:
- add Reviewed-by: Sonny Rao <sonnyrao@chromium.org>

Changes in v2:
- add Reviewed-by: Doug Anderson <dianders@chromium.org>

Changes in v1:
- rename broken-no-flushp to "arm,pl330-broken-no-flushp" suggested
  by Krzysztof.

 Documentation/devicetree/bindings/dma/arm-pl330.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/dma/arm-pl330.txt b/Documentation/devicetree/bindings/dma/arm-pl330.txt
index 2675658..db7e226 100644
--- a/Documentation/devicetree/bindings/dma/arm-pl330.txt
+++ b/Documentation/devicetree/bindings/dma/arm-pl330.txt
@@ -15,6 +15,7 @@ Optional properties:
     cells in the dmas property of client device.
   - dma-channels: contains the total number of DMA channels supported by the DMAC
   - dma-requests: contains the total number of DMA requests supported by the DMAC
+  - arm,pl330-broken-no-flushp: quirk for avoiding to execute DMAFLUSHP
 
 Example:
 
-- 
2.3.7
