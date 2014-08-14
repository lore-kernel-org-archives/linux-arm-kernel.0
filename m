From: ganapatrao.kulkarni@caviumnetworks.com (Ganapatrao Kulkarni)
Date: Thu, 14 Aug 2014 20:49:46 +0530
Subject: [PATCH] arm64:mm: Update max pa bits to 48
Message-ID: <1408029586-10362-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting the Macro MAX_PHYSMEM_BITS to 48 since arm64 enabled with 48 bit PA support.

Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@caviumnetworks.com>
---
 arch/arm64/include/asm/sparsemem.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
index 1be62bc..74a9d30 100644
--- a/arch/arm64/include/asm/sparsemem.h
+++ b/arch/arm64/include/asm/sparsemem.h
@@ -17,7 +17,7 @@
 #define __ASM_SPARSEMEM_H
 
 #ifdef CONFIG_SPARSEMEM
-#define MAX_PHYSMEM_BITS	40
+#define MAX_PHYSMEM_BITS	48
 #define SECTION_SIZE_BITS	30
 #endif
 
-- 
1.8.1.4
