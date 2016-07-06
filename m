From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Wed,  6 Jul 2016 16:51:34 -0700
Subject: [PATCH 1/3] iommu: add IOMMU_PRIV attribute
In-Reply-To: <20160706235136.27854-1-mitchelh@codeaurora.org>
References: <20160706235136.27854-1-mitchelh@codeaurora.org>
Message-ID: <20160706235136.27854-2-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the IOMMU_PRIV attribute, which is used to indicate privileged
mappings.

Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
---
 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 664683aedcce..01c9f2667f2b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -31,6 +31,7 @@
 #define IOMMU_CACHE	(1 << 2) /* DMA cache coherency */
 #define IOMMU_NOEXEC	(1 << 3)
 #define IOMMU_MMIO	(1 << 4) /* e.g. things like MSI doorbells */
+#define IOMMU_PRIV	(1 << 5)
 
 struct iommu_ops;
 struct iommu_group;
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
