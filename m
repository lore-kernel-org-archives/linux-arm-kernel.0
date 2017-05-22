From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Mon, 22 May 2017 20:48:00 +0800
Subject: [PATCH v8 1/9] arm64: MAINTAINERS: hisi: Add hisilicon SoC PMU support
Message-ID: <1495457280-233300-1-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Anurup M <anurup.m@huawei.com>

Add support for Hisilicon SoC hardware event counters
for HiP05/06/07 chip versions.

Signed-off-by: Anurup M <anurup.m@huawei.com>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0348bc..ac5a64e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6072,6 +6072,16 @@ S:	Maintained
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
1.9.1
