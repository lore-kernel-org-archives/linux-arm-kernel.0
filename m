From: ttnguyen@apm.com (Tai Nguyen)
Date: Thu, 31 Mar 2016 16:37:49 -0700
Subject: [PATCH 1/4] MAINTAINERS: Add entry for APM X-Gene SoC PMU driver
In-Reply-To: <1459467472-31561-1-git-send-email-ttnguyen@apm.com>
References: <1459467472-31561-1-git-send-email-ttnguyen@apm.com>
Message-ID: <1459467472-31561-2-git-send-email-ttnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MAINTAINERS: Add entry for APM X-Gene SoC PMU driver

Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 66662b8..d3fe3c6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8505,6 +8505,13 @@ L:	linux-scsi at vger.kernel.org
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
