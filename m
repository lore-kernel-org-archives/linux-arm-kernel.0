From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:48:29 +0200
Subject: [PATCH 0089/1529] Fix typo
Message-ID: <20160521114829.3977-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/kernel/topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ec279d1..ebbf60c 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -154,7 +154,7 @@ static void __init parse_dt_topology(void)
 }
 
 /*
- * Look for a customed capacity of a CPU in the cpu_capacity table during the
+ * Look for a custom capacity of a CPU in the cpu_capacity table during the
  * boot. The update of all CPUs is in O(n^2) for heteregeneous system but the
  * function returns directly for SMP system.
  */
-- 
2.8.2.534.g1f66975
