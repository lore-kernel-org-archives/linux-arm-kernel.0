From: danny.kukawka@bisect.de (Danny Kukawka)
Date: Thu, 16 Feb 2012 15:45:58 +0100
Subject: [PATCH] arch/arm/mach-bcmring/dma.c: included linux/sched.h twice
Message-ID: <1329403558-32661-1-git-send-email-danny.kukawka@bisect.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-bcmring/dma.c included 'linux/sched.h' twice,
remove the duplicates.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
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
1.7.8.3
