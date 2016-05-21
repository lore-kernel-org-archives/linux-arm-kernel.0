From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:47:52 +0200
Subject: [PATCH 0084/1529] Fix typo
Message-ID: <20160521114752.3706-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/include/asm/tlbflush.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/tlbflush.h b/arch/arm/include/asm/tlbflush.h
index def9e57..2dee30f 100644
--- a/arch/arm/include/asm/tlbflush.h
+++ b/arch/arm/include/asm/tlbflush.h
@@ -281,7 +281,7 @@ extern struct cpu_tlb_fns cpu_tlb;
  *  - if we're going to need __cpu_tlb_flags, access it once and only once
  *
  * This allows us to build optimal assembly for the single-CPU type case,
- * and as close to optimal given the compiler constrants for multi-CPU
+ * and as close to optimal given the compiler constraints for multi-CPU
  * case.  We could do better for the multi-CPU case if the compiler
  * implemented the "%?" method, but this has been discontinued due to too
  * many people getting it wrong.
-- 
2.8.2.534.g1f66975
