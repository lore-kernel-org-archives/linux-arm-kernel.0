From: hyuk.myeong@lge.com (Hyuk Myeong)
Date: Fri, 11 Sep 2015 20:22:52 +0900
Subject: [PATCH] ARM: pgtable: Fix typo in the comment
Message-ID: <!&!AAAAAAAAAAAYAAAAAAAAAG6VuImRbH9PtvcxDe3eE83CgAAAEAAAACjH0mZPNU9Bo495x+JG2G8BAAAAAA==@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix a spelling typo in the comment in pgtable-2level.h.

Signed-off-by: Hyuk Myeong <hyuk.myeong@lge.com>
---
 arch/arm/include/asm/pgtable-2level.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/pgtable-2level.h
b/arch/arm/include/asm/pgtable-2level.h
index bfd662e..49f91be 100644
--- a/arch/arm/include/asm/pgtable-2level.h
+++ b/arch/arm/include/asm/pgtable-2level.h
@@ -66,7 +66,7 @@
  *
  * However, when the "young" bit is cleared, we deny access to the page
  * by clearing the hardware PTE.  Currently Linux does not flush the TLB
- * for us in this case, which means the TLB will retain the transation
+ * for us in this case, which means the TLB will retain the translation
  * until either the TLB entry is evicted under pressure, or a context
  * switch which changes the user space mapping occurs.
  */
--
1.9.3
