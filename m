From: zhangshaokun@hisilicon.com (Shaokun Zhang)
Date: Wed, 28 Jun 2017 16:57:34 +0800
Subject: [PATCH v2 6/6] arm64: MAINTAINERS: hisi: Add HiSilicon SoC PMU support
In-Reply-To: <1498640254-182947-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1498640254-182947-1-git-send-email-zhangshaokun@hisilicon.com>
Message-ID: <1498640254-182947-7-git-send-email-zhangshaokun@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support HiSilicon SoC uncore PMU driver.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c0348bc..fbd664b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6072,6 +6072,13 @@ S:	Maintained
 F:	drivers/net/ethernet/hisilicon/
 F:	Documentation/devicetree/bindings/net/hisilicon*.txt
 
+HISILICON PMU DRIVER
+M:	Shaokun Zhang <zhangshaokun@hisilicon.com>
+W:	http://www.hisilicon.com
+S:	Supported
+F:	drivers/perf/hisilicon/
+F:	Documentation/perf/hisi-pmu.txt
+
 HISILICON ROCE DRIVER
 M:	Lijun Ou <oulijun@huawei.com>
 M:	Wei Hu(Xavier) <xavier.huwei@huawei.com>
-- 
1.9.1
