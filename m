From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:47:59 +0200
Subject: [PATCH 0085/1529] Fix typo
Message-ID: <20160521114759.3760-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/include/asm/ucontext.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/ucontext.h b/arch/arm/include/asm/ucontext.h
index 14749ae..b4d2d0f 100644
--- a/arch/arm/include/asm/ucontext.h
+++ b/arch/arm/include/asm/ucontext.h
@@ -8,7 +8,7 @@
  * ucontext now has room for all registers which need to be saved and
  * restored.  Coprocessor registers are stored in uc_regspace.  Each
  * coprocessor's saved state should start with a documented 32-bit magic
- * number, followed by a 32-bit word giving the coproccesor's saved size.
+ * number, followed by a 32-bit word giving the coprocessor saved size.
  * uc_regspace may be expanded if necessary, although this takes some
  * coordination with glibc.
  */
-- 
2.8.2.534.g1f66975
