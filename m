From: jj@chaosbits.net (Jesper Juhl)
Date: Sun, 7 Nov 2010 23:15:41 +0100 (CET)
Subject: [PATCH][trivial] ARM, mm: Don't include smp_plat.h twice in
 flush.c
Message-ID: <alpine.LNX.2.00.1011072312490.26247@swampdragon.chaosbits.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's enough to include the asm/smp_plat.h once in arch/arm/mm/flush.c

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 flush.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mm/flush.c b/arch/arm/mm/flush.c
index 391ffae..7d6e92b 100644
--- a/arch/arm/mm/flush.c
+++ b/arch/arm/mm/flush.c
@@ -17,7 +17,6 @@
 #include <asm/smp_plat.h>
 #include <asm/system.h>
 #include <asm/tlbflush.h>
-#include <asm/smp_plat.h>
 
 #include "mm.h"
 

-- 
Jesper Juhl <jj@chaosbits.net>             http://www.chaosbits.net/
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please.
