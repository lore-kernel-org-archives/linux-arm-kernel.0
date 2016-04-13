From: ttnguyen@apm.com (Tai Nguyen)
Date: Tue, 12 Apr 2016 18:22:24 -0700
Subject: [PATCH v2 1/4] MAINTAINERS: Add entry for APM X-Gene SoC PMU driver
In-Reply-To: <1460510547-17611-1-git-send-email-ttnguyen@apm.com>
References: <1460510547-17611-1-git-send-email-ttnguyen@apm.com>
Message-ID: <1460510547-17611-2-git-send-email-ttnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MAINTAINERS: Add entry for APM X-Gene SoC PMU driver

Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4978dc1..e2da90c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8593,6 +8593,13 @@ L:	linux-scsi at vger.kernel.org
 S:	Supported
 F:	drivers/scsi/pm8001/
 
+PMU-XGENE
+APPLIED MICRO (APM) X-GENE SOC PMU
+M:     Tai Nguyen <ttnguyen@apm.com>
+S:     Supported
+F:     drivers/perf/xgene_pmu.c
+F:     Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
+
 POSIX CLOCKS and TIMERS
 M:	Thomas Gleixner <tglx@linutronix.de>
 L:	linux-kernel at vger.kernel.org
-- 
1.9.1
