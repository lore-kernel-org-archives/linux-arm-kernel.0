From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 16 Oct 2012 09:49:16 +0530
Subject: [PATCH V3 1/3] dmaengine: dw_dmac: Update documentation style
 comments for dw_dma_platform_data
Message-ID: <3100e691db3f94c22afd98b609a1568d7e70dfe7.1350360935.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Documentation style comments were missing for few fields in struct
dw_dma_platform_data. Add these.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/dw_dmac.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/dw_dmac.h b/include/linux/dw_dmac.h
index e1c8c9e..62a6190 100644
--- a/include/linux/dw_dmac.h
+++ b/include/linux/dw_dmac.h
@@ -19,6 +19,8 @@
  * @nr_channels: Number of channels supported by hardware (max 8)
  * @is_private: The device channels should be marked as private and not for
  *	by the general purpose DMA channel allocator.
+ * @chan_allocation_order: Allocate channels starting from 0 or 7
+ * @chan_priority: Set channel priority increasing from 0 to 7 or 7 to 0.
  * @block_size: Maximum block size supported by the controller
  * @nr_masters: Number of AHB masters supported by the controller
  * @data_width: Maximum data width supported by hardware per AHB master
-- 
1.7.12.rc2.18.g61b472e
