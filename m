From: ganapatrao.kulkarni@cavium.com (Ganapatrao Kulkarni)
Date: Tue, 31 Jul 2018 15:32:51 +0530
Subject: [PATCH] perf vendor events arm64: Update ThunderX2 implementation
 defined pmu core events
Message-ID: <20180731100251.23575-1-ganapatrao.kulkarni@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 .../arch/arm64/cavium/thunderx2/core-imp-def.json  | 87 +++++++++++++++++++++-
 1 file changed, 84 insertions(+), 3 deletions(-)

diff --git a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
index bc03c06..752e47e 100644
--- a/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
+++ b/tools/perf/pmu-events/arch/arm64/cavium/thunderx2/core-imp-def.json
@@ -12,6 +12,21 @@
         "ArchStdEvent": "L1D_CACHE_REFILL_WR",
     },
     {
+        "ArchStdEvent": "L1D_CACHE_REFILL_INNER",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_REFILL_OUTER",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_VICTIM",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_WB_CLEAN",
+    },
+    {
+        "ArchStdEvent": "L1D_CACHE_INVAL",
+    },
+    {
         "ArchStdEvent": "L1D_TLB_REFILL_RD",
     },
     {
@@ -24,9 +39,75 @@
         "ArchStdEvent": "L1D_TLB_WR",
     },
     {
+        "ArchStdEvent": "L2D_TLB_REFILL_RD",
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_REFILL_WR",
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_RD",
+    },
+    {
+        "ArchStdEvent": "L2D_TLB_WR",
+    },
+    {
         "ArchStdEvent": "BUS_ACCESS_RD",
-   },
-   {
+    },
+    {
         "ArchStdEvent": "BUS_ACCESS_WR",
-   }
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_RD",
+    },
+    {
+        "ArchStdEvent": "MEM_ACCESS_WR",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LD_SPEC",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_ST_SPEC",
+    },
+    {
+        "ArchStdEvent": "UNALIGNED_LDST_SPEC",
+    },
+    {
+        "ArchStdEvent": "EXC_UNDEF",
+    },
+    {
+        "ArchStdEvent": "EXC_SVC",
+    },
+    {
+        "ArchStdEvent": "EXC_PABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_DABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_IRQ",
+    },
+    {
+        "ArchStdEvent": "EXC_FIQ",
+    },
+    {
+        "ArchStdEvent": "EXC_SMC",
+    },
+    {
+        "ArchStdEvent": "EXC_HVC",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_PABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_DABORT",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_OTHER",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_IRQ",
+    },
+    {
+        "ArchStdEvent": "EXC_TRAP_FIQ",
+    }
 ]
-- 
2.9.4
