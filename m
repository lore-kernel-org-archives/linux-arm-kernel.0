From: hyuk.myeong@lge.com (=?ks_c_5601-1987?B?uO3H9Q==?=)
Date: Tue, 2 Jun 2015 19:05:38 +0900
Subject: [PATCH] Fix typo in the comment
Message-ID: <010901d09d1b$acfdb3d0$06f91b70$@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix a spelling typo in the comment in pgtable-2level.h

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
+ * for us in this case, which means the TLB will retain the transaction
  * until either the TLB entry is evicted under pressure, or a context
  * switch which changes the user space mapping occurs.
*/
--
Kernel Version : v4.1-rc6-1-g23e19b1
