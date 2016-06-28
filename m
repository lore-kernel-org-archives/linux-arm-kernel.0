From: anurupvasu@gmail.com (Anurup M)
Date: Tue, 28 Jun 2016 05:50:28 -0400
Subject: [PATCH 7/8] arm64:perf: Update Makefile for Hisilicon PMU support
In-Reply-To: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
References: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1467107429-55477-8-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1. Update Makefile for Hisilicon ARMv8 PMU support.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/perf/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index acd2397..7f051ad 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_ARM_PMU) += arm_pmu.o
+obj-$(CONFIG_HISI_PERFCTR) += hisilicon/
-- 
2.1.4
