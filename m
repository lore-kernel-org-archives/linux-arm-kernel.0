From: anurupvasu@gmail.com (Anurup M)
Date: Thu,  4 Aug 2016 05:07:11 -0400
Subject: [RFC PATCH v1 07/10] arm64:perf: Makefile for Hisilicon Hip05 PMU
In-Reply-To: <1470301634-79736-1-git-send-email-anurup.m@huawei.com>
References: <1470301634-79736-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1470301634-79736-8-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1. Add Makefile for Hip05 uncore PMU support.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/perf/hisilicon/Makefile | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 drivers/perf/hisilicon/Makefile

diff --git a/drivers/perf/hisilicon/Makefile b/drivers/perf/hisilicon/Makefile
new file mode 100644
index 0000000..dc4c4dd
--- /dev/null
+++ b/drivers/perf/hisilicon/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_HISI_PERFCTR) += hisi_uncore_pmu.o hisi_uncore_l3c.o
-- 
2.1.4
