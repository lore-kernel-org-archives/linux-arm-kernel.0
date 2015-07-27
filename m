From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 27 Jul 2015 13:30:17 +0100
Subject: [PATCH 18/18] iommu: tegra-smmu: remove cacheflush.h
In-Reply-To: <20150727122824.GH7557@n2100.arm.linux.org.uk>
References: <20150727122824.GH7557@n2100.arm.linux.org.uk>
Message-ID: <E1ZJhXt-0004Ck-LR@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/iommu/tegra-smmu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e5d6bc45c58f..4a8b66f05d8f 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -16,8 +16,6 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include <asm/cacheflush.h>
-
 #include <soc/tegra/ahb.h>
 #include <soc/tegra/mc.h>
 
-- 
2.1.0
