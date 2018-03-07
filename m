From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Wed,  7 Mar 2018 16:38:03 +0530
Subject: [PATCH] perf vendor events arm64: Enable JSON events for ThunderX2 B0
Message-ID: <20180307110803.32418-1-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is MIDR change on ThunderX2 B0, adding an entry to mapfile
to enable JSON events for B0.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 tools/perf/pmu-events/arch/arm64/mapfile.csv | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/pmu-events/arch/arm64/mapfile.csv b/tools/perf/pmu-events/arch/arm64/mapfile.csv
index e61c9ca..93c5d14 100644
--- a/tools/perf/pmu-events/arch/arm64/mapfile.csv
+++ b/tools/perf/pmu-events/arch/arm64/mapfile.csv
@@ -13,4 +13,5 @@
 #
 #Family-model,Version,Filename,EventType
 0x00000000420f5160,v1,cavium,core
+0x00000000430f0af0,v1,cavium,core
 0x00000000410fd03[[:xdigit:]],v1,cortex-a53,core
-- 
2.9.4
