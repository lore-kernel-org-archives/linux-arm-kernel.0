From: jj@chaosbits.net (Jesper Juhl)
Date: Sun, 5 Feb 2012 01:18:31 +0100 (CET)
Subject: [PATCH] Only include linux/sched.h once in arch/arm/mach-bcmring/dma.c
Message-ID: <alpine.LNX.2.00.1202050116190.30244@swampdragon.chaosbits.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's no need to include the header twice.

Signed-off-by: Jesper Juhl <jj@chaosbits.net>
---
 arch/arm/mach-bcmring/dma.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-bcmring/dma.c b/arch/arm/mach-bcmring/dma.c
index 1024396..e5fd241 100644
--- a/arch/arm/mach-bcmring/dma.c
+++ b/arch/arm/mach-bcmring/dma.c
@@ -35,7 +35,6 @@
 
 #include <linux/pfn.h>
 #include <linux/atomic.h>
-#include <linux/sched.h>
 #include <mach/dma.h>
 
 /* ---- Public Variables ------------------------------------------------- */
-- 
1.7.9


-- 
Jesper Juhl <jj@chaosbits.net>       http://www.chaosbits.net/
Don't top-post http://www.catb.org/jargon/html/T/top-post.html
Plain text mails only, please.
