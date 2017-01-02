From: sricharan@codeaurora.org (Sricharan R)
Date: Mon,  2 Jan 2017 18:42:36 +0530
Subject: [PATCH V8 1/9] iommu: add IOMMU_PRIV attribute
In-Reply-To: <1483362764-11990-1-git-send-email-sricharan@codeaurora.org>
References: <1483362764-11990-1-git-send-email-sricharan@codeaurora.org>
Message-ID: <1483362764-11990-2-git-send-email-sricharan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mitchel Humpherys <mitchelh@codeaurora.org>

Add the IOMMU_PRIV attribute, which is used to indicate privileged
mappings.

Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Robin Murphy <robin.murphy@arm.com>
Signed-off-by: Mitchel Humpherys <mitchelh@codeaurora.org>
Acked-by: Will Deacon <will.deacon@arm.com>
---
 include/linux/iommu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0ff5111..8c15ada 100644
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
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
