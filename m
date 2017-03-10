From: anurupvasu@gmail.com (Anurup M)
Date: Fri, 10 Mar 2017 01:27:05 -0500
Subject: [PATCH v6 01/11] arm64: MAINTAINERS: hisi: Add hisilicon SoC PMU
 support
Message-ID: <1489127225-112518-1-git-send-email-anurup.m@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for Hisilicon SoC hardware event counters
for HiP05/06/07 chip versions.

Signed-off-by: Anurup M <anurup.m@huawei.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6d7b7a7..c2f9806 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5958,6 +5958,15 @@ S:	Maintained
 F:	drivers/net/ethernet/hisilicon/
 F:	Documentation/devicetree/bindings/net/hisilicon*.txt
 
+HISILICON SOC PMU
+M:	Anurup M <anurup.m@huawei.com>
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
