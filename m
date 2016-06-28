From: anurupvasu@gmail.com (Anurup M)
Date: Tue, 28 Jun 2016 05:50:27 -0400
Subject: [PATCH 6/8] arm64:perf: Makefile for Hisilicon ARMv8 PMU
In-Reply-To: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
References: <1467107429-55477-1-git-send-email-anurup.m@huawei.com>
Message-ID: <1467107429-55477-7-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

	1. Add Makefile for Hisilicon ARMv8 PMU support.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 drivers/perf/hisilicon/Makefile | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 drivers/perf/hisilicon/Makefile

diff --git a/drivers/perf/hisilicon/Makefile b/drivers/perf/hisilicon/Makefile
new file mode 100644
index 0000000..82c75a1
--- /dev/null
+++ b/drivers/perf/hisilicon/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_HISI_PERFCTR) += hisi_uncore_pmu.o hisi_uncore_llc.o
-- 
2.1.4
