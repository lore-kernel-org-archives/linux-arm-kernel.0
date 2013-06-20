From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 20 Jun 2013 13:58:42 +0300
Subject: [PATCH 1/3] common: DMA-mapping: add DMA_ATTR_READ_ONLY attribute
Message-ID: <1371725924-13957-2-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds DMA_ATTR_READ_ONLY attribute to the DMA-mapping
subsystem.

This sets mapping attribute read-only.

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 include/linux/dma-attrs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
index f272809..5d7371c 100644
--- a/include/linux/dma-attrs.h
+++ b/include/linux/dma-attrs.h
@@ -18,6 +18,7 @@ enum dma_attr {
 	DMA_ATTR_NO_KERNEL_MAPPING,
 	DMA_ATTR_SKIP_CPU_SYNC,
 	DMA_ATTR_SKIP_FREE_IOVA,
+	DMA_ATTR_READ_ONLY,
 	DMA_ATTR_MAX,
 };
 
-- 
1.8.1.5
