From: jj@chaosbits.net (Jesper Juhl)
Date: Tue, 15 Mar 2011 01:14:14 +0100 (CET)
Subject: [PATCH][Trivial] ARM: Remove duplicate linux/sched.h include from
	arch/arm/plat-iop/time.c
Message-ID: <alpine.LNX.2.00.1103150108510.26293@swampdragon.chaosbits.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need to include linux/sched.h more than once 
in arch/arm/plat-iop/time.c

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 time.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/plat-iop/time.c b/arch/arm/plat-iop/time.c
index 07f23bb..7cdc516 100644
--- a/arch/arm/plat-iop/time.c
+++ b/arch/arm/plat-iop/time.c
@@ -17,7 +17,6 @@
 #include <linux/interrupt.h>
 #include <linux/time.h>
 #include <linux/init.h>
-#include <linux/sched.h>
 #include <linux/timex.h>
 #include <linux/sched.h>
 #include <linux/io.h>


-- 
Jesper Juhl <jj@chaosbits.net>            http://www.chaosbits.net/
Plain text mails only, please.
Don't top-post http://www.catb.org/~esr/jargon/html/T/top-post.html
