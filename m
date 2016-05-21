From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sat, 21 May 2016 13:47:36 +0200
Subject: [PATCH 0082/1529] Fix typo
Message-ID: <20160521114736.3553-1-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/include/asm/fncpy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/fncpy.h b/arch/arm/include/asm/fncpy.h
index de53547..88f9c36 100644
--- a/arch/arm/include/asm/fncpy.h
+++ b/arch/arm/include/asm/fncpy.h
@@ -49,7 +49,7 @@
  * copied_f(args);
  *
  * The size of the function to be copied can't be determined from C:
- * this must be determined by other means, such as adding assmbler directives
+ * this must be determined by other means, such as adding assembler directives
  * in the file where f is defined.
  */
 
-- 
2.8.2.534.g1f66975
