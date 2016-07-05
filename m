From: a.kesavan@samsung.com (Abhilash Kesavan)
Date: Wed,  6 Jul 2016 01:58:26 +0530
Subject: [PATCH 1/2] soc: samsung: Change type of PMU configuration register
 value to u32
In-Reply-To: <1467750507-13853-1-git-send-email-a.kesavan@samsung.com>
References: <1467750507-13853-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <1467750507-13853-2-git-send-email-a.kesavan@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos7 has certain PMU registers that needs to be configured with
u32 values.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 drivers/soc/samsung/exynos-pmu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/samsung/exynos-pmu.h b/drivers/soc/samsung/exynos-pmu.h
index a469e36..1bdc506 100644
--- a/drivers/soc/samsung/exynos-pmu.h
+++ b/drivers/soc/samsung/exynos-pmu.h
@@ -18,7 +18,7 @@
 
 struct exynos_pmu_conf {
 	unsigned int offset;
-	u8 val[NUM_SYS_POWERDOWN];
+	unsigned int val[NUM_SYS_POWERDOWN];
 };
 
 struct exynos_pmu_data {
-- 
1.9.1
