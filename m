From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:48:59 +0200
Subject: [PATCH 0094/1529] Fix typo
Message-ID: <20160521114859.4225-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-dove/mpp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-dove/mpp.h b/arch/arm/mach-dove/mpp.h
index fbec7c5..b219cf9 100644
--- a/arch/arm/mach-dove/mpp.h
+++ b/arch/arm/mach-dove/mpp.h
@@ -178,7 +178,7 @@ enum dove_mpp_grp_idx {
 /*
  * The MPP[52:57] functionality is encoded by 4 bits in different
  * registers. The _num field in this case encodes those bits in
- * correspodence with Table 135 of 88AP510 Functional specification
+ * correspondence with Table 135 of 88AP510 Functional specification
  */
 #define MPP_GRP_AU1_52_57_AU1		0x0
 #define MPP_GRP_AU1_52_57_AU1_GPIO57	0x2
-- 
2.8.2.534.g1f66975
