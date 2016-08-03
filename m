From: anurupvasu@gmail.com (Anurup M)
Date: Wed,  3 Aug 2016 02:34:37 -0400
Subject: [RFC PATCH v1 08/10] arm64:perf: Update Makefile for Hisilicon PMU
 support
In-Reply-To: <1470206079-73280-1-git-send-email-anurup.m@huawei.com>
References: <1470206079-73280-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1470206079-73280-9-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1. Update Makefile for Hisilicon Hip05 PMU support.

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
