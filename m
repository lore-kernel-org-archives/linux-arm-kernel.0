From: justinmattock@gmail.com (Justin P. Mattock)
Date: Fri, 28 Jan 2011 11:48:18 -0800
Subject: [PATCH]drivers:dma:coh901318.c Change initate to initiate.
Message-ID: <1296244098-3732-1-git-send-email-justinmattock@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Not sure if this is a typo or not. if it is then feel free to take this.

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 drivers/dma/coh901318.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/coh901318.c b/drivers/dma/coh901318.c
index a665683..00deabd 100644
--- a/drivers/dma/coh901318.c
+++ b/drivers/dma/coh901318.c
@@ -849,7 +849,7 @@ static irqreturn_t dma_irq_handler(int irq, void *dev_id)
 
 				/* Must clear TC interrupt before calling
 				 * dma_tc_handle
-				 * in case tc_handle initate a new dma job
+				 * in case tc_handle initiate a new dma job
 				 */
 				__set_bit(i, virtbase + COH901318_TC_INT_CLEAR1);
 
@@ -894,7 +894,7 @@ static irqreturn_t dma_irq_handler(int irq, void *dev_id)
 				}
 				/* Must clear TC interrupt before calling
 				 * dma_tc_handle
-				 * in case tc_handle initate a new dma job
+				 * in case tc_handle initiate a new dma job
 				 */
 				__set_bit(i, virtbase + COH901318_TC_INT_CLEAR2);
 
-- 
1.6.5.GIT
