From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:47:44 +0200
Subject: [PATCH 0083/1529] Fix typo
Message-ID: <20160521114744.3635-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/include/asm/spinlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/spinlock.h b/arch/arm/include/asm/spinlock.h
index 0fa4184..c8122df 100644
--- a/arch/arm/include/asm/spinlock.h
+++ b/arch/arm/include/asm/spinlock.h
@@ -19,7 +19,7 @@
  * assembler to insert a extra (16-bit) IT instruction, depending on the
  * presence or absence of neighbouring conditional instructions.
  *
- * To avoid this unpredictableness, an approprite IT is inserted explicitly:
+ * To avoid this unpredictableness, an appropriate IT is inserted explicitly:
  * the assembler won't change IT instructions which are explicitly present
  * in the input.
  */
-- 
2.8.2.534.g1f66975
