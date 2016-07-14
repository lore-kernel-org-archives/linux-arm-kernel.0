From: ttnguyen@apm.com (Tai Nguyen)
Date: Thu, 14 Jul 2016 10:27:43 -0700
Subject: [PATCH v9 1/4] MAINTAINERS: Add entry for APM X-Gene SoC PMU driver
In-Reply-To: <1468517266-1642-1-git-send-email-ttnguyen@apm.com>
References: <1468517266-1642-1-git-send-email-ttnguyen@apm.com>
Message-ID: <1468517266-1642-2-git-send-email-ttnguyen@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the MAINTAINERS entry for APM X-Gene SoC PMU driver.

Signed-off-by: Tai Nguyen <ttnguyen@apm.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1209323..41938e7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -841,6 +841,13 @@ S:	Supported
 F:	drivers/net/ethernet/apm/xgene/
 F:	Documentation/devicetree/bindings/net/apm-xgene-enet.txt
 
+APPLIED MICRO (APM) X-GENE SOC PMU
+M:	Tai Nguyen <ttnguyen@apm.com>
+S:	Supported
+F:	drivers/perf/xgene_pmu.c
+F:	Documentation/perf/xgene-pmu.txt
+F:	Documentation/devicetree/bindings/perf/apm-xgene-pmu.txt
+
 APTINA CAMERA SENSOR PLL
 M:	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
 L:	linux-media at vger.kernel.org
-- 
1.9.1
