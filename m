From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:50:19 +0200
Subject: [PATCH 0106/1529] Fix typo
Message-ID: <20160521115019.4865-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-omap2/omap4-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap4-common.c b/arch/arm/mach-omap2/omap4-common.c
index 949696b..fb6fe26 100644
--- a/arch/arm/mach-omap2/omap4-common.c
+++ b/arch/arm/mach-omap2/omap4-common.c
@@ -61,7 +61,7 @@ static phys_addr_t dram_sync_paddr;
 static u32 dram_sync_size;
 
 /*
- * The OMAP4 bus structure contains asynchrnous bridges which can buffer
+ * The OMAP4 bus structure contains asynchronous bridges which can buffer
  * data writes from the MPU. These asynchronous bridges can be found on
  * paths between the MPU to EMIF, and the MPU to L3 interconnects.
  *
-- 
2.8.2.534.g1f66975
