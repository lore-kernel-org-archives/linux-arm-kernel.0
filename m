From: appana.durga.rao@xilinx.com (Kedareswara rao Appana)
Date: Thu, 7 Dec 2017 10:51:06 +0530
Subject: [PATCH v7 5/6] dmaengine: xilinx_dma: fix style issues from checkpatch
In-Reply-To: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
References: <1512624067-13554-1-git-send-email-appanad@xilinx.com>
Message-ID: <1512624067-13554-6-git-send-email-appanad@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes below.
ERROR: open brace '{' following function definitions go on the next line
+static int xilinx_dma_child_probe(struct xilinx_dma_device *xdev,
+				    struct device_node *node) {

Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
---
Changes for v7:
--> New patch.

 drivers/dma/xilinx/xilinx_dma.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index eaa93fe..b09a8ef 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -2484,7 +2484,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
  * Return: 0 always.
  */
 static int xilinx_dma_child_probe(struct xilinx_dma_device *xdev,
-				    struct device_node *node) {
+				    struct device_node *node)
+{
 	int ret, i, nr_channels = 1;
 
 	ret = of_property_read_u32(node, "dma-channels", &nr_channels);
-- 
2.7.4
