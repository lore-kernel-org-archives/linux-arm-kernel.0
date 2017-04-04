From: anurupvasu@gmail.com (Anurup M)
Date: Tue,  4 Apr 2017 06:55:11 -0400
Subject: [PATCH v7 1/9] arm64: MAINTAINERS: hisi: Add hisilicon SoC PMU support
Message-ID: <1491303311-140252-1-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Hisilicon SoC hardware event counters
for HiP05/06/07 chip versions.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d7b7a7..4a95977 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5958,6 +5958,16 @@ S:	Maintained
 F:	drivers/net/ethernet/hisilicon/
 F:	Documentation/devicetree/bindings/net/hisilicon*.txt
 
+HISILICON SOC PMU
+M:	Anurup M <anurup.m@huawei.com>
+M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
+W:	http://www.hisilicon.com
+S:	Supported
+F:	drivers/perf/hisilicon/
+F:	Documentation/perf/hisi-pmu.txt
+F:	Documentation/devicetree/bindings/arm/hisilicon/pmu.txt
+F:	Documentation/devicetree/bindings/arm/hisilicon/djtag.txt
+
 HISILICON ROCE DRIVER
 M:	Lijun Ou <oulijun@huawei.com>
 M:	Wei Hu(Xavier) <xavier.huwei@huawei.com>
-- 
2.1.4
