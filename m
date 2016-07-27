From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Wed, 27 Jul 2016 16:42:03 -0700
Subject: [PATCH v5 1/6] iommu: add IOMMU_PRIV attribute
In-Reply-To: <20160727234208.2101-1-mitchelh@codeaurora.org>
References: <20160727234208.2101-1-mitchelh@codeaurora.org>
Message-ID: <20160727234208.2101-2-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the IOMMU_PRIV attribute, which is used to indicate privileged
mappings.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
---

Notes:
    v2..v3
    
      - Added comment

 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index a35fb8b42e1a..35804abbd6cf 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -31,6 +31,7 @@
 #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
 #define IOMMU_NOEXEC	(1 << 3)
 #define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
+#define IOMMU_PRIV	(1 << 5) /* privileged */
 
 struct iommu_ops;
 struct iommu_group;
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
